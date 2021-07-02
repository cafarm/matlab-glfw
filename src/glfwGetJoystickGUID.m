function guid = glfwGetJoystickGUID(jid)
arguments
    jid (1,1) int32
end
guid = calllibglfw("glfwGetJoystickGUID", jid);
guid = string(guid);
end
