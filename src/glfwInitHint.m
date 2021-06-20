function glfwInitHint(hint, value)
arguments
    hint (1,1) int32
    value (1,1) int32
end
calllibglfw("glfwInitHint", hint, value);
end

