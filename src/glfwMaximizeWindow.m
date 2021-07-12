function glfwMaximizeWindow(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwMaximizeWindow", libpointer(window));
end
