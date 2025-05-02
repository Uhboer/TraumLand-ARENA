shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform vec2 resolution = vec2(320.0, 180.0);
uniform float scan_line_amount : hint_range(0.0, 1.0) = 0.1;
uniform float warp_amount : hint_range(0.0, 5.0) = 0.05;
uniform float edge_intensity : hint_range(0.0, 5.0) = 2.0;
uniform float vignette_amount : hint_range(0.0, 1.0) = 0.5;
uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.3;
uniform float grille_amount : hint_range(0.0, 1.0) = 0.05;
uniform float brightness_boost : hint_range(1.0, 2.0) = 1.2;
uniform float edge_protection : hint_range(0.0, 0.2) = 0.05;

void fragment() {
    // Scale UV to create a safe area inside the visible region
    // This prevents sampling outside the texture at the edges
    vec2 safe_uv = SCREEN_UV * (1.0 - 2.0 * edge_protection) + vec2(edge_protection);

    // Apply warp to the safe area UVs
    vec2 delta = safe_uv - 0.5;
    float warp_factor = dot(delta, delta) * warp_amount;

    // Edge enhancement with smoother transition
    vec2 delta_abs = abs(delta) * 2.0;
    float edge_factor = pow(max(delta_abs.x, delta_abs.y), edge_intensity);

    // Apply smoothed warp
    vec2 warped_uv = safe_uv + delta * (warp_factor + edge_factor * warp_amount);

    // Smooth fade-out at edges to hide artifacts
    float edge_x = min(warped_uv.x, 1.0 - warped_uv.x) / edge_protection;
    float edge_y = min(warped_uv.y, 1.0 - warped_uv.y) / edge_protection;
    float edge_fade = min(min(edge_x, edge_y), 1.0);

    // Apply scanline effect
    float scanline = sin(warped_uv.y * resolution.y * PI) * 0.5 + 0.5;
    scanline = mix(1.0, scanline, scan_line_amount * 0.5);

    // Apply aperture grille effect
    float grille = mod(warped_uv.x * resolution.x, 3.0) < 1.5 ? 0.95 : 1.05;
    grille = mix(1.0, grille, grille_amount * 0.5);

    // Sample the texture with clamping to avoid artifacts
    vec3 color = texture(SCREEN_TEXTURE, clamp(warped_uv, vec2(0.0), vec2(1.0))).rgb;

    // Apply effects
    color *= scanline * grille;

    // Apply vignette
    vec2 v_uv = warped_uv * (1.0 - warped_uv.xy);
    float vignette = v_uv.x * v_uv.y * 15.0;
    vignette = mix(1.0, vignette, vignette_amount * 0.7);
    color *= vignette * brightness_boost;

    // Fade out color at edges to hide distortion
    color *= edge_fade;

    COLOR.rgb = color;
    COLOR.a = 1.0;
}