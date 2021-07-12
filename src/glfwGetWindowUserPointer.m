function pointer = glfwGetWindowUserPointer(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
pointer = calllibglfw("glfwGetWindowUserPointer", libpointer(window));
end
