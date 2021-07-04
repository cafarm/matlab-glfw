function glfwSetWindowIcon(window, image)
arguments
    window (1,1) {mustBeLibPointer(window,"GLFWwindowPtr")}
    image (:,:,4) uint8
end
pimage = libpointer("GLFWimagePtr", struct( ...
    "height", size(image,1), ...
    "width", size(image,2), ...
    "pixels", permute(image,[3,2,1])));
calllibglfw("glfwSetWindowIcon", window, 1, pimage);
end