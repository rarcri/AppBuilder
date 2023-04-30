package app;

import app.editorView.ToolBox;
import openfl.display.Sprite;
import app.editorView.Header;
import app.editorView.Panel;
import app.editorView.AppView;

class EditorView {
    var editorView:Sprite; 
    // Children
    public var header:Header;
    public var panel:Panel;
    public var appView:AppView;
    public var toolBox:ToolBox;

    public function new(core:Core){
        editorView = new Sprite();

        // Children
        header = new Header(core);
        panel = new Panel(core);
        appView = new AppView(core);
        toolBox = new ToolBox(core);

        
        editorView.addChild(header.getHeader());
        editorView.addChild(panel.getPanel());
        editorView.addChild(appView.getAppView());
        editorView.addChild(toolBox.getToolBox());

        refresh(core);
    }


    public function getEditorView(){
        return editorView;
    }
    
    public function refresh(core:Core){
        header.refresh(core);
        panel.refresh(core);
        toolBox.refresh(core);
        appView.refresh(core);
    }
} 
