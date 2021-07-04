function state = glfwGetMouseButton(window, button)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
    button (1,1) int32
end
state = calllibglfw("glfwGetMouseButton", window, button);
state = double(state);
end
