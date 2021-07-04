function glfwSetWindowSize(window, width, height)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    width (1,1) int32
    height (1,1) int32
end
calllibglfw("glfwSetWindowSize", window, width, height);
end
