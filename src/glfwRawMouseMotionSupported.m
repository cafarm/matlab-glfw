function supported = glfwRawMouseMotionSupported()
supported = calllibglfw("glfwRawMouseMotionSupported");
supported = double(supported);
end
