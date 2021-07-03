function value = glfwGetInputMode(window, mode)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
    mode (1,1) int32
end
value = calllibglfw("glfwGetInputMode", window, mode);
end
