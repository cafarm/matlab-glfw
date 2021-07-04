function opacity = glfwGetWindowOpacity(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
end
opacity = calllibglfw("glfwGetWindowOpacity", window);
opacity = double(opacity);
end
