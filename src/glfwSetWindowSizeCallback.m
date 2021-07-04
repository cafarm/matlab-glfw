function [lib.pointer, GLFWwindowPtr, voidPtr] = glfwSetWindowSizeCallback(GLFWwindowPtr, voidPtr)
arguments
    
end
[lib.pointer, GLFWwindowPtr, voidPtr] = calllibglfw("glfwSetWindowSizeCallback", GLFWwindowPtr, voidPtr);
end
