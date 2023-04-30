package app;

import openfl.display.Sprite;
// Children
import app.addProject.ProjectName;
import app.addProject.OkButton;
import app.addProject.Title;

class AddProject {
    
    var addProject:Sprite;
    
    // Children
    public var projectName:ProjectName;
    public var okButton:OkButton;
    public var title:Title;

    public function new(core:Core){
        addProject = new Sprite();

        // Children
        projectName = new ProjectName(core);
        okButton = new OkButton(core);
        title = new Title(core);
        
        addProject.addChild(projectName.getProjectName());
        addProject.addChild(okButton.getOkButton());
        addProject.addChild(title.getTitle());

        refresh(core);
    }

    public function getAddProject(){
        return addProject;
    }

    public function refresh(core:Core){
       projectName.refresh(core); 
       okButton.refresh(core);
       title.refresh(core);
    }
}