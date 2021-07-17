classdef (Sealed) GLFWimage
    properties
        width (1,1) double
        height (1,1) double
        pixels (:,:,4) uint8
    end
    
    methods (Hidden)
        function validate(image)
            if image.height > size(image.pixels,1)
                error("GLFW:image:invalidImage", ...
                    "Image 'height' must be less than or equal to the " + ...
                    "first dimension of the 'pixels' matrix.");
            end
            if image.width > size(image.pixels,2)
                error("GLFW:image:invalidImage", ...
                    "Image 'width' must be less than or equal to the " + ...
                    "second dimension of the 'pixels' matrix.");
            end
        end

        function pointer = lib.pointer(image)
            pointer = libglfwpointer("GLFWimagePtr", struct( ...
                "width", image.width, ...
                "height", image.height, ...
                "pixels", permute(image.pixels,[3,2,1])));
        end
    end
end

