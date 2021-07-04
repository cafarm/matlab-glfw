function glfwShowWindow(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
end
calllibglfw("glfwShowWindow", window);
end
