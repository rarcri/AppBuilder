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

    // Size
    appView.width = 0.58 * core.stage.stageWidth;
    appView.height = 9/16 * appView.width;

    // Position
    appView.x = 0.2 * core.stage.stageWidth;
    appView.y = core.stage.stageHeight/2 - appView.height/2;

    // Set Dimensions
    width = 0.58 * core.stage.stageWidth;
    height = 9/16 * width; 

    var x = 0.01 * core.stage.stageWidth; 
    var y = 0; 

    // Clear 
    appView.graphics.clear();
    // Begin Fill
    appView.graphics.beginFill(0x444444);


    // Draw Round Rect
    appView.graphics.drawRoundRect(x,y,width,height,10,10);
    appView.graphics.endFill();
  }
}
