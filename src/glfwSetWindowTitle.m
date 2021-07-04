function glfwSetWindowTitle(window, title)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    title (1,1) string
end
calllibglfw("glfwSetWindowTitle", window, char(title));
end
