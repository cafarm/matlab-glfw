function glfwSetWindowUserPointer(window, pointer)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
    pointer (1,1) {mustBeLibPointer(pointer,"voidPtr")}
end
calllibglfw("glfwSetWindowUserPointer", window, pointer);
end
