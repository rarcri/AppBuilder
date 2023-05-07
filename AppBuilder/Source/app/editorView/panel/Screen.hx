package app.editorView.panel;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import feathers.controls.Label;
import feathers.controls.Radio;
import feathers.controls.Button;
import openfl.events.Event;
import app.editorView.appView.AppButton;


#if sys
import sys.io.File;
#end

class Screen{
    var screen:Sprite;
    public var deleteIcon:Bitmap;
    public var text:Label;
    public var radioButton:Radio;
    public var y:Float;
    public var elements:Sprite;

    public function new(core:Core){
        screen = new Sprite();
        elements = new Sprite();

		// deleteIcon
		deleteIcon = new Bitmap(Assets.getBitmapData("assets/delete-bin-fill.png"));
		screen.addChild(deleteIcon);

        // Text
        text = new Label();
        screen.addChild(text);

        // Checkbox
        radioButton = new Radio();
        screen.addChild(radioButton);

        refresh(core);
        events(core);
    }

    public function getScreen(){
        return screen;
    }

    public function refresh(core:Core){

        screen.x = 0.1 * core.stage.stageWidth - 0.15*core.stage.stageWidth/2;


        text.x = 0.03 * core.stage.stageWidth;

        deleteIcon.width = 0.03*core.stage.stageHeight;
        deleteIcon.height = 0.03*core.stage.stageHeight;
        deleteIcon.x = 0.12 * core.stage.stageWidth;
        

        trace(screen.width);
    }

    public function events(core:Core){
        radioButton.addEventListener(Event.CHANGE,(e:Event)->{
            
            if(core.editorView != null){

                var path = core.addProject.okButton.path;

                // resetam Elementele
                var screens = core.editorView.panel.screens;
                for(i in 0...screens.length){
                    screens[i].elements.removeChildren();
                }



                function searchFor(a:String,b:String){

                    var regex = new EReg("^.*\\."+a+".*","gm");
                    regex.match(b);
                    var matched = regex.matched(0);

                    var regex1 = ~/0\.\d{1,20}/gm;
                    regex1.match(matched);
                    trace(a+" "+regex1.matched(0));
                    
                    return regex1.matched(0);
                }

                var folder = "screen" + (core.editorView.panel.toggleGroup.selectedIndex+1);
                // We search in current Folder for elements
                var components = sys.FileSystem.readDirectory(path+"/Source/app/"+folder); 
                for(component in components){
                    var componentContent = File.getContent(path+"/Source/app/"+folder+"/"+component);

                    // Screen Index
                    var reg = ~/\d/mg;
                    reg.match(folder);
                    var screenIndex = Std.parseInt(reg.matched(0));

                    // ComponentType
                    var reg1 = ~/(?<=controls.)[A-z]*/mg;
                    reg1.match(componentContent);
                    var componentType = reg1.matched(0);
                    
                    var componentWidth = Std.parseFloat(searchFor("width",componentContent));
                    var componentHeight = Std.parseFloat(searchFor("height",componentContent));
                    var componentX = Std.parseFloat(searchFor("x",componentContent));
                    var componentY = Std.parseFloat(searchFor("y",componentContent));

                    if(componentType == "Button"){

                        reg = ~/(?<=new Button\(')[A-z]{0,50}/gm;
                        reg.match(componentContent);
                        var buttonText = reg.matched(0);

                        // New Button
                        var button = new Button(buttonText);
                        // Size
                        button.width = componentWidth * core.editorView.appView.width ;
                        button.height = componentHeight* core.editorView.appView.height ;

                        // Position
                        button.x = componentX * core.editorView.appView.width;
                        button.y = componentY * core.editorView.appView.height;

                        core.editorView.panel.screens[screenIndex-1].elements.addChild(button);
                        
                    }

                }
                // Clear the view
                core.editorView.appView.getAppView().removeChildren();

                // Add elements 
                var screenIndex = core.editorView.panel.toggleGroup.selectedIndex;
                core.editorView.appView.getAppView().addChild(core.editorView.panel.screens[screenIndex].elements);
                trace(core.editorView.panel.screens[screenIndex].elements.numChildren);
                trace("ScreenIndex: "+screenIndex);

            }
        });
    }

}