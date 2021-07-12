function glfwRequestWindowAttention(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwRequestWindowAttention", libpointer(window));
end
