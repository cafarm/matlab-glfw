function cursor = glfwCreateCursor(image, xhot, yhot)
arguments
    image (1,1) {mustBeClass(image,"GLFWimage")}
    xhot (1,1) int32
    yhot (1,1) int32
end
validate(image);
cursor = calllibglfw("glfwCreateCursor", libpointer(image), xhot, yhot);
if isNull(cursor)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:createCursor:" + id, "Unable to create cursor (%s). %s", id, strjoin(desc, "."));
end
cursor = GLFWcursor(cursor);
end
