function glfwSetCursor(window, cursor)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
    cursor (1,1) {mustBeA(cursor,"GLFWcursor")} = GLFWcursor()
end
calllibglfw("glfwSetCursor", libpointer(window), libpointer(cursor));
end
