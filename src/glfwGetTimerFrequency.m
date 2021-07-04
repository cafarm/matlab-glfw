function frequency = glfwGetTimerFrequency()
frequency = calllibglfw("glfwGetTimerFrequency");
frequency = double(frequency);
end
