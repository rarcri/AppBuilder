package app.editorView;
import openfl.display.Sprite;
import app.editorView.header.RunButton;
import app.editorView.header.NewButton;

class Header {
	var header:Sprite;

	// Children
	var runButton:RunButton;
	var newButton:NewButton;

	public function new(core:Core) {
		header = new Sprite();

		// Children
		runButton = new RunButton(core);
		newButton = new NewButton(core);

		header.addChild(runButton.getRunButton());
		header.addChild(newButton.getNewButton());
		refresh(core);
	}

	public function getHeader() {
		return header;
	}

	public function refresh(core:Core) {
		// Children
		runButton.refresh(core);
		newButton.refresh(core);

		header.graphics.clear();
		header.graphics.beginFill(0x00aaff);
		header.graphics.drawRect(0,0,core.stage.stageWidth,0.1 * core.stage.stageHeight);
	}
}
