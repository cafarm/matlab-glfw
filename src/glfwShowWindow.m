function glfwShowWindow(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwShowWindow", libpointer(window));
end
