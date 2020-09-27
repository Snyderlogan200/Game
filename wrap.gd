extends Node

# Expose a Rectangle area to the tool, so that it can be defined
export (Rect2) var wrapArea = null

# Expose two flags to determine which axes shall be wrapped; both defaulted true
export (bool) var horizontalWrapping = true
export (bool) var verticalWrapping = true

# Dictionary of axis directions
var AXIS = {
	HORIZONTAL = "x",
	VERTICAL = "y"
}

# Initialise the wrap area to screen size if not set
func initWrapArea():
	if wrapArea == null:
		wrapArea = Rect2(Vector2(), get_viewport().size)

# Recalculate the wrap area again. Call whenever the window size is changed.
func recalculate_wrap_area():
	wrapArea = Rect2(Vector2(), get_viewport().size)

# When node ready, set the inital wrap area if not set
func _ready():
	initWrapArea()
	add_to_group("wrap_around")

# Check whether the parent object is NOT in the wrap area,
# call the wrap function if it isn't
func _process(delta):
	if !wrapArea.has_point(get_parent().global_position):
		wrap()

# The parent Node is NOT in wrap area, so it must be wrapped
# around until it is
func wrap():
	# If horizontal wrapping is enabled
	if horizontalWrapping:
		# Wrap by the horizontal axis
		wrapBy(AXIS.HORIZONTAL)
	# If vertical wrapping is enabled
	if verticalWrapping:
		# Wrap by the vertical axis
		wrapBy(AXIS.VERTICAL)


#
func getAxisWrapDirection(axis):
	if get_parent().global_position[axis] < wrapArea.position[axis]:
		# off left/top therefore we want to add width or height
		return 1
	elif get_parent().global_position[axis] > wrapArea.size[axis]:
		# off left/top therefore we want to subtract width or height
		return -1
	return 0

# Perform the wrap on the parent object
func wrapBy(axis):
	# Calculate the axis adjustment required
	# I.e. get axis wrap direction and multiply by axis size
	var adjust = getAxisWrapDirection(axis) * wrapArea.size[axis]
	# Apply the adjustment to the parent's position
	get_parent().position[axis] += adjust

