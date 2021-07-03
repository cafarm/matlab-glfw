function glfwDestroyCursor(cursor)
arguments
    cursor (1,1) {mustBeLibPointer(cursor,"GLFWcursorPtr")}
end
calllibglfw("glfwDestroyCursor", cursor);
end
