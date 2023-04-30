package app.editorView;

import openfl.display.Sprite;
import app.editorView.toolbox.Tools;


class ToolBox {
    
    var toolBox:Sprite;
    // Children
    public var tools:Tools;

    public function new(core){
        toolBox = new Sprite(); 

        tools = new Tools(core);

        toolBox.addChild(tools.getTools());
        refresh(core);
    }

    public function getToolBox(){
        return toolBox;
    }

    public function refresh(core){
        tools.refresh(core);
    }
}