package app.editorView;

import feathers.controls.ScrollContainer;
import app.editorView.panel.AddScreenButton;
import app.editorView.panel.Screen;

class Panel{
    var panel:ScrollContainer;
    var addScreenButton:AddScreenButton;
    var y:Float;
    var screens:Array<Screen>=[];

    public function new(core:Core){
        y = 0.12 * core.stage.stageHeight;

        panel = new ScrollContainer();

        addScreenButton = new AddScreenButton(core);

        panel.addChild(addScreenButton.getAddScreenButton());
        

        var screen = new Screen(core);

        screen.getScreen().y = y;
        screen.getScreen().text = "Screen1";

        panel.addChild(screen.getScreen());
        
    }

    public function getPanel(){
        return panel;
    }

    public function addScreen(text,core){
        y = y + 0.07 * core.stage.stageHeight;

        var screen = new Screen(core);
        screen.getScreen().y = y;
        screen.getScreen().text = text;
        screens.push(screen);


        panel.addChild(screen.getScreen());

        var textAux;
        textAux = text.substring(0,1).toLowerCase() + text.substring(1);

        Sys.command("cd "+core.addProject.okButton.path+"/Source/app && mkdir "+textAux);
    }

    public function refresh(core:Core){


        panel.width = core.stage.stageWidth * 0.2;
        panel.height = 0.9 * core.stage.stageHeight;

        panel.x = 0; 
        panel.y = 0.1 * core.stage.stageHeight;

        // Children
        addScreenButton.refresh(core);

        for(screen in screens){
            screen.refresh(core);
        }
    }
}