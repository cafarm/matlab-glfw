function glfwWaitEventsTimeout(timeout)
arguments
    timeout (1,1) double
end
calllibglfw("glfwWaitEventsTimeout", timeout);
feature("qewait", -1);
end
