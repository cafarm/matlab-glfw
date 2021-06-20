function window = glfwCreateWindow(width, height, title, monitor, share)
arguments
    width (1,1) int32 {mustBePositive}
    height (1,1) int32 {mustBePositive}
    title (1,1) string
    monitor (1,1) {mustBeLibPointer} = libpointer
    share (1,1) {mustBeLibPointer} = libpointer
end
window = calllibglfw("glfwCreateWindow", width, height, char(title), monitor, share);
end