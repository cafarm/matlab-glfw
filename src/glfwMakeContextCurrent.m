function glfwMakeContextCurrent(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
end
calllibglfw("glfwMakeContextCurrent", libpointer(window));
end