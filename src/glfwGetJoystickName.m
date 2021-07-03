function name = glfwGetJoystickName(jid)
arguments
    jid (1,1) int32
end
name = calllibglfw("glfwGetJoystickName", jid);
name = string(name);
end
