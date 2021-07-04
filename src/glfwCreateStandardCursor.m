function cursor = glfwCreateStandardCursor(shape)
arguments
    shape (1,1) int32
end
cursor = calllibglfw("glfwCreateStandardCursor", shape);
if isNull(cursor)
    [code,desc] = glfwGetError();
    error("GLFW:createStandardCursor:error", "Unable to create cursor (%s). %s", GLFW.errorID(code), strjoin(desc, "."));
end
end
