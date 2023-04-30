import app.AddProject;
import haxe.display.Protocol.InitializeParams;
import app.InitialScreen;
import app.EditorView;
import openfl.display.Stage;
import openfl.display.Sprite;

class Core {

    var core:Sprite;	
    public var stage:Stage;

    //Children
    public var initialScreen:InitialScreen;
    public var addProject:AddProject;
    public var editorView:EditorView;


    public function new(stage){
        this.stage = stage;

        core = new Sprite();

        // Children

        initialScreen = new InitialScreen(this);
        addProject = new AddProject(this);
        editorView = new EditorView(this);

        // Add
        core.addChild(initialScreen.getInitialScreen());

    }

    public function getCore(){
        return core; 
    }

    public function refresh(core){
        initialScreen.refresh(core);
        addProject.refresh(core);
        editorView.refresh(core);
    }
}
