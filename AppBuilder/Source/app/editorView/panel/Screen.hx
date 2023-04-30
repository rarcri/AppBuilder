package app.editorView.panel;

import openfl.display.Sprite;
import feathers.controls.Label;

class Screen{
    var screen:Label;
    public var y:Float;

    public function new(core:Core){
        screen = new Label();
        refresh(core);

    }

    public function getScreen(){
        return screen;
    }

    public function refresh(core:Core){
        screen.width = 0.1 * core.stage.stageWidth;
        screen.height = 0.05 * core.stage.stageHeight;

        screen.x = 0.1 * core.stage.stageWidth - screen.width/2;
        screen.y = y;
    }

}