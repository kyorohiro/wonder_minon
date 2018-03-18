part of wonder_minon;

class StartScene extends umi.Scene {
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.BitmapTextSprite titleObj;
  umi.BitmapTextSprite startObj;

  StartScene():super(
      begineColor:new umi.Color(0x00ffffff),
      endColor:new umi.Color(0xffffffff),
      duration:3000);

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene");
    this.builder = stage.context;

    Future.wait([builder.loadImage("assets/font_a.png"),builder.loadString("assets/font_a.json")])
        .then((List<Object> v){
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
        print("id");
        request(stage.context, "room");
      }));
      startObj.addExtension(new umi.ExBlink(startObj));
      addChild(titleObj);
      addChild(startObj);

    });

  }
/*
  umi.Rect t = new umi.Rect(0.0, 0.0, 100.0, 100.0);
  double j=0.0;
  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    if(titleObj != null) {
      j+=0.02;
      if(j>=1.0) {
        j=0.5;
      }
      titleObj.color = new umi.Color.argb(0xff,0xff,0xff,0x00);
      startObj.color = new umi.Color.argb((0xff*j).toInt(),0xff,0xff,0x00);
    }
  }*/
}
