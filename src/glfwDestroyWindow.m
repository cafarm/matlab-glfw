function glfwDestroyWindow(window)
arguments
    window (1,1) {mustBeLibPointer}
end
calllibglfw("glfwDestroyWindow", window);
end