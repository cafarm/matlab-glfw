function glfwUpdateGamepadMappings(str)
arguments
    str (1,1) string
end
success = calllibglfw("glfwUpdateGamepadMappings", char(str));
if double(success) == GLFW.FALSE
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:updateGamepadMappings:" + id, "Unable to update gamepad mappings (%s). %s", id, strjoin(desc, "."));
end
end
