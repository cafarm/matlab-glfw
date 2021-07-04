function glfwSetWindowMonitor(window, xpos, ypos, width, height, refreshRate, monitor)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    xpos (1,1) int32
    ypos (1,1) int32
    width (1,1) int32
    height (1,1) int32
    refreshRate (1,1) int32
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr")} = libpointer("GLFWmonitorPtr")
end
calllibglfw("glfwSetWindowMonitor", window, monitor, xpos, ypos, width, height, refreshRate);
end
