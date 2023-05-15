package app.titleView;

import feathers.controls.TextArea;


class CodeArea{
    var codeArea:TextArea;

    public function new(core:Core){
        codeArea = new TextArea();
        refresh(core);
    }

    public function getCodeArea(){
        return codeArea;
    }

    public function refresh(core:Core){
        codeArea.width = 0.5 * core.stage.stageWidth;
        codeArea.height = 0.18 * core.stage.stageHeight;

        codeArea.x = 0.01 * core.stage.stageHeight;
        codeArea.y = 0.01 * core.stage.stageHeight;
    }
}