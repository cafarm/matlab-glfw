function [xpos, ypos] = glfwGetCursorPos(window)
arguments
    window (1,1) {mustBeA(window,"GLFWwindow"), mustBeNonnull}
end
[~, xpos, ypos] = calllibglfw("glfwGetCursorPos", libpointer(window), libpointer("doublePtr",0), libpointer("doublePtr",0));
xpos = double(xpos);
ypos = double(ypos);
end
