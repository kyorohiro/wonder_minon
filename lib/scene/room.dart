part of wonder_minon;

class RoomScene extends umi.Scene {
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.BitmapTextSprite _titleObj;
  umi.BitmapTextSprite _playObj;

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
      _titleObj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "Level\r\n 1, 2, 3, 4, 5");
      _titleObj.x = 10.0;
      _titleObj.y = 50.0;
      _titleObj.size = 32.0;

      _playObj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "PLAY");//, rect:new umi.Rect(0.0,0.0,100.0,20.0));
      _playObj.color = new umi.Color(0xffffffff);//new umi.Color(0x11111111);
      _playObj.x = 170.0;
      _playObj.y = 200.0;
      _playObj.size = 20.0;
      _playObj.addExtension(new umi.ExButton(_playObj, "test", (String id){
        print("id");
        request(stage.context, "play");
      }));
      addChild(_titleObj);
      addChild(_playObj);

    });
  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
  }
}
