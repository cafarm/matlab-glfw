function glfwInit()
success = calllibglfw("glfwInit");
if double(success) == GLFW.FALSE
    [code,desc] = glfwGetError();
    error("GLFW:init:error", "Unable to init (%s). %s", GLFW.errorID(code), strjoin(desc, "."));
end
end