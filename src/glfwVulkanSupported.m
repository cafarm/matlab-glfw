function supported = glfwVulkanSupported()
supported = calllibglfw("glfwVulkanSupported");
supported = double(supported);
end
