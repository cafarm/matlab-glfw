function glfwSetTime(time)
arguments
    time (1,1) double
end
calllibglfw("glfwSetTime", time);
end
