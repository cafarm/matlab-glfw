function glfwWindowHintString(hint, value)
arguments
    hint (1,1) int32
    value (1,1) string
end
calllibglfw("glfwWindowHintString", hint, char(value));
end
