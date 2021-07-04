function glfwSetClipboardString(window, str)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
    str (1,1) string
end
calllibglfw("glfwSetClipboardString", window, char(str));
end
