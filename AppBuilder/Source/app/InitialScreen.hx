package app;

import app.initialScreen.OpenFolderButton;
import openfl.display.Sprite;

class InitialScreen{
    var initialScreen:Sprite;

    // Children
    public var openFolderButton:OpenFolderButton;

    public function new(core){
        initialScreen = new Sprite();
        openFolderButton = new OpenFolderButton(core);

        initialScreen.addChild(openFolderButton.getOpenFolderButton());

        refresh(core);
    }

    public function getInitialScreen(){
        return initialScreen;
    }

    public function refresh(core){
       openFolderButton.refresh(core); 
    }
}