package app.titleView;

import feathers.controls.Button;
import feathers.events.TriggerEvent;
import openfl.events.Event;


class SaveButton{
    var saveButton:Button;
    public var currentComponent:String;

    public function new(core:Core){
        saveButton = new Button("Save");
        refresh(core);
        events(core);
    }

    public function getSaveButton(){
        return saveButton;
    }

    public function refresh(core:Core){
        saveButton.width = 0.2 * core.stage.stageWidth;
        saveButton.height = 0.1 * core.stage.stageHeight;

        saveButton.x = 0.6 * core.stage.stageWidth;
        saveButton.y = 0.1 * core.stage.stageHeight-saveButton.height/2;
    }

    public function events(core:Core){

        saveButton.addEventListener(TriggerEvent.TRIGGER,(e)->{

            var screenName = "Screen"+(core.editorView.panel.toggleGroup.selectedIndex+1);
            var uppercaseScreenName = screenName.substring(0,1).toUpperCase() + screenName.substring(1);
            var lowercaseScreenName = screenName.substring(0,1).toLowerCase() + screenName.substring(1);
            var componentPath = core.addProject.okButton.path +"/Source/app/" + lowercaseScreenName+"/"+currentComponent;
 
            // Component content
            var componentContent = sys.io.File.getContent(componentPath);

            var regex = ~/(?<=\/\/ Title\s)[\w\W]*(?=\/\/ End Title)/gm;
            var saveContent = regex.replace(componentContent,core.titleView.codeArea.getCodeArea().text);


            sys.io.File.saveContent(componentPath, saveContent);

            // Refresh radioButton();
            var index = core.editorView.panel.toggleGroup.selectedIndex;
            core.editorView.panel.toggleGroup.selectedIndex = 0;
            core.editorView.panel.toggleGroup.selectedIndex = index;

        });
    }
}