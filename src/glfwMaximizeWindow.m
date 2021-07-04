function glfwMaximizeWindow(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
end
calllibglfw("glfwMaximizeWindow", window);
end
