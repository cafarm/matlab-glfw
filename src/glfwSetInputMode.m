function glfwSetInputMode(window, mode, value)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
    mode (1,1) int32
    value (1,1) int32
end
calllibglfw("glfwSetInputMode", libpointer(window), mode, value);
end
