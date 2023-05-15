import haxe.display.Protocol.InitializeParams;
import app.AddProject;
import app.InitialScreen;
import app.EditorView;
import app.EventView;
import app.SettingsView;
import app.TitleView;
import openfl.display.Stage;
import openfl.display.Sprite;

class Core {

    var core:Sprite;	
    public var stage:Stage;
    public var ionel:Stage;

    //Children
    public var initialScreen:InitialScreen;
    public var addProject:AddProject;
    public var editorView:EditorView;
    public var eventView:EventView;
    public var settingsView:SettingsView;
    public var titleView:TitleView;


    public function new(stage){
        this.stage = stage;

        core = new Sprite();

        // Children
        initialScreen = new InitialScreen(this);
        addProject = new AddProject(this);
        editorView = new EditorView(this);
        eventView = new EventView(this);
        settingsView = new SettingsView(this);
        titleView = new TitleView(this);

        // Add
        core.addChild(initialScreen.getInitialScreen());

    }

    public function getCore(){
        return core; 
    }

    public function refresh(){
        initialScreen.refresh(this);
        addProject.refresh(this);
        editorView.refresh(this);
        eventView.refresh(this);
        settingsView.refresh(this);
        titleView.refresh(this);
    }
}
