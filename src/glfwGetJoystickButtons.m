function [buttons, count] = glfwGetJoystickButtons(jid)
arguments
    jid (1,1) int32
end
[buttons, count] = calllibglfw("glfwGetJoystickButtons", jid, 0);
count = double(count);
end
