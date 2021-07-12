function cursor = glfwCreateCursor(image, xhot, yhot)
arguments
    image (:,:,4) uint8
    xhot (1,1) int32
    yhot (1,1) int32
end
imagePtr = libpointer("GLFWimagePtr", struct( ...
    "height", size(image,1), ...
    "width", size(image,2), ...
    "pixels", permute(image,[3,2,1])));
cursor = calllibglfw("glfwCreateCursor", imagePtr, xhot, yhot);
if isNull(cursor)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:createCursor:" + id, "Unable to create cursor (%s). %s", id, strjoin(desc, "."));
end
cursor = GLFWcursor(cursor);
end
