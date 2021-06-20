function glfwWindowHint(hint, value)
arguments
    hint (1,1) int32
    value (1,1) int32
end
calllibglfw("glfwWindowHint", hint, value);
end

