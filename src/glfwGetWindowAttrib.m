function value = glfwGetWindowAttrib(window, attr)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
    attr (1,1) int32
end
value = calllibglfw("glfwGetWindowAttrib", libpointer(window), attr);
value = double(value);
end
