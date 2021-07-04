function value = glfwGetTimerValue()
value = calllibglfw("glfwGetTimerValue");
value = double(value);
end
