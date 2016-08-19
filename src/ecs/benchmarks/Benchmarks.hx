package ecs.benchmarks;

import haxe.ds.ArraySort;
import haxe.ds.StringMap;
import hxsuite.benchmarks.BenchmarkReport;
import haxe.Http;
import hxsuite.benchmarks.Benchmark;

class Benchmarks {

    public static var HOST_NAME:String = "localhost";
    public static var PORT:Int = 2001;

    static function main() {
        #if flash
        flash.system.Security.allowDomain("*");
        flash.system.Security.loadPolicyFile("http://" + HOST_NAME + ":" + PORT + "/crossdomain.xml");
        #end

        var b = new EcsTest();
//        var b = new BranchTest();
//        var b = new F32Test();
        #if cpp
        cpp.vm.Gc.enterGCFreeZone();
        #end

        b.run();

        #if cpp
        cpp.vm.Gc.exitGCFreeZone();
        #end

        trace("TARGET: " + haxe.macro.Compiler.getDefine("target"));
        trace("APP: " + haxe.macro.Compiler.getDefine("app"));
        printReport(b, exit);
    }

    static function exit() {
        trace("exit");
        #if (!nodejs && js)
        js.Browser.window.close();
        #elseif flash
        if(flash.external.ExternalInterface.available) {
            trace("close");
            flash.external.ExternalInterface.call("close");
        }
        flash.system.System.exit(0);
        #else
        Sys.exit(0);
        #end
    }

    static function printReport(benchmark:Benchmark, onCompleted:Void->Void) {
        trace("printReport: " + benchmark.reports);
        var loading:Int = 0;

        var keys:Array<String> = [];
        for(key in benchmark.reports.keys()) {
            keys.push(key);
        }
        ArraySort.sort(keys, function(a, b) {
            return Reflect.compare(a, b);
        });

        for(key in keys) {
            var r = benchmark.reports.get(key);
            var ops = r.timeAvg > 0.001 ? Std.string(Math.ffloor(r.ops / r.timeAvg)) : "IMMEDIATELY";
            var str = r.method + " : " + ops + " op/s (" + formatTime(r.timeAvg) + " ms.)";

            trace(str);
            trace(formatTime(r.timeMin) + " min / " + formatTime(r.timeMax) + " max - " + r.runs + " runs");

            ++loading;
        }

        // post results
        for(key in keys) {
            var r = benchmark.reports.get(key);
            postResult(r, function() {
                --loading;
                if(loading <= 0) {
                    onCompleted();
                }
            });
        }
    }

    static function formatTime(time:Float):Float {
        return Std.int(time * 1000 * 100) / 100;
    }

    static function postResult(report:BenchmarkReport, onCompleted:Void->Void) {
        var params:StringMap<String> = new StringMap();
        params.set("cmd", "post");

        params.set("app", haxe.macro.Compiler.getDefine("app"));
        params.set("target", haxe.macro.Compiler.getDefine("target"));

        params.set("suite", report.suite);
        params.set("method", report.method);

        params.set("time", Std.string(report.timeAvg));
        params.set("max", Std.string(report.timeMax));
        params.set("min", Std.string(report.timeMin));
        params.set("ops", Std.string(report.ops));

        var url = 'http://' + HOST_NAME + ":" + PORT;

        http(url, params,
            function(_) {
                onCompleted();
            },
            function(err) {
                trace(url);
                trace("ERROR: " + err);
                postResult(report, onCompleted);
            });
    }

    static function http(url:String, params:StringMap<String>, onCompleted:String->Void, onError:String->Void) {
        #if nodejs
        var list = [];
        for(key in params.keys()) {
            list.push(key + "=" + params.get(key));
        }
        var http = js.node.Http.get(url + "/?" + list.join("&"), function(response:js.node.http.IncomingMessage) {
            response.on("data", function() {
                onCompleted("");
            });
            response.on("error", function(err) {
                onError(err);
            });
        });
        #else
        var http = new haxe.Http(url + "/");
        for(key in params.keys()) {
            http.addParameter(key, params.get(key));
        }
        http.onData = function(data:String) {
            onCompleted(data);
        };
        http.onError = function(err:String) {
            onError(err);
        }
        http.request(false);
        #end
    }
}