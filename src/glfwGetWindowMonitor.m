function monitor = glfwGetWindowMonitor(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
monitor = calllibglfw("glfwGetWindowMonitor", window);
end
