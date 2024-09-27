#define RBH_PI  3.14159265358979323846	
#define RBH_DEPTH 0.6
#define MAX_DISC_SAMPLES 8
// Magic constant blessed upon us by the gods
#define RBH_fog_scale_factor vec2(-0.21, 0.12)

uniform vec4 RBH_disc_bloom_intensity;
uniform vec4 RBH_white_hole_bloom_intensity;
uniform vec4 RBH_count;
uniform vec4 RBH_warp_scale;
uniform vec4 RBH_steps;
uniform vec4 RBH_disc_threshold;
uniform vec4 RBH_discs_enabled;
uniform vec4 RBH_disk_opacity;
uniform vec4 RBH_invert_white_holes;
uniform vec4 RBH_max;

uniform vec4 RBH_live_editing;
uniform sampler2D RBH_tex_overlay;

__uniforms__
__uniforms_disc__

float RBH_bloom = 0;
float RBH_deflectionMagnitude = 0.0;
int RBH_MAX_HOLES = int(min(RBH_max.x, RBH_count.w));
int RBH_MAX_DISCS = int(RBH_discs_enabled.x * min(RBH_max.x, RBH_count.z));
int RBH_disc_samples = 0;

float torusDistance(vec3 point, vec3 torusNormal, float torusRadius){
	// A bunch of maths
	vec3 randomVec = vec3(1.0, 0.0, 0.0);
	vec3 rightVec = normalize(cross(torusNormal, randomVec));
	vec3 upVec = cross(torusNormal, rightVec);
	mat3 rotMat = mat3(rightVec, upVec, torusNormal);
	mat3 invRotMat = transpose(rotMat);
	vec3 rotatedPoint = invRotMat * point;
	// + 0.1 to smooth out the edges.
	float testDistance = length(vec2(length(rotatedPoint.xy) - torusRadius, rotatedPoint.z)) + 0.1;
	return testDistance;
}

float getAccretionDiscBloom(vec3 point, vec3 discNormal, float blackHoleMass){
	float dist = torusDistance(point, discNormal, blackHoleMass * 3.0);
	float discBloom = 1.0 - (pow( 1.0/RBH_disc_bloom_intensity.x * dist, RBH_disc_bloom_intensity.x * 0.15));
	discBloom = clamp(discBloom, 0.0, 1.0);
	return discBloom;
}

vec4 blendColor(vec4 color, vec4 newColor){
	color.rgb += (1.0 - color.a) * newColor.a * newColor.rgb;
	color.a += (1.0 - color.a) * newColor.a;
	return color;
}

float rayIntersectsDisc(vec3 rayPos, vec3 rayVel, vec3 planePoint, vec3 planeNormal, out vec3 intersectionPoint) {
    float denom = dot(planeNormal, rayVel);
    float absDenom = abs(denom);
    float denomThreshold = step(0.0001, absDenom);

    vec3 p0l0 = planePoint - rayPos;
    float t = dot(p0l0, planeNormal) / (denom + (1.0 - denomThreshold));
    float tValid = step(0.0, t) * step(t, 1.0);

    intersectionPoint = rayPos + t * rayVel;
    return denomThreshold * tValid;
}

vec3 getRayIntersectsPlanePoint(vec3 rayPos, vec3 rayVel, vec3 planePoint, vec3 planeNormal) {
    float denom = dot(planeNormal, rayVel);
    float absDenom = abs(denom);
    float denomThreshold = step(0.0001, absDenom);

    vec3 p0l0 = planePoint - rayPos;
    float t = dot(p0l0, planeNormal) / (denom + (1.0 - denomThreshold));
    float tValid = step(0.0, t) * step(t, 1.0);

    vec3 intersectionPoint = rayPos + t * rayVel;
    return mix(vec3(0.0), intersectionPoint, denomThreshold * tValid);
}

float bounce(float x) {
	float y = mod(x, 2.0);
	return y > 1.0 ? 2.0 - y : y;
}

float wrap(float x){
	return mod(x, 1.0);
}

float angleBetweenPointAndVector(vec3 point, vec3 vector) {
	vec3 normPoint = normalize(point);
	vec3 normVector = normalize(vector);
	float angle = acos(dot(normPoint, normVector));
	return mod(angle / RBH_PI, 1.0);
}


#define CALC_SAFE_DIST(i) if(RBH_MAX_HOLES <= i) break;float dist##i = distance(rayPos, vec3(RBH_##i.x, RBH_##i.y, 0.0));smallest = min(smallest, RBH_##i.z);crossedEH = crossedEH || (dist##i - RBH_##i.z <= 0.0 && RBH_##i.w < 1.0);minDist = min(minDist, dist##i);BHglow = max(BHglow, (1.0 - RBH_##i.w) * 0.1 * smoothstep(0.005, 0.0, dist##i*dist##i));whBloom += RBH_##i.w * 12.0 * (RBH_##i.z*RBH_##i.z) / (dist##i*dist##i);

float findSafeStepSize(vec3 rayPos, vec3 rayVel, out bool crossedEH, inout float bloom, inout float BHglow){
	crossedEH = false;
	float whBloom = 0.0;
	float smallest = 0.02;

	float minDist = RBH_DEPTH / 2.0;

	while(true){
		__safestep__
		break;
	}

	bloom = max(bloom, pow(whBloom, 1.0 / max(RBH_white_hole_bloom_intensity.x, 0.05)));
	return max(minDist, smallest);
}

#define CALC_ACCELERATION(i) if(RBH_MAX_HOLES <= i) break;vec3 BH##i = vec3(RBH_##i.x, RBH_##i.y, 0.0) - rayPos;acceleration += (RBH_##i.z / dot(BH##i, BH##i)) * (RBH_##i.w * -RBH_invert_white_holes.x * 2.0 + 1.0) * normalize(BH##i);

vec3 sumAcceleration(vec3 rayPos){
	vec3 acceleration = vec3(0.0);

	while(true){
		__acceleration__
		break;
	}

	return acceleration * RBH_warp_scale.x;
}

#define RBH_STEP rk4Step
#define sampleField sumAcceleration

void rk4Step(inout vec3 pos, inout vec3 vel, float dt) {
	vec3 k1_v = sampleField(pos) * dt;
	vec3 k1_p = vel * dt;

	vec3 v2 = normalize(vel + 0.5 * k1_v);
	vec3 k2_v = sampleField(pos + 0.5 * k1_p) * dt;
	vec3 k2_p = v2 * dt;

	vec3 v3 = normalize(vel + 0.5 * k2_v);
	vec3 k3_v = sampleField(pos + 0.5 * k2_p) * dt;
	vec3 k3_p = v3 * dt;

	vec3 v4 = normalize(vel + k3_v);
	vec3 k4_v = sampleField(pos + k3_p) * dt;
	vec3 k4_p = v4 * dt;

	// Combine results
	pos = pos + (k1_p + 2.0 * k2_p + 2.0 * k3_p + k4_p) / 6.0;

	vec3 velDelta = (k1_v + 2.0 * k2_v + 2.0 * k3_v + k4_v) / 6.0;
	vec3 newVel = vel + velDelta;
	
	vel = normalize(newVel);
}

vec4 renderAccretionDisc(vec3 rayToBH, vec3 discNormal, float mass){
	#define AA 0.04
	float ISCO = mass * 3.0;

	float dist = length(rayToBH);
   
	float brightness = mix(1.0, 0.0, (dist - ISCO) / (ISCO * 3.0)) * 1.5;
	brightness = mix(0.0, brightness, smoothstep(ISCO, ISCO + AA, dist));

	vec3 discSeam = cross(discNormal, vec3(0.0, 1.0, 0.0));
	vec3 projectedPoint = rayToBH - dot(discNormal, rayToBH) * discNormal;

	// Find angle between projected point and disc seam
	float angle = angleBetweenPointAndVector(projectedPoint, discSeam);
	float sign = dot(cross(discSeam, rayToBH), discNormal) >= 0.0 ? 1.0 : -1.0;
	angle = (angle * sign + 1.0) / 2.0;
	
	float rotationalVelocitySquared = ISCO / dist;
	float rotationalVelocity = sqrt(rotationalVelocitySquared);

	// Get texture coords
	vec2 textureCoords = vec2(
		angle - rotationalVelocity,
		0.25 / rotationalVelocity + time/4.0
	);

	// Generate disc color
	vec3 lightColor = vec3(254.0/255.0, 128.0/255.0, 3.0/255.0);
	vec3 darkColor = vec3(255.0/255.0, 70.0/255.0, 0.0/255.0);
	float colorFlux = (pow(textureLod(tex_perlin_noise, textureCoords, 3).rgb, vec3(2.2)) * 2.0).r;
	vec3 diskColor = mix(lightColor, darkColor, colorFlux);

	// Apply noise to the accretion disk color
	float noiseValue = textureLod(tex_perlin_noise, textureCoords, 3).r;
	noiseValue = (noiseValue - 0.5) / 2.0 + 1.0;

	// Whiten disk color the closer it is to the center
	float whiteness = smoothstep(0.0, 1.0, rotationalVelocitySquared);
	diskColor = mix(diskColor, vec3(1.0), whiteness);

	return vec4(diskColor, clamp(noiseValue * brightness, 0.0, 1.0));
}

#define RENDER_DISC(i) \
if(RBH_MAX_DISCS <= i) break; \
seedTime = RBH_DISC_##i.w + time; \
discNormal = normalize(vec3(sin(seedTime/3.0) * 0.4, 1.0, -0.15 + cos(seedTime/5.0) * 0.2)); \
discPos = vec3(RBH_DISC_##i.x, RBH_DISC_##i.y, 0.0); \
discOpacity = RBH_disk_opacity.x * clamp((RBH_DISC_##i.z - thresholdLow) / (thresholdHigh - thresholdLow), 0.0, 1.0); \
bloom = max(bloom, discOpacity * getAccretionDiscBloom(rayPos - discPos, discNormal, RBH_DISC_##i.z)); \
discIntersectionPoint = vec3(0.0); \
intersect = rayIntersectsDisc(rayPos, lastRayPos - rayPos, discPos, discNormal, discIntersectionPoint); \
if(intersect > 0.0){ \
color = blendColor(color, deflectionFactor * intersect * discOpacity * renderAccretionDisc(discIntersectionPoint - discPos, discNormal, RBH_DISC_##i.z)); \
}

void renderAccretionDiscs(inout vec4 color, inout float bloom, vec3 rayPos, vec3 lastRayPos){
	float seedTime = 0.0;
	vec3 discNormal = vec3(0.0);
	vec3 discPos = vec3(0.0);
	float discOpacity = 0.0;
	float thresholdLow = RBH_disc_threshold.x;
	float thresholdHigh = RBH_disc_threshold.y;
	vec3 discIntersectionPoint = vec3(0.0);
	vec4 discColor = vec4(0.0);
	float deflectionFactor = clamp( step(RBH_deflectionMagnitude, 6.0) * (3.0 - RBH_deflectionMagnitude), 0.0, 1.0);
	float intersect = 0.0;
	while(true){
		__render_disc__
		break;
	}
}

