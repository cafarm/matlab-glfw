function contents = glfwGetClipboardString(window)
arguments
    window (1,1) {mustBeLibPointer}
end
contents = calllibglfw("glfwGetClipboardString", window);
contents = string(contents);
end
