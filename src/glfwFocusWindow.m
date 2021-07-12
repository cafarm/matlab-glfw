function glfwFocusWindow(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwFocusWindow", libpointer(window));
end
