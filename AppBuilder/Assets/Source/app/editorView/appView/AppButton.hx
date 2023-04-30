package app.editorView.appView;

import feathers.controls.Button;
import app.editorView.appView.appButton.Code;

class AppButton {
    var appButton:Button;
    public var code:Code;
    public var width:Float;
    public var height:Float;
    public var x:Float;
    public var y:Float;

    public function new(core:Core){
        appButton = new Button("Button");
        code = new Code();

        refresh(core);
    }

    public function getAppButton(){
        return appButton;
    }

    public function refresh(core:Core){
        appButton.width = width; 
        appButton.height = height; 

        appButton.x = x;
        appButton.y = y;
    }

}