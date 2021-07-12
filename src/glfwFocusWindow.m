function glfwFocusWindow(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwFocusWindow", libpointer(window));
end
