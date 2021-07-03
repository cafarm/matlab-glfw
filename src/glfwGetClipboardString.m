function contents = glfwGetClipboardString(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
contents = calllibglfw("glfwGetClipboardString", window);
contents = string(contents);
end
