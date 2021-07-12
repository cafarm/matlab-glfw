classdef (Sealed) GLFWmonitor < handle
    properties (Access = private)
        Pointer (1,1) {mustBeLibPointer(Pointer,"GLFWmonitorPtr")} = libpointer("GLFWmonitorPtr")
    end
    
    methods
        function monitor = GLFWmonitor(pointer)
            arguments
                pointer (1,1) {mustBeLibPointer(pointer,"GLFWmonitorPtr")} = libpointer("GLFWmonitorPtr")
            end
            monitor.Pointer = pointer;
            GLFWmonitor.instances(monitor);
        end

        function tf = isNull(monitor)
            arguments
                monitor (1,1) GLFWmonitor
            end
            tf = isNull(monitor.Pointer);
        end
    end

    methods (Hidden)
        function pointer = lib.pointer(monitor)
            pointer = monitor.Pointer;
        end
    end

    methods (Static, Hidden)
        function all = instances(new)
            persistent monitors;
            if ~isa(monitors, "GLFWmonitor")
                monitors = GLFWmonitor.empty();
            end
            if nargin > 0
                monitors(end+1) = new;
            end
            all = monitors;
        end
    end
end

