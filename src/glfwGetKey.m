function state = glfwGetKey(window, key)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
    key (1,1) int32
end
state = calllibglfw("glfwGetKey", libpointer(window), key);
state = double(state);
end
