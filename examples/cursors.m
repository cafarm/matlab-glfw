%% Create window
% Initialize the library
glfwInit();

% Create a windowed mode window and its OpenGL context
window = glfwCreateWindow(640, 480, "Cursors Example");

%% Custom cursor
% Read RGB image (8-bit color depth)
peppers = imread("peppers.png");

% Add alpha page
peppers(:,:,4) = intmax("uint8");

% Create custom cursor with hot-spot in upper-left corner
image = GLFWimage();
image.height = size(peppers, 1);
image.width = size(peppers, 2);
image.pixels = peppers;
cursor = glfwCreateCursor(image, 0, 0);

% Set cursor image when the cursor is over specified window
glfwSetCursor(window, cursor);

%% Standard cursor
% Create cursor with a standard shape
cursor = glfwCreateStandardCursor(GLFW.CROSSHAIR_CURSOR);

% Set cursor image when the cursor is over specified window
glfwSetCursor(window, cursor);

%% Clean up
glfwTerminate();