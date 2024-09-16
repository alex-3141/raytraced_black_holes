	color = clamp(color + vec3(RBH_bloom), 0.0, 1.0);
	vec4 RBH_overlay = texture2D(RBH_tex_overlay, tex_coord_);
	color = mix(color, RBH_overlay.rgb, RBH_overlay.a);
	color = mix( color, overlay_color.rgb, (1.0 - RBH_live_editing.x) * overlay_color.a );