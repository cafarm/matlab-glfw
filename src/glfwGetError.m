function [code, description] = glfwGetError()
[code, description] = calllibglfw("glfwGetError", libpointer("stringPtrPtr"));
code = double(code);
description = string(description);
end