function pointer = glfwGetWindowUserPointer(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
pointer = calllibglfw("glfwGetWindowUserPointer", window);
end
