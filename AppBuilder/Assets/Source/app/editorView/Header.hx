package app.editorView;
import openfl.display.Sprite;
import app.editorView.header.RunButton;

class Header {
	var header:Sprite;

	// Children
	var runButton:RunButton;

	public function new(core:Core) {
		header = new Sprite();

		// Children
		runButton = new RunButton(core);

		header.addChild(runButton.getRunButton());
		refresh(core);
	}

	public function getHeader() {
		return header;
	}

	public function refresh(core:Core) {
		// Children
		runButton.refresh(core);

		header.graphics.clear();
		header.graphics.beginFill(0x00aaff);
		header.graphics.drawRect(0,0,core.stage.stageWidth,0.1 * core.stage.stageHeight);
	}
}
