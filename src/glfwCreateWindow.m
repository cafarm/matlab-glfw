function window = glfwCreateWindow(width, height, title, monitor, share)
arguments
    width (1,1) int32
    height (1,1) int32
    title (1,1) string
    monitor (1,1) {mustBeClass(monitor,"GLFWmonitor")} = GLFWmonitor()
    share (1,1) {mustBeClass(share,"GLFWwindow")} = GLFWwindow()
end
window = calllibglfw("glfwCreateWindow", width, height, char(title), libpointer(monitor), libpointer(share));
if isNull(window)
    [code,desc] = glfwGetError();
    id = GLFW.errorID(code);
    error("GLFW:createWindow:" + id, "Unable to create window (%s). %s", id, strjoin(desc, "."));
end
window = GLFWwindow(window);
end