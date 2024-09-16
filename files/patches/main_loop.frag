        vec3 RBH_aspectRatio = vec3(world_viewport_size.x / world_viewport_size.y, 1.0, 1.0);
	vec2 RBH_foregroundIntersect = tex_coord;
	vec3 RBH_background = vec3(0.0, 0.0, RBH_DEPTH);
	vec2 RBH_uv = gl_FragCoord.xy / world_viewport_size.xy;
	RBH_uv = tex_coord;
	RBH_uv *= RBH_aspectRatio.xy;
	vec3 RBH_rayOrigin = vec3(RBH_uv, -RBH_DEPTH);
	vec3 RBH_rayPos = RBH_rayOrigin;
	vec3 RBH_lastRayPos = RBH_rayOrigin;;
	vec3 RBH_rayVel = vec3(0.0, 0.0, 1.0);
	vec3 RBH_lastRayVel = RBH_rayVel;
	vec4 RBH_effectColor = vec4(0.0);
	bool RBH_hasCrossedEventHorizon = false;
	vec4 RBH_noGlow = vec4(0.0);
	float RBH_BHglow = 0.0;

	if( RBH_count.w > 0.0){

		// Render front edge of disc that falls outside render area
		if(RBH_MAX_DISCS > 0) renderAccretionDiscs(RBH_effectColor, RBH_bloom, RBH_rayOrigin, RBH_rayOrigin - vec3(0.0, 0.0, 10.0));

		int i = 0;

		while(i++ < int(RBH_steps.x)) {
			vec4 hitColor = vec4(0.0, 0.0, 0.0, 0.0);
			vec3 acceleration = vec3(0.0);
			vec4 diskColor = vec4(0.0);

			float stepSize = findSafeStepSize(RBH_rayPos, RBH_rayVel, RBH_hasCrossedEventHorizon, RBH_bloom, RBH_BHglow);
			
			// Render accretion disks
			if(RBH_MAX_DISCS > 0) renderAccretionDiscs(RBH_effectColor, RBH_bloom, RBH_rayPos, RBH_lastRayPos);

			// Crossed event horizon
			if(RBH_hasCrossedEventHorizon){
				RBH_effectColor = blendColor(RBH_effectColor, vec4(0.0,0.0,0.0,1.0));
				RBH_noGlow = vec4(0.0,0.0,0.0,1.0);
				break;
			} else {
				RBH_lastRayPos = RBH_rayPos;
				RBH_lastRayVel = RBH_rayVel;
				RBH_STEP(RBH_rayPos, RBH_rayVel, stepSize);
				RBH_deflectionMagnitude += (1.0 - dot(RBH_rayVel, RBH_lastRayVel));
			}

			// Hit background
			if( RBH_rayPos.z > RBH_background.z ) {
				// Render back edge of disc that falls outside render area
				if(RBH_MAX_DISCS > 0) renderAccretionDiscs(RBH_effectColor, RBH_bloom, RBH_rayPos + RBH_rayVel * 10.0, RBH_lastRayPos);

				RBH_foregroundIntersect = getRayIntersectsPlanePoint(RBH_lastRayPos, RBH_lastRayVel, RBH_background, vec3(0.0, 0.0, 1.0)).xy;
				RBH_foregroundIntersect /= RBH_aspectRatio.xy;

				// Texture wrapping
				#define WRAPPER bounce
				RBH_foregroundIntersect = vec2(WRAPPER(RBH_foregroundIntersect.x), WRAPPER(RBH_foregroundIntersect.y));
				RBH_foregroundIntersect = clamp(RBH_foregroundIntersect, 0.002, 1.0 - 0.002);

				tex_coord = RBH_foregroundIntersect;
				tex_coord_y_inverted = vec2(RBH_foregroundIntersect.x, 1.0 - RBH_foregroundIntersect.y);
				tex_coord_glow = vec2(RBH_foregroundIntersect.x, 1.0 - RBH_foregroundIntersect.y);
				break;

			}

		}
		
		if(i > int(RBH_steps.x)){
			RBH_effectColor = blendColor(RBH_effectColor, vec4(0.0, 0.0, 0.0, 1.0));
			RBH_noGlow = vec4(0.0,0.0,0.0,1.0);
		}
	}

	RBH_bloom = clamp(RBH_bloom, 0.0, 1.0);
