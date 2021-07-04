function window = glfwCreateWindow(width, height, title, monitor, share)
arguments
    width (1,1) int32
    height (1,1) int32
    title (1,1) string
    monitor (1,1) {mustBeLibPointer(monitor,"GLFWmonitorPtr")} = libpointer("GLFWmonitorPtr")
    share (1,1) {mustBeLibPointer(share,"GLFWwindowPtr")} = libpointer("GLFWwindowPtr")
end
window = calllibglfw("glfwCreateWindow", width, height, char(title), monitor, share);
if isNull(window)
    [code,desc] = glfwGetError();
    error("GLFW:createWindow:error", "Unable to create window (%s). %s", GLFW.errorID(code), strjoin(desc, "."));
end
end