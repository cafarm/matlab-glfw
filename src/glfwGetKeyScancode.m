function scancode = glfwGetKeyScancode(key)
arguments
    key (1,1) int32
end
scancode = calllibglfw("glfwGetKeyScancode", key);
scancode = double(scancode);
end
