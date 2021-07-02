function glfwDestroyCursor(cursor)
arguments
    cursor (1,1) {mustBeLibPointer}
end
calllibglfw("glfwDestroyCursor", cursor);
end
