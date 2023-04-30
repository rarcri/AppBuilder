package app.editorView;

import feathers.controls.ScrollContainer;

class Panel{
    var panel:ScrollContainer;

    public function new(core:Core){
        panel = new ScrollContainer();
    }

    public function getPanel(){
        return panel;
    }

    public function refresh(core:Core){

        panel.width = core.stage.stageWidth * 0.2;
        panel.height = 0.9 * core.stage.stageHeight;

        panel.x = 0; 
        panel.y = 0.1 * core.stage.stageHeight;

    }
}