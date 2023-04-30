package app.editorView.toolbox;

import feathers.controls.ScrollContainer;
import app.editorView.toolbox.tools.Button;


class Tools{
    var tools:ScrollContainer;
    // Children
    public var button:Button;

    public function new(core){
        tools = new ScrollContainer();

        button = new Button(core);

        // Children
        tools.addChild(button.getButton());

        refresh(core);
    }

    public function getTools(){
        return tools;
    }

    public function refresh(core){
        tools.width = core.stage.stageWidth * 0.2;
        tools.height = 0.9 * core.stage.stageHeight;

        tools.x = 0.8 * core.stage.stageWidth;
        tools.y = 0.1 * core.stage.stageHeight;


        // Children
        button.refresh(core);

    }
}