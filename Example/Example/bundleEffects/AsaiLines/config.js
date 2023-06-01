let isPlaying = true;

function Effect() {
    var self = this;
    
    this.faceActions = [];
    this.noFaceActions = [];
    this.videoRecordStartActions = [];
    this.videoRecordFinishActions = [];
    this.videoRecordDiscardActions = [];
    
    this.init = function() {
        Api.showRecordButton();
        
        Api.meshfxMsg("spawn", 0, 0, "!glfx_FACE");
        Api.playVideo("frx", true, 1);
        // Api.playVideo("foreground", true, 1);
        isPlaying && Api.playSound("LinesBGM.ogg", true, 1);
    };
}

function stopMusic(){
    isPlaying = false;
    Api.stopSound("LinesBGM.ogg");
}

configure(new Effect());
