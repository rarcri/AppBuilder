package app.addProject;

import feathers.text.TextFormat;
import feathers.controls.Label;

class Title {
    var title:Label;

    public function new(core){
        
        title = new Label("Introduceți numele proiectului:");
        
        refresh(core);
    }

    public function getTitle(){
        return title;
    }

    public function refresh(core){

        // Text Style
        title.textFormat = new TextFormat("Arial",Std.int(0.05*core.stage.stageHeight),0x333333);
        title.wordWrap = true;
        // Size 
        title.width = 0.4 * core.stage.stageWidth;
        title.height = 0.3 * core.stage.stageHeight;

        // Position
        title.x = core.stage.stageWidth/2 - title.width/2;
        title.y = 0.2 * core.stage.stageHeight;
    }
}