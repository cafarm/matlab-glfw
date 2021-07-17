function glfwSetWindowMonitor(window, monitor, xpos, ypos, width, height, refreshRate)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor")}
    xpos (1,1) int32
    ypos (1,1) int32
    width (1,1) int32
    height (1,1) int32
    refreshRate (1,1) int32
end
calllibglfw("glfwSetWindowMonitor", libpointer(window), libpointer(monitor), xpos, ypos, width, height, refreshRate);
end
