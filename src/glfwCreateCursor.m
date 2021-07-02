function cursor = glfwCreateCursor(image, xhot, yhot)
arguments
    image (1,1) {mustBeLibPointer}
    xhot (1,1) int32
    yhot (1,1) int32
end
cursor = calllibglfw("glfwCreateCursor", image, xhot, yhot);
end
