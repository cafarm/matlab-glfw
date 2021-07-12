function glfwSetWindowUserPointer(window, pointer)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    pointer (1,1) {mustBeLibPointer}
end
calllibglfw("glfwSetWindowUserPointer", libpointer(window), pointer);
end
