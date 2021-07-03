function pointer = glfwGetJoystickUserPointer(jid)
arguments
    jid (1,1) int32
end
pointer = calllibglfw("glfwGetJoystickUserPointer", jid);
end
