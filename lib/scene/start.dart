part of wonder_minon;

class StartScene extends umi.DisplayObject {
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.BitmapTextSprite titleObj;
  umi.BitmapTextSprite startObj;

  StartScene();

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene");
    this.builder = stage.builder;

    Future.wait([builder.loadImage("assets/font_a.png"),builder.loadString("assets/font_a.json")])
        .then((List<Object> v){
      umi.Image fontImage = v[0];
      String fontJsonSrc = v[1];
      titleObj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "Wonder Minon");
      titleObj.x = 80.0;
      titleObj.y = 100.0;
      titleObj.size = 32.0;

      startObj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "START");
      startObj.color = new umi.Color(0xffffffff);//new umi.Color(0x11111111);
      startObj.x = 170.0;
      startObj.y = 200.0;
      startObj.size = 20.0;
      addChild(titleObj);
      addChild(startObj);

    });

  }

  umi.Rect t = new umi.Rect(0.0, 0.0, 100.0, 100.0);
  int i=0;
  double j=0.0;
  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    if(titleObj != null) {
      i+=5;
      j+=0.02;
      if(i>0xff) {
        i = 0xff;
      }
      if(j>=1.0) {
        j=0.5;
      }
      titleObj.color = new umi.Color.argb(i,i,i,i);
      int v = (i.toDouble()*j).toInt();
      startObj.color = new umi.Color.argb(v,0xff,0xff,0xff);
    }
  }
}
