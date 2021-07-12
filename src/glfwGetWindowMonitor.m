function monitor = glfwGetWindowMonitor(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
monitor = calllibglfw("glfwGetWindowMonitor", libpointer(window));
monitor = GLFWmonitor(monitor);
end
