function glfwMakeContextCurrent(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
end
calllibglfw("glfwMakeContextCurrent", window);
end