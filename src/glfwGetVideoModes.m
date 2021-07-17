function [modes, count] = glfwGetVideoModes(monitor)
arguments
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor"), mustBeNonnull}
end
[modesPtr, ~, count] = calllibglfw("glfwGetVideoModes", libpointer(monitor), libpointer("int32Ptr",0));
if isNull(modesPtr)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:getVideoModes:" + id, "Unable to get video modes (%s). %s", id, strjoin(desc, "."));
end
modes = GLFWvidmode.empty(0,count);
for i = 1:count
    modes(i) = GLFWvidmode.fromLibPointer(modesPtr);
    modesPtr = modesPtr + 1;
end
count = double(count);
end
