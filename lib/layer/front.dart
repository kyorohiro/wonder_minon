part of wonder_minon;

class Front extends umi.Scene {
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.Joystick joystick;
  umi.ExDrag joystickExDrag;

  umi.Sprite buttonL;
  umi.ExButton buttonLEx;
  umi.ExDrag buttonLExDrag;

  umi.Sprite buttonR;
  umi.ExButton buttonREx;
  umi.ExDrag buttonRExDrag;

  umi.Sprite buttonStop;
  umi.ExButton buttonStopEx;

  bool _isStop = false;

  Front():super(
      begineColor:new umi.Color(0x00ffffff),
      endColor:new umi.Color(0xffffffff),
      duration:1000);

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene");
    this.builder = stage.context;

    // L
    buttonL = new umi.Sprite.empty(w:200.0,h:200.0,color:new umi.Color.argb(0xaa, 0xaa, 0xaa, 0xff));
    buttonL.addExtension(buttonLEx= new umi.ExButton(buttonL, "l", (String l){}));
    buttonL.addExtension(buttonLExDrag= new umi.ExDrag(buttonL));
    buttonLExDrag.use = false;
    // R
    buttonR = new umi.Sprite.empty(w:200.0,h:200.0,color:new umi.Color.argb(0xaa, 0xaa, 0xff, 0xaa));
    buttonR.addExtension(buttonREx= new umi.ExButton(buttonL, "r", (String l){}));
    buttonR.addExtension(buttonRExDrag= new umi.ExDrag(buttonR));
    buttonRExDrag.use = false;

    // S
    buttonStop = new umi.Sprite.empty(w:200.0,h:50.0,color:new umi.Color.argb(0xaa, 0xff, 0x88, 0x88));
    buttonStop.addExtension(buttonStopEx= new umi.ExButton(buttonL, "s", (String l){
      _isStop = (_isStop?false:true);
      if(_isStop) {
        buttonREx.use = false;
        buttonLEx.use = false;

        buttonRExDrag.use = true;
        buttonLExDrag.use = true;
        joystickExDrag.use = true;

      } else {
        buttonREx.use = true;
        buttonLEx.use = true;

        buttonRExDrag.use = false;
        buttonLExDrag.use = false;
        joystickExDrag.use = false;

      }
    }));

    joystick = new umi.Joystick();
    joystick.addExtension(joystickExDrag= new umi.ExDrag(joystick));
    joystickExDrag.use = false;
    addChild(buttonL);
    addChild(buttonR);
    addChild(joystick);
    addChild(buttonStop);
    resetController(stage);
  }

  void onChangeStageStatus(umi.Stage stage, umi.DisplayObject parent) {
    resetController(stage);
  }

  void resetController(umi.Stage stage){
    if (joystick != null) {
      joystick.x = 100.0;
      joystick.y = stage.h - 100.0;
      joystick.scaleX = 2.2;
      joystick.scaleY = 2.2;
    }
    if (buttonL != null) {
      buttonL.x = stage.w - 130.0;
      buttonL.y = stage.h - 70.0;
      buttonL.scaleX = 0.2;
      buttonL.scaleY = 0.2;
    }
    if (buttonR != null) {
      buttonR.x = stage.w - 60.0;
      buttonR.y = stage.h - 100.0;
      buttonR.scaleX = 0.2;
      buttonR.scaleY = 0.2;
    }
    if (buttonStop != null) {
      buttonStop.x = stage.w / 2; //-buttonStop.w/2;
      buttonStop.y = stage.h - 50.0;
      buttonStop.scaleX = 0.2;
      buttonStop.scaleY = 0.2;
    }
  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
  }
}
