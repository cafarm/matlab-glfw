function [code, description] = glfwGetError()
loadLibglfw();
[code, description] = calllib("libglfw", "glfwGetError", {});
description = convertCharsToStrings(description);
end