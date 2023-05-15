package app.settingsView;

import feathers.controls.Label;
import feathers.text.TextFormat;

class CurrentView{
    var currentView:Label;

    public function new(core:Core){
        currentView = new Label("Settings View");

        refresh(core);
    }

    public function getCurrentView(){
        return currentView;
    }

    public function refresh(core:Core){
        // Size
        currentView.width = 0.5 * core.stage.stageWidth;
        currentView.height = 0.1 * core.stage.stageHeight;

        // Position 
        currentView.x = 0.6 * core.stage.stageWidth;
        currentView.y = 0.16 * core.stage.stageHeight;

	    currentView.textFormat = new TextFormat("Arial", Std.int(0.02 * core.stage.stageWidth),0xffffff);

    }
}