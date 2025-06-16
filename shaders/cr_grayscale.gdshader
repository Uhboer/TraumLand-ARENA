shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float intensity : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
    float gray = (color.r + color.g + color.b) / 3.0;
    COLOR = vec4(mix(color.rgb, vec3(gray), intensity), color.a);
}