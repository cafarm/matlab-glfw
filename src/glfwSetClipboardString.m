function glfwSetClipboardString(str, window)
arguments
    str (1,1) string
    window (1,1) {mustBeA(window,"GLFWwindow")} = GLFWwindow()
end
calllibglfw("glfwSetClipboardString", libpointer(window), char(str));
end
