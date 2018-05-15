import hxmake.utils.Haxelib;
import hxmake.idea.IdeaPlugin;
import hxmake.haxelib.HaxelibPlugin;

using hxmake.haxelib.HaxelibPlugin;

@:lib("hxsuite")
class EcxBenchmarksMake extends hxmake.Module {

	function new() {

		var includeWip = project.arguments.hasProperty("--include-wip");

		config.classPath = ["src"];
		config.testPath = [];
		config.devDependencies = [
			"hxsuite" => "haxelib",
			"ecx" => "haxelib",
			"ash" => "haxelib",
			"edge" => "haxelib",
			"hxE" => "haxelib",
			"hotmem" => "haxelib"
		];

		if(includeWip) {
			config.devDependencies.set("seagal", "haxelib");
			config.devDependencies.set("eskimo", "haxelib");
		}

		apply(HaxelibPlugin);
		apply(IdeaPlugin);

		var suiteTask = new SuiteBuildTask();
		suiteTask.classPath = ["benchmarks"];
		suiteTask.main = "ecs.benchmarks.Benchmarks";
		suiteTask.defaultApps = ["ecx", "ecx_hot", "ash", "hxe", "edge"];
		suiteTask.defaultTargets = ["swf", "node", "js", "cs", "java", "cpp"];
		suiteTask.libraries.push("ecx");
		suiteTask.libraries.push("ash");
		suiteTask.libraries.push("edge");
		suiteTask.libraries.push("hxE");
		suiteTask.libraries.push("hotmem");
		if(includeWip) {
			suiteTask.libraries.push("eskimo");
			suiteTask.libraries.push("seagal");
		}

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