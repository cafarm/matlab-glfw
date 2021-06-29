function [code, description] = glfwGetError()
[code, description] = calllibglfw("glfwGetError", {});
code = double(code);
description = convertCharsToStrings(description);
end