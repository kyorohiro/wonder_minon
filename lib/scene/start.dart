part of wonder_minon;

class StartScene extends umi.Scene {
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.BitmapTextSprite titleObj;
  umi.BitmapTextSprite startObj;

  umi.Joystick joystick;
  umi.ExButton buttonL;
  umi.ExButton buttonR;
  StartScene(this.joystick, this.buttonL, this.buttonR):super(
      begineColor:new umi.Color(0x00ffffff),
      endColor:new umi.Color(0xffffffff),
      duration:1000);

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene (1)");
    this.builder = stage.context;

    Future.wait([builder.loadImage("assets/font_a.png"),builder.loadString("assets/font_a.json")])
        .then((List<Object> v){
      print("oninit# StartScene (2)");
      umi.Image fontImage = v[0];
      String fontJsonSrc = v[1];

      titleObj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "Wonder Minon");
      titleObj.x = 80.0;
      titleObj.y = 100.0;
      titleObj.size = 32.0;

      startObj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "START");//, rect:new umi.Rect(0.0,0.0,100.0,20.0));
      startObj.color = new umi.Color(0xffffffff);//new umi.Color(0x11111111);
      startObj.x = 170.0;
      startObj.y = 200.0;
      startObj.size = 20.0;
      startObj.addExtension(new umi.ExButton(startObj, "test", (String id){
        clickStart(stage);
      }));
      startObj.addExtension(new umi.ExBlink(startObj));
      addChild(titleObj);
      addChild(startObj);
      print("oninit# StartScene (3)");
    });
  }

  void onTick(umi.Stage stage, int timeStamp) {
    super.onTick(stage, timeStamp);
    if(this.buttonR.isTouch || this.buttonL.isTouch) {
      clickStart(stage);
    }
  }

  void clickStart(umi.Stage stage) {
    request(stage.context, "room");
  }
}
