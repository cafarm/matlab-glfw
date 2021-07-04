function [modes, count] = glfwGetVideoModes(monitor)
arguments
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr"), mustBeNonnull}
end
[pmodes, ~, count] = calllibglfw("glfwGetVideoModes", monitor, libpointer("int32Ptr",0));
modes = pmodes.Value;
for i = 2:count
    pmodes = pmodes + 1;
    modes(i) = pmodes.Value;
end
if isNull(pmodes)
    modes = modes([]);
end
count = double(count);
end
