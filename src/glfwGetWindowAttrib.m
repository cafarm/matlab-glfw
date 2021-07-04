function value = glfwGetWindowAttrib(window, attr)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    attr (1,1) int32
end
value = calllibglfw("glfwGetWindowAttrib", window, attr);
value = double(value);
end
