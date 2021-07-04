function glfwRequestWindowAttention(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
calllibglfw("glfwRequestWindowAttention", window);
end
