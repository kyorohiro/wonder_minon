part of wonder_minon;

class RoomScene extends umi.Scene {
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.BitmapTextSprite titleObj;
  umi.BitmapTextSprite playObj;

  RoomScene():super(
      begineColor:new umi.Color(0x00ffffff),
      endColor:new umi.Color(0xffffffff),
      duration:1000);

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene");
    this.builder = stage.context;

    Future.wait([builder.loadImage("assets/font_a.png"),builder.loadString("assets/font_a.json")])
        .then((List<Object> v){
      umi.Image fontImage = v[0];
      String fontJsonSrc = v[1];
      titleObj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "Level\r\n 1, 2, 3, 4, 5");
      titleObj.x = 10.0;
      titleObj.y = 50.0;
      titleObj.size = 32.0;

      playObj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "PLAY");//, rect:new umi.Rect(0.0,0.0,100.0,20.0));
      playObj.color = new umi.Color(0xffffffff);//new umi.Color(0x11111111);
      playObj.x = 170.0;
      playObj.y = 200.0;
      playObj.size = 20.0;
      playObj.addExtension(new umi.ExButton(playObj, "test", (String id){
        print("id");
        request(stage.context, "play");
      }));
      addChild(titleObj);
      addChild(playObj);

    });
  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
  }
}
