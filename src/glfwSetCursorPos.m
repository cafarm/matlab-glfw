function glfwSetCursorPos(window, xpos, ypos)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
    xpos (1,1) double
    ypos (1,1) double
end
calllibglfw("glfwSetCursorPos", libpointer(window), xpos, ypos);
end
