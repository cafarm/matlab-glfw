function [hats, count] = glfwGetJoystickHats(jid)
arguments
    jid (1,1) int32
end
[hats, count] = calllibglfw("glfwGetJoystickHats", jid, 0);
count = double(count);
end
