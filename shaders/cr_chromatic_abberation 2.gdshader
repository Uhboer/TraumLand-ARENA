// Chromatic Aberration (Improved)
shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform vec2 r_displacement = vec2(3.0, 0.0);
uniform vec2 g_displacement = vec2(0.0, 0.0);
uniform vec2 b_displacement = vec2(-3.0, 0.0);
uniform float intensity : hint_range(0.0, 10.0) = 1.0;

void fragment() {
    vec2 r_offset = SCREEN_PIXEL_SIZE * r_displacement * intensity;
    vec2 g_offset = SCREEN_PIXEL_SIZE * g_displacement * intensity;
    vec2 b_offset = SCREEN_PIXEL_SIZE * b_displacement * intensity;

    float r = texture(SCREEN_TEXTURE, SCREEN_UV + r_offset).r;
    float g = texture(SCREEN_TEXTURE, SCREEN_UV + g_offset).g;
    float b = texture(SCREEN_TEXTURE, SCREEN_UV + b_offset).b;

    COLOR = vec4(r, g, b, 1.0);
}