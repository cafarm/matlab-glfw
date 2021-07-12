function glfwSetWindowMonitor(window, xpos, ypos, width, height, refreshRate, monitor)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
    xpos (1,1) int32
    ypos (1,1) int32
    width (1,1) int32
    height (1,1) int32
    refreshRate (1,1) int32
    monitor (1,1) {mustBeA(monitor,"GLFWmonitor")} = GLFWmonitor()
end
calllibglfw("glfwSetWindowMonitor", libpointer(window), libpointer(monitor), xpos, ypos, width, height, refreshRate);
end
