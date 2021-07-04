function cursor = glfwCreateCursor(image, xhot, yhot)
arguments
    image (:,:,4) uint8
    xhot (1,1) int32
    yhot (1,1) int32
end
pimage = libpointer("GLFWimagePtr", struct( ...
    "height", size(image,1), ...
    "width", size(image,2), ...
    "pixels", permute(image,[3,2,1])));
cursor = calllibglfw("glfwCreateCursor", pimage, xhot, yhot);
if isNull(cursor)
    [code,desc] = glfwGetError();
    error("GLFW:createCursor:error", "Unable to create cursor (%s). %s", GLFW.errorID(code), strjoin(desc, "."));
end
end
