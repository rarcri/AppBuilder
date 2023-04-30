package ui.editorView.toolbox.tools;
import openfl.display.Sprite;
import feathers.controls.Alert;
// Button
import feathers.controls.Button;
// Button Bar
import feathers.controls.ButtonBar;
import feathers.data.ArrayCollection;
import feathers.events.ButtonBarEvent;
//Check
import feathers.controls.Check;
import openfl.events.Event;
// ComboBox
import feathers.controls.ComboBox;
// Date Picker 
import feathers.controls.DatePicker;
// Drawer
import feathers.controls.Drawer;
import feathers.controls.LayoutGroup;
import feathers.layout.VerticalLayout;
import feathers.events.TriggerEvent;
// Form
import feathers.controls.Form;
import feathers.controls.FormItem;

    var buttonBar:ButtonBar;
    var comboBox:ComboBox;
    var datePicker:DatePicker;
    var drawer:Drawer;
    var form:Form;

        Alert.show("How are you","This is very nice",["ok"]);
        // Button Bar
        var buttonBar = new ButtonBar();
        buttonBar.dataProvider = new ArrayCollection([
            { text: "Latest Posts" },
            { text: "Profile" },
            { text: "Settings" }
        ]);

        buttonBar.itemToText = (item:Dynamic) -> {
            return item.text;
        };

        buttonBar.y = 50;

        buttonBar.addEventListener(ButtonBarEvent.ITEM_TRIGGER, (event)->{
        });

        tools.addChild(buttonBar);

        // Check
        var check = new Check();
        check.text = "Pick Me!";
        check.selected = true;
        check.y = 100;
        check.addEventListener(Event.CHANGE, (Event)->{

        });
        tools.addChild(check);

        // ComboBox
        comboBox = new ComboBox();

        comboBox.dataProvider = new ArrayCollection([
            { text: "Milk" },
            { text: "Eggs" },
            { text: "Bread" },
            { text: "Steak" },
        ]);

        comboBox.itemToText = (item:Dynamic) -> {
            return item.text;
        };

        comboBox.y = 150;

        comboBox.addEventListener(Event.CHANGE, (event:Event) -> {
            var comboBox = cast(event.currentTarget, ComboBox);
            trace("ComboBox changed: " + comboBox.selectedIndex + " " + comboBox.selectedItem.text);
        });

        tools.addChild(comboBox); 

        // Date Picker
        datePicker = new DatePicker();
        datePicker.selectedDate = new Date(2020, 1, 6,0,0,0);
        datePicker.y = 300;
        datePicker.addEventListener(Event.CHANGE, (event:Event) -> {
            var datePicker = cast(event.currentTarget, DatePicker);
            trace("DatePicker changed: " + datePicker.selectedDate);
        });
        tools.addChild(datePicker);

        // Drawer
        drawer = new Drawer();
        tools.addChild(drawer);

        var content = new LayoutGroup();
        var contentLayout = new VerticalLayout();
        contentLayout.horizontalAlign = CENTER;
        contentLayout.verticalAlign = MIDDLE;
        content.layout = contentLayout;
        var openDrawerButton = new Button();
        openDrawerButton.text = "Open Drawer";
        content.addChild(openDrawerButton);

        drawer.content = content; 
        var layoutGroup= new LayoutGroup();
        var drawerLayout = new VerticalLayout();
        drawerLayout.horizontalAlign = CENTER;
        drawerLayout.verticalAlign = MIDDLE;
        layoutGroup.layout = drawerLayout;
        var closeDrawerButton = new Button();
        closeDrawerButton.text = "Close Drawer";
        layoutGroup.addChild(closeDrawerButton);

        drawer.drawer = layoutGroup;
        openDrawerButton.addEventListener(TriggerEvent.TRIGGER, (event) -> {
            drawer.opened = true;
          });
          
        closeDrawerButton.addEventListener(TriggerEvent.TRIGGER, (event) -> {
            drawer.opened = false;
          });


        // Form 
        var formItem = new FormItem("this is nice");
        form = new Form();
        form.y = 400;
        form.addChild(formItem);
        tools.addChild(form);