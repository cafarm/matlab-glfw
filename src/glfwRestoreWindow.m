function glfwRestoreWindow(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwRestoreWindow", libpointer(window));
end
