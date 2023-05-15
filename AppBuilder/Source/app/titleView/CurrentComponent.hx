package app.titleView;

import feathers.controls.Label;
import feathers.text.TextFormat;

class CurrentComponent{
    var currentComponent:Label;

    public function new(core:Core){
        currentComponent = new Label("None");

        refresh(core);
    }

    public function getCurrentComponent(){
        return currentComponent;
    }

    public function refresh(core:Core){
        // Size
        currentComponent.width = 0.5 * core.stage.stageWidth;
        currentComponent.height = 0.1 * core.stage.stageHeight;

        // Position 
        currentComponent.x = 0.6 * core.stage.stageWidth;
        currentComponent.y = 0;

	    currentComponent.textFormat = new TextFormat("Arial", Std.int(0.02 * core.stage.stageWidth),0xffffff);

    }
}