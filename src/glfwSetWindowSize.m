function glfwSetWindowSize(window, width, height)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    width (1,1) int32
    height (1,1) int32
end
calllibglfw("glfwSetWindowSize", libpointer(window), width, height);
end
