function glfwSetWindowAspectRatio(window, numer, denom)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    numer (1,1) int32
    denom (1,1) int32
end
calllibglfw("glfwSetWindowAspectRatio", window, numer, denom);
end
