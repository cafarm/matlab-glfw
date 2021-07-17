classdef (Sealed) GLFWvidmode
    properties
        width (1,1) double
        height (1,1) double
        redBits (1,1) double
        greenBits (1,1) double
        blueBits (1,1) double
        refreshRate (1,1) double
    end
    
    methods (Static, Hidden)
        function mode = fromLibPointer(pointer)
            arguments
                pointer (1,1) {mustBeLibPointer(pointer,"GLFWvidmodePtr")}
            end
            value = pointer.Value;
            mode = GLFWvidmode();
            mode.width = value.width;
            mode.height = value.height;
            mode.redBits = value.redBits;
            mode.greenBits = value.greenBits;
            mode.blueBits = value.blueBits;
            mode.refreshRate = value.refreshRate;
        end
    end
end

