function glfwSetCursorPos(window, xpos, ypos)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    xpos (1,1) double
    ypos (1,1) double
end
calllibglfw("glfwSetCursorPos", window, xpos, ypos);
end
