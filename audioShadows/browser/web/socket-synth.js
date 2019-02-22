var example = example || {};

(function () {
    "use strict";

    window.onload = function() {
        AudioShadowsKit.drawTwoShadows('mainCanvas', 0, 0, 0);
    };


    example.SocketSynth = function () {
        this.oscPort = new osc.WebSocketPort({
            url: "ws://192.168.178.37:8081"
        });

        this.listen();
        this.oscPort.open();

        this.oscPort.socket.onmessage = function (e) {
            console.log("message", e);
        };

    };

    example.SocketSynth.prototype.listen = function () {

        this.oscPort.on("message", this.mapMessage.bind(this));
        this.oscPort.on("message", function (msg) {
            console.log("message", msg);
        });
    };


    example.SocketSynth.prototype.mapMessage = function (oscMessage) {
        $("#message").text(fluid.prettyPrintJSON(oscMessage));

        var address = oscMessage.address;
        var value = oscMessage.args[0];


        AudioShadowsKit.clearCanvas('mainCanvas');
        AudioShadowsKit.drawTwoShadows('mainCanvas', value, 0, 0);


    };

}());
