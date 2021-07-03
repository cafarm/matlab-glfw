function name = glfwGetKeyName(key, scancode)
arguments
    key (1,1) int32
    scancode (1,1) int32
end
name = calllibglfw("glfwGetKeyName", key, scancode);
name = string(name);
end
