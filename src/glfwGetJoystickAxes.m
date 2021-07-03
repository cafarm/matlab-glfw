function [axes, count] = glfwGetJoystickAxes(jid)
arguments
    jid (1,1) int32
end
[axes, count] = calllibglfw("glfwGetJoystickAxes", jid, libpointer("int32Ptr",0));
count = double(count);
end
