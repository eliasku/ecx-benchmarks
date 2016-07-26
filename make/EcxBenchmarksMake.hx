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
			"hxE" => "haxelib",
			"edge" => "haxelib"
		];

		apply(HaxelibPlugin);
		apply(IdeaPlugin);

		var suiteTask = new SuiteBuildTask();
		suiteTask.classPath = ["benchmarks"];
		suiteTask.main = "ecs.benchmarks.Benchmarks";
		suiteTask.libraries.push("ecx");
		suiteTask.libraries.push("ash");
		suiteTask.libraries.push("hxE");
		suiteTask.libraries.push("edge");
		suiteTask.doFirst(function(_) {
			Haxelib.install("ash");
			Haxelib.install("hxE");
			Haxelib.install("edge");
		});
		task("run", suiteTask);
	}
}