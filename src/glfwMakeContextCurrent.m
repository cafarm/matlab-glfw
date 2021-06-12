function glfwMakeContextCurrent(window)
arguments
    window (1,1) {mustBeLibPointer}
end
calllib("libglfw", "glfwMakeContextCurrent", window);
end