function glfwSetWindowPos(window, xpos, ypos)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    xpos (1,1) int32
    ypos (1,1) int32
end
calllibglfw("glfwSetWindowPos", libpointer(window), xpos, ypos);
end
