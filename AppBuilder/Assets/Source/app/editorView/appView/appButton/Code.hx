package app.editorView.appView.appButton;

class Code{

    public var name:String;
    public var text:String;
    public var width:String;
    public var height:String;
    public var x:String;
    public var y:String;
    public var uppercaseName:String;
    public var lowercaseName:String;
    
    public function new(){
    }

    public function getCode(){

        uppercaseName = name.substring(0,1).toUpperCase() + name.substring(1);
        lowercaseName = name.substring(0,1).toLowerCase() + name.substring(1);


        return "package app;

import feathers.controls.Button;

class "+ uppercaseName+" {
    var "+lowercaseName+":Button;

    public function new(core:Core){
        "+lowercaseName+"= new Button('"+text+"');

        refresh(core);
    }

    public function get"+uppercaseName+"(){
        return "+lowercaseName+";
    }

    public function refresh(core:Core){
        "+lowercaseName+".width = "+width+";
        "+lowercaseName+".height = "+height+";

        "+lowercaseName+".x = "+x+";
        "+lowercaseName+".y = "+y+";
    }
}";
    }
}