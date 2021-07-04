function glfwSetWindowPos(window, xpos, ypos)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
    xpos (1,1) int32
    ypos (1,1) int32
end
calllibglfw("glfwSetWindowPos", window, xpos, ypos);
end
