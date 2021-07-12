function glfwDestroyCursor(cursor)
arguments
    cursor (1,1) {mustBeA(cursor,"GLFWcursor")}
end
calllibglfw("glfwDestroyCursor", libpointer(cursor));
delete(cursor);
end
