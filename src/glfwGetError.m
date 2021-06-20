function [code, description] = glfwGetError()
[code, description] = calllibglfw("glfwGetError", {});
description = convertCharsToStrings(description);
end