classdef (Sealed) GLFWgammaramp
    properties
        red (1,:) double
        green (1,:) double
        blue (1,:) double
        size (1,1) double
    end

    methods (Hidden)
        function pointer = lib.pointer(ramp)
            pointer = libglfwpointer("GLFWgammarampPtr", struct( ...
                "red", libpointer("uint16Ptr", ramp.red), ...
                "green", libpointer("uint16Ptr", ramp.green), ...
                "blue", libpointer("uint16Ptr", ramp.blue), ...
                "size", ramp.size));
        end
    end

    methods (Static, Hidden)
        function ramp = fromLibPointer(pointer)
            arguments
                pointer (1,1) {mustBeLibPointer(pointer,"GLFWgammarampPtr")}
            end
            value = pointer.Value;
            red = value.red;
            if isa(red, "lib.pointer")
                setdatatype(value.red, value.red.DataType, value.size);
                red = value.red.Value;
            end
            green = value.green;
            if isa(green, "lib.pointer")
                setdatatype(value.green, value.green.DataType, value.size);
                green = value.green.Value;
            end
            blue = value.blue;
            if isa(blue, "lib.pointer")
                setdatatype(value.blue, value.blue.DataType, value.size);
                blue = value.blue.Value;
            end
            ramp = GLFWgammaramp();
            ramp.red = red;
            ramp.green = green;
            ramp.blue = blue;
            ramp.size = value.size;
        end
    end
end

