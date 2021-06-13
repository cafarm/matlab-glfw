# matlab-glfw [![cafarm](https://circleci.com/gh/cafarm/matlab-glfw.svg?style=svg)](https://app.circleci.com/pipelines/github/cafarm/matlab-glfw)
Work-in-progress [GLFW](https://www.glfw.org) bindings for MATLAB.

## Toolbox
A toolbox including pre-compiled GLFW binaries for Linux, macOS, and Windows is available via [GitHub releases](https://github.com/cafarm/matlab-glfw/releases/latest). Find "matlab-glfw.mltbx" located under the release assets.

The bindings make use of [function argument validation](https://www.mathworks.com/help/matlab/matlab_prog/function-argument-validation-1.html) and therefore require MATLAB R2019b or above.

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

## Compile from source
In MATLAB:
```
>> !git clone https://github.com/cafarm/matlab-glfw.git
>> cd matlab-glfw
>> !./getdeps.sh
>> package
```