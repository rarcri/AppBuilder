package app.editorView.toolbox;

import feathers.controls.ScrollContainer;
import app.editorView.toolbox.tools.Button;
import app.editorView.toolbox.tools.Label;
import app.editorView.toolbox.tools.TextInput;
import app.editorView.toolbox.tools.Check;
import app.editorView.toolbox.tools.TextArea;
import app.editorView.toolbox.tools.Radio;
import app.editorView.toolbox.tools.PopUpDatePicker;


class Tools{
    var tools:ScrollContainer;
    // Children
    public var button:Button;
    public var label:Label;
    public var textInput:TextInput;
    public var check:Check;
    public var textArea:TextArea;
    public var radio:Radio;
    public var popUpDatePicker:PopUpDatePicker;

    public function new(core){
        tools = new ScrollContainer();

        button = new Button(core);
        label = new Label(core);
        textInput = new TextInput(core);
        check = new Check(core);
        textArea = new TextArea(core);
        radio = new Radio(core);
        popUpDatePicker = new PopUpDatePicker(core);

        // Children
        tools.addChild(button.getButton());
        tools.addChild(label.getLabel());
        tools.addChild(textInput.getTextInput());
        tools.addChild(check.getCheck());
        tools.addChild(textArea.getTextArea());
        tools.addChild(radio.getRadio());
        tools.addChild(popUpDatePicker.getPopUpDatePicker());

        refresh(core);
    }

    public function getTools(){
        return tools;
    }

    public function refresh(core){
        tools.width = core.stage.stageWidth * 0.2;
        tools.height = 0.9 * core.stage.stageHeight;

        tools.x = 0.8 * core.stage.stageWidth;
        tools.y = 0.1 * core.stage.stageHeight;


        // Children
        button.refresh(core);
        label.refresh(core);
        textInput.refresh(core);
        check.refresh(core);
        textArea.refresh(core);
        radio.refresh(core);
        popUpDatePicker.refresh(core);

    }
}