function [lib.pointer, GLFWwindowPtr, voidPtr] = glfwSetKeyCallback(GLFWwindowPtr, voidPtr)
arguments
    
end
[lib.pointer, GLFWwindowPtr, voidPtr] = calllibglfw("glfwSetKeyCallback", GLFWwindowPtr, voidPtr);
end
