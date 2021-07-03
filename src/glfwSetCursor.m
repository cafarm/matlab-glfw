function glfwSetCursor(window, cursor)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
    cursor (1,1) {mustBeLibPointer(cursor,"GLFWcursorPtr")}
end
calllibglfw("glfwSetCursor", window, cursor);
end
