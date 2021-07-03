function glfwFocusWindow(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
calllibglfw("glfwFocusWindow", window);
end
