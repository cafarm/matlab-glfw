classdef (Sealed) GLFWwindow < handle
    properties (Access = private)
        Pointer (1,1) {mustBeLibPointer(Pointer,"GLFWwindowPtr")} = libglfwpointer("GLFWwindowPtr")
    end
    
    methods
        function window = GLFWwindow(pointer)
            arguments
                pointer (1,1) {mustBeLibPointer(pointer,"GLFWwindowPtr")} = libglfwpointer("GLFWwindowPtr")
            end
            window.Pointer = pointer;
            GLFWwindow.instances(window);
        end

        function tf = isNull(window)
            arguments
                window (1,1) GLFWwindow
            end
            tf = isNull(window.Pointer);
        end
    end

    methods (Hidden)
        function pointer = lib.pointer(window)
            pointer = window.Pointer;
        end
    end

    methods (Static, Hidden)
        function all = instances(new)
            persistent windows;
            if ~isa(windows, "GLFWwindow")
                windows = GLFWwindow.empty();
            end
            if nargin > 0
                windows(end+1) = new;
            end
            all = windows;
        end
    end
end

