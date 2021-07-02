function cursor = glfwCreateStandardCursor(shape)
arguments
    shape (1,1) int32
end
cursor = calllibglfw("glfwCreateStandardCursor", shape);
end
