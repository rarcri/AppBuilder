package app.addProject;

import feathers.controls.Button;
import feathers.events.TriggerEvent;
#if sys
import sys.io.File;
#end
import haxe.io.Path;

class OkButton {
    var okButton:Button;
    public var projectsPath:String;
    public var projectName:String;
    public var path:String; 
    public var homeDrive:String;

    public function new(core:Core){
        
        okButton = new Button("Crează");
        
        refresh(core);
        events(core);
    }

    public function getOkButton(){
        return okButton;
    }

    public function refresh(core:Core){
        // Size 
        okButton.width = 0.2 * core.stage.stageWidth;
        okButton.height = 0.1 * core.stage.stageHeight;
        

        // Position
        okButton.x = core.stage.stageWidth/2 - okButton.width/2;
        okButton.y = 0.7 * core.stage.stageHeight;
    }

    public function events(core:Core){
         okButton.addEventListener(TriggerEvent.TRIGGER, (e)->{

            projectsPath = core.initialScreen.openFolderButton.path; 
            projectName = core.addProject.projectName.getProjectName().text;


            // Path
            path = Path.join([projectsPath, projectName]).toString();
         

            if(sys.FileSystem.exists(path)){
                trace("Project exists");
            } else {

                trace(projectsPath);
                trace(projectName);
                // Aici creem un proiect OpenFl nou
                Sys.command("cd " + projectsPath + " && openfl create project " + projectName);

                // Pregatim proiectul pentru App Builder
                
            var source="";
                source = Path.join([path, "Source"]).toString();

                Sys.command("cd " + source + " && mkdir app");
                
            // xml file 
            var xml= Path.join([path, "project.xml"]).toString();
                trace(xml);

                // Adaugam feathersui in project.xml

                var projectXml = File.getContent(xml);

                var projectXmlRegex = ~/(?<=<haxelib name="openfl" \/>$)\n/gm;

                projectXml = projectXmlRegex.replace(projectXml,'
	<haxelib name="feathersui" />
    <window width="800" height="640"/>
');
                File.saveContent(xml, projectXml);

                // Creem fisierul Core.hx
                
                var content = 
"import openfl.display.Stage;
import openfl.display.Sprite;

class Core {
    var core:Sprite;
    public var stage:Stage;
    // var Children

    public function new(stage){
        this.stage = stage;

        core = new Sprite();

        // create Children

        // add Children


        refresh();
    }

    public function getCore(){
        return core;
    }

    public function refresh(){
        // refreshButton

    }

} ";

            // Save content
            var contentPath="";
                contentPath = Path.join([path, "Source/Core.hx"]).toString();
                trace(contentPath);

                File.saveContent(contentPath, content);

                // Change the Main.hx
                var mainPath = Path.join([projectsPath,projectName, "Source","Main.hx"]).toString();
                var mainContent = File.getContent(mainPath);

                var regex = ~/(?<=super...$)\n/mg;

                mainContent = regex.replace(mainContent,"
        var core = new Core(stage);
        this.addChild(core.getCore());

");
                
            // Save content

                File.saveContent(mainPath, mainContent);
                
            }
            
            core.getCore().removeChild(core.addProject.getAddProject());
            core.getCore().addChild(core.editorView.getEditorView());
            
        });
        
    }
}
