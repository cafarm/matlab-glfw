function glfwHideWindow(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwHideWindow", libpointer(window));
end
