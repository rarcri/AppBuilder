package app.editorView;
import openfl.display.Sprite;
import app.editorView.header.RunButton;
import app.editorView.header.NewButton;
import app.editorView.header.EventsButton;
import app.editorView.header.OpenButton;
import app.editorView.header.SettingsButton;
import app.editorView.header.TitleButton;

class Header {
	var header:Sprite;

	// Children
	var runButton:RunButton;
	var newButton:NewButton;
	var openButton:OpenButton;
	var eventsButton:EventsButton;
	var settingsButton:SettingsButton;
	var titleButton:TitleButton;

	public function new(core:Core) {
		header = new Sprite();

		// Children
		runButton = new RunButton(core);
		newButton = new NewButton(core);
		eventsButton = new EventsButton(core);
		openButton = new OpenButton(core);
		settingsButton = new SettingsButton(core);
		titleButton = new TitleButton(core);

		header.addChild(runButton.getRunButton());
		header.addChild(newButton.getNewButton());
		header.addChild(openButton.getOpenButton());
		header.addChild(eventsButton.getEventsButton());
		header.addChild(settingsButton.getSettingsButton());
		header.addChild(titleButton.getTitleButton());

		refresh(core);
	}

	public function getHeader() {
		return header;
	}

	public function refresh(core:Core) {
		// Children
		runButton.refresh(core);
		newButton.refresh(core);
		openButton.refresh(core);
		eventsButton.refresh(core);
		settingsButton.refresh(core);
		titleButton.refresh(core);

		header.graphics.clear();
		header.graphics.beginFill(0x00aaff);
		header.graphics.drawRect(0,0,core.stage.stageWidth,0.1 * core.stage.stageHeight);
	}
}
