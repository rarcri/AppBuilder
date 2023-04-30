package;

import openfl.events.Event;
import openfl.display.Sprite;

class Main extends Sprite {
	var core:Core;

	public function new() {
		super();
		core = new Core(stage);

		this.addChild(core.getCore());
		events();
	}

	public function events() {
		// Resize
		stage.addEventListener(Event.RESIZE, (event) -> {
			core.refresh();
		});
	}
}
