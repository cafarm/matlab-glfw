function glfwDestroyWindow(window)
arguments
    window (1,1) {mustBeLibPointer}
end
calllib("libglfw", "glfwDestroyWindow", window);
end