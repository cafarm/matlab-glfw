function glfwSwapBuffers(window)
arguments
    window (1,1) {mustBeLibPointer}
end
calllibglfw("glfwSwapBuffers", window);
end