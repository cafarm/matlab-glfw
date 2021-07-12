function opacity = glfwGetWindowOpacity(window)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
end
opacity = calllibglfw("glfwGetWindowOpacity", libpointer(window));
opacity = double(opacity);
end
