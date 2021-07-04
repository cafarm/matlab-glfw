function [names, count] = glfwGetRequiredInstanceExtensions()
[names, count] = calllibglfw("glfwGetRequiredInstanceExtensions", libpointer("uint32Ptr",0));
count = double(count);
end
