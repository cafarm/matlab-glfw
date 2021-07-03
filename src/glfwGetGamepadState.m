function [connected, state] = glfwGetGamepadState(jid)
arguments
    jid (1,1) int32
end
[connected, state] = calllibglfw("glfwGetGamepadState", jid, libstruct("GLFWgamepadstate",struct()));
connected = double(connected);
end
