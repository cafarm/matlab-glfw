function [GLFWwindowPtr, GLFWcursorPtr] = glfwSetCursor(GLFWwindowPtr, GLFWcursorPtr)
arguments
    
end
[GLFWwindowPtr, GLFWcursorPtr] = calllibglfw("glfwSetCursor", GLFWwindowPtr, GLFWcursorPtr);
end
