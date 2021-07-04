function glfwUpdateGamepadMappings(str)
arguments
    str (1,1) string
end
success = calllibglfw("glfwUpdateGamepadMappings", char(str));
if double(success) == GLFW.FALSE
    [code,desc] = glfwGetError();
    error("GLFW:updateGamepadMappings:error", "Unable to update gamepad mappings (%s). %s", GLFW.errorID(code), strjoin(desc, "."));
end
end
