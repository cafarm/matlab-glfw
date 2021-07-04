function glfwSetInputMode(window, mode, value)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    mode (1,1) int32
    value (1,1) int32
end
calllibglfw("glfwSetInputMode", window, mode, value);
end
