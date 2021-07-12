function glfwSetWindowShouldClose(window, value)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
    value (1,1) int32
end
calllibglfw("glfwSetWindowShouldClose", libpointer(window), value);
end
