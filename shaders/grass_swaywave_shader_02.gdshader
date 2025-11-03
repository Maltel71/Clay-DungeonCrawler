shader_type spatial;
render_mode cull_disabled, depth_draw_opaque;

uniform float sway_strength : hint_range(0.0, 2.0) = 0.5;
uniform float sway_speed : hint_range(0.0, 10.0) = 0.1;
uniform float sway_scale : hint_range(0.1, 5.0) = 0.5;
uniform float sway_height_max : hint_range(0.1, 5.0) = 1.0;
uniform float sway_height_offset : hint_range(0.0, 3.0) = 0.25;
uniform float wave_strength : hint_range(0.0, 3.0) = 1.5;
uniform float wave_speed : hint_range(0.0, 3.0) = 0.5;
uniform float wave_frequency : hint_range(0.01, 0.5) = 0.1;
uniform sampler2D albedo_texture;
uniform sampler2D alpha_cutout_texture;

varying vec2 vertex_uv;

void vertex() {
    vertex_uv = UV;
    
    // Use world position for height factor instead of UV
    vec3 world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    
    // Calculate height factor with offset and max range control
    float height_factor = (VERTEX.y - sway_height_offset) / sway_height_max;
    height_factor = clamp(height_factor, 0.0, 1.0); // Never exceed 100%
    
    // Your original individual sway motion with adjustable scale
    float sway_x = sin(TIME * sway_speed + world_pos.x * sway_scale) * sway_strength * height_factor;
    float sway_z = cos(TIME * sway_speed * 0.8 + world_pos.z * sway_scale * 0.6) * sway_strength * height_factor * 0.7;
    
    // Large sweeping wave - moves across the landscape
    float wave_progress = TIME * wave_speed + (world_pos.x + world_pos.z * 0.6) * wave_frequency;
    float large_wave = sin(wave_progress) * wave_strength * height_factor;
    
    // Apply both: individual sway + large wave (reduced tilt)
    VERTEX.x += sway_x + large_wave * 0.3;
    VERTEX.z += sway_z + large_wave * 0.15;
}

void fragment() {
    vec4 albedo = texture(albedo_texture, vertex_uv);
    float alpha_mask = texture(alpha_cutout_texture, vertex_uv).r;
    
    ALBEDO = albedo.rgb;
    ALPHA = albedo.a * alpha_mask;
    ROUGHNESS = 1.0;  // Fully rough, no shine
    
    // Use alpha scissor for proper depth sorting
    ALPHA_SCISSOR_THRESHOLD = 0.5;
}