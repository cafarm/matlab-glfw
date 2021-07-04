function successful = glfwUpdateGamepadMappings(str)
arguments
    str (1,1) string
end
successful = calllibglfw("glfwUpdateGamepadMappings", char(str));
successful = double(successful);
end
