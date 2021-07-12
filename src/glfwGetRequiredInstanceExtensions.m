function [names, count] = glfwGetRequiredInstanceExtensions()
[namesPtr, count] = calllibglfw("glfwGetRequiredInstanceExtensions", libpointer("uint32Ptr",0));
names = string.empty(0,count);
for i = 1:count
    names(i) = names.Value;
    namesPtr = namesPtr + 1;
end
count = double(count);
end
