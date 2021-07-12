function value = glfwGetInputMode(window, mode)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    mode (1,1) int32
end
value = calllibglfw("glfwGetInputMode", libpointer(window), mode);
value = double(value);
end
