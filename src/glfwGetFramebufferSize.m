function [width, height] = glfwGetFramebufferSize(window)
arguments
    window (1,1) {mustBeLibPointer}
end
[~, width, height] = calllibglfw("glfwGetFramebufferSize", window, 0, 0);
width = double(width);
height = double(height);
end