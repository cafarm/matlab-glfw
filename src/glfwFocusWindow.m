function glfwFocusWindow(window)
arguments
    window (1,1) {mustBeLibPointer}
end
calllibglfw("glfwFocusWindow", window);
end
