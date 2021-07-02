function [xpos, ypos] = glfwGetCursorPos(window)
arguments
    window (1,1) {mustBeLibPointer}
end
[~, xpos, ypos] = calllibglfw("glfwGetCursorPos", window, 0, 0);
end
