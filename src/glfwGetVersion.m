function [major, minor, rev] = glfwGetVersion()
[major, minor, rev] = calllibglfw("glfwGetVersion", libpointer("int32Ptr",0),  libpointer("int32Ptr",0),  libpointer("int32Ptr",0));
major = double(major);
minor = double(minor);
rev = double(rev);
end