function state = glfwGetMouseButton(window, button)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
    button (1,1) int32
end
state = calllibglfw("glfwGetMouseButton", libpointer(window), button);
state = double(state);
end
