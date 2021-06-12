# matlab-glfw [![cafarm](https://circleci.com/gh/cafarm/matlab-glfw.svg?style=svg)](https://app.circleci.com/pipelines/github/cafarm/matlab-glfw)
Work-in-progress [GLFW](https://www.glfw.org) bindings for MATLAB.

## Example
Below is a short example of setting up a window and OpenGL context with GLFW in MATLAB. This example was ported from the [GLFW documentation](https://www.glfw.org/documentation.html).
```matlab
% Initialize the library
success = glfwInit();
if ~success
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

clear window;
glfwTerminate();
```

