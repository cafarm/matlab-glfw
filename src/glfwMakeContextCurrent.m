function glfwMakeContextCurrent(window)
arguments
    window (1,1) {mustBeLibPointer}
end
calllibglfw("glfwMakeContextCurrent", window);
end