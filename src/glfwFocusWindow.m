function glfwFocusWindow(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
end
calllibglfw("glfwFocusWindow", window);
end
