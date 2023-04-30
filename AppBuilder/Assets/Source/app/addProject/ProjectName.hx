package app.addProject;

import feathers.controls.TextInput;

class ProjectName {
    var projectName:TextInput;

    public function new(core){
        projectName = new TextInput();
        refresh(core);
    }

    public function getProjectName(){
        return projectName;
    }
    
    public function refresh(core){
        // Size 
        projectName.width = core.stage.stageWidth * 0.4;
        projectName.height = core.stage.stageHeight * 0.1;

        // Position
        projectName.x = core.stage.stageWidth/2 - projectName.width /2;
        projectName.y = 0.4 * core.stage.stageHeight;
    }
}