package app.editorView;

import openfl.display.Sprite;

class AppView {

  var appView:Sprite;
  // Atributes
  public var width:Float;
  public var height:Float;

  public function new(core){
    appView = new Sprite();    

    refresh(core); 
  }

  public function getAppView(){
    return appView;
  }

  public function refresh(core){

    // Set Dimensions
    width = 0.58 * core.stage.stageWidth;
    height = 9/16 * width; 

    var x = 0; 
    var y = 0; 

    // Clear 
    appView.graphics.clear();
    // Begin Fill
    appView.graphics.beginFill(0x444444);


    // Draw Round Rect
    appView.graphics.drawRoundRect(x,y,width,height,10,10);
    appView.graphics.endFill();

    // Position
    appView.x = 0.21 * core.stage.stageWidth;
    appView.y = core.stage.stageHeight/2 - height/2;

  }
}
