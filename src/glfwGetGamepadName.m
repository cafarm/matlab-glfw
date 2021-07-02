function name = glfwGetGamepadName(jid)
arguments
    jid (1,1) int32
end
name = calllibglfw("glfwGetGamepadName", jid);
name = string(name);
end
