function glfwIconifyWindow(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwIconifyWindow", libpointer(window));
end
