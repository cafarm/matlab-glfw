function glfwSetWindowOpacity(window, opacity)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    opacity (1,1) single
end
calllibglfw("glfwSetWindowOpacity", libpointer(window), opacity);
end
