part of wonder_minon;

class Front extends umi.Scene {
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.Joystick joystick;
  umi.Sprite buttonL;
  umi.ExButton buttonLEx;
  umi.Sprite buttonR;
  umi.ExButton buttonREx;


  Front():super(
      begineColor:new umi.Color(0x00ffffff),
      endColor:new umi.Color(0xffffffff),
      duration:1000);

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene");
    this.builder = stage.context;

    Future.wait([builder.loadImage("assets/se_play.png"), builder.loadString("assets/se_play.json")]).then((List<Object> vs) {
      umi.Image image = vs[0];
      umi.SpriteSheetInfo spriteInfo = new umi.SpriteSheetInfo.fronmJson(vs[1]);
/*
      umi.Rect src2 = spriteInfo.frameFromFileName("BT01.png").srcRect;
      umi.Rect dst2 = spriteInfo.frameFromFileName("BT01.png").dstRect;

      umi.Rect src1 = spriteInfo.frameFromFileName("BT02.png").srcRect;
      umi.Rect dst1 = spriteInfo.frameFromFileName("BT02.png").dstRect;
*/
      //1
      buttonL = new umi.Sprite.empty(w:200.0,h:200.0,color:new umi.Color.argb(0xaa, 0xaa, 0xaa, 0xff));
      buttonR = new umi.Sprite.empty(w:200.0,h:200.0,color:new umi.Color.argb(0xaa, 0xaa, 0xff, 0xaa));

      buttonL.addExtension(buttonLEx= new umi.ExButton(buttonL, "l", (String l){}));
      buttonR.addExtension(buttonREx= new umi.ExButton(buttonL, "r", (String l){}));

      addChild(buttonL);
      addChild(buttonR);

    });

    //
    joystick = new umi.Joystick();
    addChild(joystick);
  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    if(joystick != null) {
      joystick.x = 100.0;
      joystick.y = stage.h-100.0;
      joystick.scaleX = 2.2;
      joystick.scaleY = 2.2;
    }
    if(buttonL != null) {
      buttonL.x = stage.w-130.0;
      buttonL.y = stage.h-70.0;
      buttonL.scaleX = 0.2;
      buttonL.scaleY = 0.2;
    }
    if(buttonR != null) {
      buttonR.x = stage.w-60.0;
      buttonR.y = stage.h-100.0;
      buttonR.scaleX = 0.2;
      buttonR.scaleY = 0.2;
    }
  }
}
