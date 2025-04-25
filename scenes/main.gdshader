shader_type spatial;
render_mode blend_mix;

uniform vec4 fog_color : source_color = vec4(0.5, 0.5, 0.5, 1.0);
uniform float near_distance = 1.0;  // Objects closer than this are fully visible
uniform float far_distance = 8.0;   // Objects further than this are fully hidden
uniform float density = 1.5;        // Controls how quickly visibility falls off

void fragment() {
    // Calculate world position and distance from viewer
    float depth = texture(DEPTH_TEXTURE, SCREEN_UV).r;
    vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth);
    vec4 world = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
    world.xyz /= world.w;
    float distance = length(world.xyz);
    
    // Calculate fog factor
    float fog_factor = clamp((distance - near_distance) / (far_distance - near_distance), 0.0, 1.0);
    fog_factor = pow(fog_factor, density);
    
    // Mix fog with scene
    ALBEDO = mix(ALBEDO, fog_color.rgb, fog_factor);
    ALPHA = mix(ALPHA, 1.0, fog_factor);
}