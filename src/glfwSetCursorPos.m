function glfwSetCursorPos(window, xpos, ypos)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
    xpos (1,1) double
    ypos (1,1) double
end
calllibglfw("glfwSetCursorPos", window, xpos, ypos);
end
