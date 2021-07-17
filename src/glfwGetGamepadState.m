function [connected, state] = glfwGetGamepadState(jid)
arguments
    jid (1,1) int32
end
[connected, stateStruct] = calllibglfw("glfwGetGamepadState", jid, libglfwstruct("GLFWgamepadstate",struct()));
connected = double(connected);
state = GLFWgamepadstate();
state.buttons = stateStruct.buttons;
state.axes = stateStruct.axes;
end
