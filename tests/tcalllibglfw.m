classdef tcalllibglfw < matlab.unittest.TestCase
    properties (TestParameter)
        FuncName = allFuncNames();
    end
    
    methods (Test)
        function calllib(testCase, FuncName)
            import matlab.unittest.constraints.Matches;
            contents = fileread(fullfile(srcFolder, FuncName + ".m"));
            testCase.verifyThat(contents, Matches(sprintf('calllibglfw([ ]*"%s"', FuncName)));
        end
    end
end

function n = allFuncNames()
listing = dir(fullfile(srcFolder, "glfw*"));
n = string({listing.name});
n = replace(n, ".m", "");
n = cellstr(n);
end

function f = srcFolder()
rootFolder = fileparts(fileparts(mfilename("fullpath")));
f = fullfile(rootFolder, "src");
end