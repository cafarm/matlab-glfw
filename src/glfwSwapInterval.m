function glfwSwapInterval(interval)
arguments
    interval (1,1) int32
end
calllibglfw("glfwSwapInterval", interval);
end