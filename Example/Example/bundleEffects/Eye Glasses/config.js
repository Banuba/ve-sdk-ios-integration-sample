function Effect() {
    var self = this;
    var c = 0.5;
    var sec = 0;
    var lastFrame;
    this.play = function () {
        var now = (new Date()).getTime();
        sec += (now - lastFrame) / 1000;
        Api.meshfxMsg("shaderVec4", 0, 0, String(sec));
        //Api.showHint(String(sec));
        lastFrame = now;
    }

    function frac(f) {
        return f % 1;
    }

    this.init = function () {
        Api.meshfxMsg("spawn", 2, 0, "!glfx_FACE");

        Api.meshfxMsg("spawn", 0, 0, "BabyFace.bsm2");
        // Api.meshfxMsg("animOnce", 0, 0, "static");

        Api.meshfxMsg("spawn", 1, 0, "glasses.bsm2");
        // Api.meshfxMsg("animOnce", 1, 0, "static");

        if (Api.getPlatform() == "ios") {
            Api.meshfxMsg("spawn", 3, 0, "tri.bsm2");
        };

        Api.playVideo("frx", true, 1);
        // Api.playSound("FES_music_L_Channel.m4a", true, 1);

        lastFrame = (new Date()).getTime();
        Api.showRecordButton();
    };

    this.restart = function () {
        Api.meshfxReset();
        // Api.stopVideo("frx");
        // Api.stopSound("sfx.aac");
        self.init();
    };

    this.faceActions = [self.play];
    this.noFaceActions = [self.play];

    this.videoRecordStartActions = [];
    this.videoRecordFinishActions = [];
    this.videoRecordDiscardActions = [this.restart];
}

configure(new Effect());