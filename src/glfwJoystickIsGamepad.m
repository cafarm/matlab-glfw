function isGamepad = glfwJoystickIsGamepad(jid)
arguments
    jid (1,1) int32
end
isGamepad = calllibglfw("glfwJoystickIsGamepad", jid);
isGamepad = double(isGamepad);
end
