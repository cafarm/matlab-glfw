classdef tglfwRegisterCallback < matlab.unittest.TestCase
    properties (TestParameter)
        FuncName = allFuncNames();
    end
    
    methods (Test)
        function glfwFuncCallsRegisterCallback(testCase, FuncName)
            import matlab.unittest.constraints.Matches;
            contents = fileread(fullfile(srcFolder, FuncName + ".m"));
            type = replace(FuncName, ["glfwSet", "Callback"], "");
            type = [lower(type(1)) type(2:end)]; 
            testCase.verifyThat(contents, Matches(sprintf('glfwRegisterCallback([ ]*"%s"', type)));
        end
    end
end

function n = allFuncNames()
listing = dir(fullfile(srcFolder, "glfw*"));
n = string({listing.name});
n = replace(n, ".m", "");
n(~endsWith(n,"Callback")) = [];
n = cellstr(n);
end

function f = srcFolder()
rootFolder = fileparts(fileparts(mfilename("fullpath")));
f = fullfile(rootFolder, "src");
end