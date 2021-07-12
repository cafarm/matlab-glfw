function glfwRequestWindowAttention(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwRequestWindowAttention", libpointer(window));
end
