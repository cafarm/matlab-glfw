function time = glfwGetTime()
time = calllibglfw("glfwGetTime");
time = double(time);
end