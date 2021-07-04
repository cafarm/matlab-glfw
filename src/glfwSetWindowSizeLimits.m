function glfwSetWindowSizeLimits(window, minwidth, minheight, maxwidth, maxheight)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr"), mustBeNonnull}
    minwidth (1,1) int32
    minheight (1,1) int32
    maxwidth (1,1) int32
    maxheight (1,1) int32
end
calllibglfw("glfwSetWindowSizeLimits", window, minwidth, minheight, maxwidth, maxheight);
end
