function glfwSetWindowShouldClose(window, value)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    value (1,1) int32
end
calllibglfw("glfwSetWindowShouldClose", window, value);
end
