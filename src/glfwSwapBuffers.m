function glfwSwapBuffers(window)
arguments
    window (1,1) {mustBeLibPointer}
end
calllib("libglfw", "glfwSwapBuffers", window);
end