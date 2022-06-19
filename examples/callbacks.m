% Set error callback to print error description
glfwSetErrorCallback(@errorCallback);

% Initialize the library
glfwInit();

% Create a windowed mode window and its OpenGL context
window = glfwCreateWindow(640, 480, "Callbacks Example");

% Set key callback to close window when escape key pressed
glfwSetKeyCallback(window, @keyCallback);

% Set cursor callback to print when cursor enters or leaves window
glfwSetCursorEnterCallback(window, @cursorEnterCallback);

% Make the window's context current
glfwMakeContextCurrent(window);

% Loop until the user closes the window
while ~glfwWindowShouldClose(window)
    % Render here...
    
    % Swap front and back buffers
    glfwSwapBuffers(window);
    
    % Poll for and process events
    glfwPollEvents();
end

glfwTerminate();

function errorCallback(code, description) %#ok<INUSL> 
disp("Error: " + description);
end

function keyCallback(window, key, scancode, action, mods) %#ok<INUSD,INUSL> 
if key == GLFW.KEY_ESCAPE && action == GLFW.PRESS
    glfwSetWindowShouldClose(window, GLFW.TRUE);
end
end

function cursorEnterCallback(window, entered) 
if entered
    glfwSetWindowTitle(window, "Cursor entered window");
else
    glfwSetWindowTitle(window, "Cursor left window");
end
end