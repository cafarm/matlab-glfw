function glfwSetWindowTitle(window, title)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    title (1,1) string
end
calllibglfw("glfwSetWindowTitle", libpointer(window), char(title));
end
