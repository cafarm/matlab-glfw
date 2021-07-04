function glfwSetWindowUserPointer(window, pointer)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    pointer (1,1) {mustBeLibPointer}
end
calllibglfw("glfwSetWindowUserPointer", window, pointer);
end
