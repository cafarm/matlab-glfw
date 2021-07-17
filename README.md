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
The standard [GLFW documentation](https://www.glfw.org/docs/latest/) is applicable to learn GLFW in MATLAB. Differences between the C and MATLAB API are noted below.

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

### Inputs and outputs
C functions that take pointers as input arguments to store return values, instead return those values as output arguments in MATLAB.

```matlab
% MATLAB
[major,minor,revision] = glfwGetVersion();
fprintf("Running against GLFW %i.%i.%i\n", major, minor, revision);
```

```c
// C
int major, minor, revision;
glfwGetVersion(&major, &minor, &revision);
printf("Running against GLFW %i.%i.%i\n", major, minor, revision);
```

### Error handling
C functions that return `NULL` pointers or `GLFW_FALSE` *solely* to indicate an error, instead throw an exception in MATLAB.

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
C structs are automatically marshalled to and from MATLAB classes of the same name.

```
>> monitor = glfwGetPrimaryMonitor();
>> ramp = glfwGetGammaRamp(monitor)

ramp = 

  GLFWgammaramp with properties:

      red: [0 64 128 192 256 320 384 448 … ]
    green: [0 64 128 192 256 320 384 448 … ]
     blue: [0 64 128 192 256 320 384 448 … ]
     size: 1024

>> ramp = GLFWgammaramp();
>> ramp.red = linspace(0,65535,1024);
>> ramp.green = linspace(0,65535,1024);
>> ramp.blue = linspace(0,65535,1024);
>> ramp.size = 1024;
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

All C numeric types are automatically marshalled to and from MATLAB `double`.

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