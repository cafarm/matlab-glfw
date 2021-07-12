function contents = glfwGetClipboardString(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow")} = GLFWwindow()
end
contents = calllibglfw("glfwGetClipboardString", libpointer(window));
contents = string(contents);
end
