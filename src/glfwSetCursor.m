function glfwSetCursor(window, cursor)
arguments
    window (1,1) {mustBeClass(window,"GLFWwindow"), mustBeNonnull}
    cursor (1,1) {mustBeClass(cursor,"GLFWcursor")} = GLFWcursor()
end
calllibglfw("glfwSetCursor", libpointer(window), libpointer(cursor));
end
