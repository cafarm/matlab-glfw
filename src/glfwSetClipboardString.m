function glfwSetClipboardString(str, window)
arguments
    str (1,1) string
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")} = libpointer("GLFWwindowPtr")
end
calllibglfw("glfwSetClipboardString", window, char(str));
end
