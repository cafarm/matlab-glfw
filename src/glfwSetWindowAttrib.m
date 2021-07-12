function glfwSetWindowAttrib(window, attrib, value)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    attrib (1,1) int32
    value (1,1) int32
end
calllibglfw("glfwSetWindowAttrib", libpointer(window), attrib, value);
end
