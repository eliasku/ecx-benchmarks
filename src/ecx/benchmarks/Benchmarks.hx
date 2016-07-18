package ecx.benchmarks;

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
        b.run();

        trace("TARGET: " + haxe.macro.Compiler.getDefine("target"));
        printReport(b, function() {
            exit();
        });
    }


    static function exit() {
        #if (!nodejs && js)
        js.Browser.window.close();
        #elseif flash
        if(flash.external.ExternalInterface.available) {
            flash.external.ExternalInterface.call("close");
        }
        flash.system.System.exit(0);
        #else
        Sys.exit(0);
        #end
    }

    static function printReport(benchmark:Benchmark, onCompleted:Void->Void) {
        var loading:Int = 0;

        for(r in benchmark.reports) {
            var ops = r.timeAvg > 0.001 ? Std.string(Math.ffloor(r.ops / r.timeAvg)) : "IMMEDIATELY";
            var str = r.method + " : " + ops + " op/s (" + formatTime(r.timeAvg) + " ms.)";

            trace(str);
            trace(formatTime(r.timeMin) + " min / " + formatTime(r.timeMax) + " max - " + r.runs + " runs");

            ++loading;
        }

        // post results
        for(r in benchmark.reports) {
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
        params.set("suite", report.suite);
        params.set("method", report.method);
        params.set("time", Std.string(report.timeAvg));
        params.set("max", Std.string(report.timeMax));
        params.set("min", Std.string(report.timeMin));
        params.set("ops", Std.string(report.ops));
        params.set("target", haxe.macro.Compiler.getDefine("target"));

        var url = 'http://' + HOST_NAME + ":" + PORT;

        #if nodejs
        var list = [];
        for(key in params.keys()) {
            list.push(key + "=" + params.get(key));
        }
        var http = js.node.Http.get(url + "/?" + list.join("&"), function(response:js.node.http.IncomingMessage) {
            response.on("data", function() {
                onCompleted();
            });
        });
        #else
        var http = new haxe.Http(url + "/");
        for(key in params.keys()) {
            http.addParameter(key, params.get(key));
        }
        http.onData = function(data:String) {
            trace("DATA: " + data);
            onCompleted();
        };
        http.onError = function(msg:String) {
            trace(url);
            trace("ERROR: " + msg);
        }
        http.request(false);
        #end
    }
}