# matlab-glfw [![cafarm](https://circleci.com/gh/cafarm/matlab-glfw.svg?style=svg)](https://app.circleci.com/pipelines/github/cafarm/matlab-glfw) [![codecov](https://codecov.io/gh/cafarm/matlab-glfw/branch/main/graph/badge.svg?token=IXB5XNSA10)](https://codecov.io/gh/cafarm/matlab-glfw)
GLFW bindings for MATLAB. From [glfw.org](https://www.glfw.org):

> GLFW is an Open Source, multi-platform library for OpenGL, OpenGL ES and Vulkan development on the desktop. It provides a simple API for creating windows, contexts and surfaces, receiving input and events.

## Download
[Download the latest packaged toolbox](http://github.com/cafarm/matlab-glfw/releases/latest/download/GLFW.mltbx). The toolbox includes pre-compiled GLFW binaries for Linux, macOS, and Windows. MATLAB R2020a or above required.

## Example
Below is a short example of setting up a window and OpenGL context with GLFW in MATLAB. This example was ported from the [GLFW documentation](https://www.glfw.org/documentation.html).
```matlab
% Initialize the library
glfwInit();

% Create a windowed mode window and its OpenGL context
window = glfwCreateWindow(640, 480, "Hello World");

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

## Documentation
The standard [GLFW documentation](https://www.glfw.org/docs/latest/) is applicable to learn GLFW in MATLAB. Differences between the MATLAB and C API are noted below.

### Constants
C constants are available in MATLAB under the `GLFW` class and have the same name minus the `GLFW_` prefix.

```matlab
% MATLAB
glfwInitHint(GLFW.JOYSTICK_HAT_BUTTONS, GLFW.FALSE);
```

```c
// C
glfwInitHint(GLFW_JOYSTICK_HAT_BUTTONS, GLFW_FALSE);
```

### Error handling
C functions that return `NULL` pointers or `GLFW_FALSE` *solely* to indicate an error instead throw an exception in MATLAB.

```matlab
% MATLAB
glfwInit(); % throws exception if error occurs
```

```c
// C
if (!glfwInit()) // must manually handle error condition
    // handle error
```

### Marshalling
Non-opaque C structs are automatically marshalled to and from MATLAB structs.

```
>> monitor = glfwGetPrimaryMonitor();
>> ramp = glfwGetGammaRamp(monitor)

ramp = 

  struct with fields:

      red: [0 64 128 192 256 320 384 448 512 576 640 704 768 832 896 960 1024 1089 … ]
    green: [0 64 128 192 256 320 384 448 512 576 640 704 768 832 896 960 1024 1089 … ]
     blue: [0 64 128 192 256 320 384 448 512 576 640 704 768 832 896 960 1024 1089 … ]
     size: 1024

>> ramp.red = flip(ramp.red);
>> glfwSetGammaRamp(monitor, ramp);
```

C function pointers are automatically marshalled to and from MATLAB function handles.

```matlab
% MATLAB
glfwSetErrorCallback(@errorCallback)

function errorCallback(code, description)
    disp(code + ":" + description);
end
```

```c
// C
glfwSetErrorCallback(errorCallback);

void errorCallback(int code, const char* description)
{
    displayErrorMessage(code, description);
}
```

All numeric values are converted to `double` in MATLAB.

### Optional arguments
C functions input arguments that may be set to `NULL` are moved to the end of the argument list in MATLAB and treated as optional arguments.

```matlab
% MATLAB
% Specify monitor
glfwSetWindowMonitor(window, xpos, ypos, width, height, monitor);

% Do not specify monitor
glfwSetWindowMonitor(window, xpos, ypos, width, height);
```

```c
// C
// Specify monitor 
glfwSetWindowMonitor(window, monitor, xpos, ypos, width, height);

// Do not specify monitor
glfwSetWindowMonitor(window, NULL, xpos, ypos, width, height);
```

## Development
### Test
```matlab
>> build test
```

### Coverage
```matlab
>> build cov
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