% Initialize the library
if ~glfwInit()
    error("failed to initialize library");
end

% Create a windowed mode window and its OpenGL context
window = glfwCreateWindow(640, 480, "Hello World");
if isNull(window)
    glfwTerminate();
    error("failed to create window");
end

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