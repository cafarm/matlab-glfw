function [hats, count] = glfwGetJoystickHats(jid)
arguments
    jid (1,1) int32
end
[hats, count] = calllibglfw("glfwGetJoystickHats", jid, libpointer("int32Ptr",0));
if isNull(hats)
    hats = [];
else
    setdatatype(hats, hats.DataType, count);
    hats = double(hats.Value');
end
count = double(count);
end
