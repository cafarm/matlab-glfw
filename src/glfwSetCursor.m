function glfwSetCursor(window, cursor)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    cursor (1,1) {mustBeLibPointer(cursor,"GLFWcursorPtr")} = libpointer("GLFWcursorPtr")
end
calllibglfw("glfwSetCursor", window, cursor);
end
