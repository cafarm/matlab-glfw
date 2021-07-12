function glfwMaximizeWindow(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwMaximizeWindow", libpointer(window));
end
