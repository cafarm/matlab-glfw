function glfwHideWindow(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
calllibglfw("glfwHideWindow", window);
end
