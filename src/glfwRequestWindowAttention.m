function glfwRequestWindowAttention(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
end
calllibglfw("glfwRequestWindowAttention", window);
end
