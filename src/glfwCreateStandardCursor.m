function cursor = glfwCreateStandardCursor(shape)
arguments
    shape (1,1) int32
end
cursor = calllibglfw("glfwCreateStandardCursor", shape);
if isNull(cursor)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:createStandardCursor:" + id, "Unable to create cursor (%s). %s", id, strjoin(desc, "."));
end
cursor = GLFWcursor(cursor);
end
