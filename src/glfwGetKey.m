function state = glfwGetKey(window, key)
arguments
    window (1,1) {mustBeLibPointer}
    key (1,1) int32
end
state = calllibglfw("glfwGetKey", window, key);
end
