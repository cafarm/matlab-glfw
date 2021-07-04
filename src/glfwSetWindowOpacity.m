function glfwSetWindowOpacity(window, opacity)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    opacity (1,1) single
end
calllibglfw("glfwSetWindowOpacity", window, opacity);
end
