function plan = buildfile
plan = buildplan(localfunctions);

plan("compile").Dependencies = "getdeps";
[plan(["package","devPackage","test","cov","ci"]).Dependencies] = deal("compile");

plan.DefaultTasks = "package";

addpath("src");
end

function packageTask(~)
% Package MLTBX for distribution
v = fileread("VERSION");
matlab.addons.toolbox.toolboxVersion("toolbox.prj", v);
matlab.addons.toolbox.packageToolbox("toolbox.prj");
end

function devPackageTask(~)
% Package MLTBX for testing
[~,rev] = system("git rev-list --count HEAD");
v = nextver("minor") + "." + deblank(rev);
matlab.addons.toolbox.toolboxVersion("toolbox.prj", v);
matlab.addons.toolbox.packageToolbox("toolbox.prj");
end

function testTask(~)
% Run tests
results = runtests("tests", IncludeSubfolders=true);
assertSuccess(results);
end

function covTask(~)
% Run tests with coverage
if libisloaded("libglfw")
    unloadlibrary("libglfw");
end
results = runtests("tests", IncludeSubfolders=true, ReportCoverageFor="src");
assertSuccess(results);
end

function ciTask(~)
% Run tests with reports for CI
import matlab.unittest.TestRunner;
import matlab.unittest.plugins.CodeCoveragePlugin;
import matlab.unittest.plugins.XMLPlugin;
import matlab.unittest.plugins.codecoverage.CoberturaFormat;

suite = testsuite("tests", IncludeSubfolders=true);

resultsDir = "results/matlab";
[~,~] = mkdir(resultsDir);

runner = TestRunner.withTextOutput(LoggingLevel="Detailed", OutputDetail="Detailed");
runner.addPlugin(XMLPlugin.producingJUnitFormat(fullfile(resultsDir,"results.xml")));
runner.addPlugin(CodeCoveragePlugin.forFolder("src", IncludingSubfolders=true, Producing=CoberturaFormat(fullfile(resultsDir,"coverage.xml"))));

results = runner.run(suite);
assertSuccess(results);
end

function compileTask(~)
% Compile internal MEX
if isfile("src/private/glfwRegisterCallback."+mexext)
    return;
end
glfwDir = "deps/glfw/"+lower(computer("arch"));
if ispc
    libname = "glfw3dll";
else
    libname = "glfw";
end
mex("-I"+glfwDir+"/include", ...
    "-L"+glfwDir+"/lib", ...
    "-l"+libname, ...
    "-outdir", "src/private", ...
    "src/private/glfwRegisterCallback.cpp");
end

function getdepsTask(~)
% Download and compile GLFW from source
if isfolder("deps")
    return;
end
system("bash getdeps.sh");
end

function versionTask(~)
% Bump project version number
[~,status] = system("git status -s");
if ~isempty(status)
    error("'git status -s' reports changes. Commit or revert changes before bumping the version.");
end

type = input("type (major|minor|patch): ", "s");
mustBeMember(type, ["major","minor","patch"]);

newver = nextver(type);

fid = fopen("VERSION", "w");
fwrite(fid, newver);
fclose(fid);

system("git commit VERSION -m 'bump version to " + newver + "'");
system("git tag -a v" + newver + " -m 'version " + newver + "'");
end

function v = nextver(type)
arguments
    type string {mustBeMember(type, ["major","minor","patch"])}
end
parts = regexp(fileread("VERSION"), "^([0-9]*).([0-9]*).([0-9]*)$", "tokens");
major = str2double(parts{1}{1});
minor = str2double(parts{1}{2});
patch = str2double(parts{1}{3});
switch type
    case "major"
        v = (major+1) + ".0.0";
    case "minor"
        v = major + "." + (minor+1) + ".0";
    case "patch"
        v = major + "." + minor + "." + (patch+1);
end
end