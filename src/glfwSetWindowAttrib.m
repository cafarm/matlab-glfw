function glfwSetWindowAttrib(window, attrib, value)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    attrib (1,1) int32
    value (1,1) int32
end
calllibglfw("glfwSetWindowAttrib", window, attrib, value);
end
