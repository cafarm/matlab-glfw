function [xpos, ypos] = glfwGetCursorPos(window)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
end
[~, xpos, ypos] = calllibglfw("glfwGetCursorPos", window, libpointer("doublePtr",0), libpointer("doublePtr",0));
end
