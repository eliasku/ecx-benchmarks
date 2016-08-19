import hxmake.utils.Haxelib;
import hxmake.idea.IdeaPlugin;
import hxmake.haxelib.HaxelibPlugin;

using hxmake.haxelib.HaxelibPlugin;

@:lib("hxsuite")
class EcxBenchmarksMake extends hxmake.Module {

	function new() {
		config.classPath = ["src"];
		config.testPath = [];
		config.devDependencies = [
			"hxsuite" => "haxelib",
			"ecx" => "haxelib",
			"ash" => "haxelib",
			"eskimo" => "haxelib",
			"edge" => "haxelib",
			"hxE" => "haxelib"
		];

		apply(HaxelibPlugin);
		apply(IdeaPlugin);

		var suiteTask = new SuiteBuildTask();
		suiteTask.classPath = ["benchmarks"];
		suiteTask.main = "ecs.benchmarks.Benchmarks";
		suiteTask.defaultApps = ["ecx", "ash", "eskimo"];
		suiteTask.defaultTargets = ["swf", "node", "cs", "cpp"];
		suiteTask.libraries.push("ecx");
		suiteTask.libraries.push("ash");
		suiteTask.libraries.push("eskimo");
		suiteTask.libraries.push("edge");
		suiteTask.libraries.push("hxE");
		suiteTask.doFirst(function(_) {
			Haxelib.install("ash");
			Haxelib.install("eskimo");
			Haxelib.install("edge");
			Haxelib.install("hxE");
			Haxelib.install("ecx");
			// required for `node` target
			Haxelib.install("hxnodejs");
		});
		task("run", suiteTask);
	}
}