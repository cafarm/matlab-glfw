function present = glfwJoystickPresent(jid)
arguments
    jid (1,1) int32
end
present = calllibglfw("glfwJoystickPresent", jid);
present = double(present);
end
