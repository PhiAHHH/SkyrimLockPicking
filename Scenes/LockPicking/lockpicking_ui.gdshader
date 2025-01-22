shader_type canvas_item;

void vertex() {

}

void fragment() {
	COLOR = COLOR + vec4(0.0, 0.15, .1, 0.0f);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
