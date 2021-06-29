function [width, height] = glfwGetWindowSize(window)
arguments
    window (1,1) {mustBeLibPointer}
end
[~, width, height] = calllibglfw("glfwGetWindowSize", window, 0, 0);
width = double(width);
height = double(height);
end