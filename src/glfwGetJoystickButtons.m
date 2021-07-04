function [buttons, count] = glfwGetJoystickButtons(jid)
arguments
    jid (1,1) int32
end
[buttons, count] = calllibglfw("glfwGetJoystickButtons", jid, libpointer("int32Ptr",0));
if isNull(buttons)
    buttons = [];
else
    setdatatype(buttons, buttons.DataType, count);
    buttons = double(buttons.Value');
end
count = double(count);
end
