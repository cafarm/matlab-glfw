function glfwSetWindowAspectRatio(window, numer, denom)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
    numer (1,1) int32
    denom (1,1) int32
end
calllibglfw("glfwSetWindowAspectRatio", libpointer(window), numer, denom);
end
