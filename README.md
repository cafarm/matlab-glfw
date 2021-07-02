# matlab-glfw [![cafarm](https://circleci.com/gh/cafarm/matlab-glfw.svg?style=svg)](https://app.circleci.com/pipelines/github/cafarm/matlab-glfw) [![codecov](https://codecov.io/gh/cafarm/matlab-glfw/branch/main/graph/badge.svg?token=IXB5XNSA10)](https://codecov.io/gh/cafarm/matlab-glfw)
Work-in-progress [GLFW](https://www.glfw.org) bindings for MATLAB.

## Download
[Download the latest packaged toolbox](http://github.com/cafarm/matlab-glfw/releases/latest/download/matlab-glfw.mltbx). The toolbox including pre-compiled GLFW binaries for Linux, macOS, and Windows. MATLAB R2019b or above required.

## Example
Below is a short example of setting up a window and OpenGL context with GLFW in MATLAB. This example was ported from the [GLFW documentation](https://www.glfw.org/documentation.html).
```matlab
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
```

## Constants
Constants are available under the `GLFW` class and have the same name as GLFW C library constants minus the `GLFW_` prefix.

```matlab
glfwInitHint(GLFW.JOYSTICK_HAT_BUTTONS, GLFW.FALSE);
```

## Development
### Test
```matlab
>> build test
```

### Package
```matlab
>> build package
```

### Release
```matlab
>> build version
type (major|minor|patch): minor
>> !git push origin main --follow-tags
```