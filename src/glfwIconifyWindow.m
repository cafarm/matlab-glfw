function glfwIconifyWindow(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwIconifyWindow", libpointer(window));
end
