part of wonder_minon;

class RoomScene extends umi.Scene {
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.BitmapTextSprite _titleObj;
  umi.BitmapTextSprite _playObj;

  umi.BitmapTextSprite _score00Obj;
  umi.BitmapTextSprite _score01Obj;
  umi.BitmapTextSprite _score02Obj;
  umi.BitmapTextSprite _score03Obj;

  MinoGame game;

  RoomScene(this.game):super(
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
      _titleObj.x = 30.0;
      _titleObj.y = 50.0;
      _titleObj.size = 26.0;

      _playObj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "PLAY");//, rect:new umi.Rect(0.0,0.0,100.0,20.0));
      _playObj.color = new umi.Color(0xffffffff);//new umi.Color(0x11111111);
      _playObj.x = 170.0;
      _playObj.y = 200.0;
      _playObj.size = 20.0;
      _playObj.addExtension(new umi.ExButton(_playObj, "test", (String id){
        print("id");
        request(stage.context, "play");
      }));

      _score00Obj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "current: "+game.score.toString());
      _score00Obj.color = new umi.Color(0xffffffff);//new umi.Color(0x11111111);
      _score00Obj.x = 30.0;
      _score00Obj.y = 100.0;
      _score00Obj.size = 15.0;

      _score01Obj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "01: "+(game.ranking.length == 0?"..":"${game.ranking[0]}"));
      _score01Obj.color = new umi.Color(0xffffffff);//new umi.Color(0x11111111);
      _score01Obj.x = 30.0;
      _score01Obj.y = 120.0;
      _score01Obj.size = 15.0;

      _score02Obj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "02: "+(game.ranking.length == 0?"..":"${game.ranking[1]}"));
      _score02Obj.color = new umi.Color(0xffffffff);//new umi.Color(0x11111111);
      _score02Obj.x = 30.0;
      _score02Obj.y = 140.0;
      _score02Obj.size = 15.0;

      _score03Obj = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "03: "+(game.ranking.length == 0?"..":"${game.ranking[2]}"));
      _score03Obj.color = new umi.Color(0xffffffff);//new umi.Color(0x11111111);
      _score03Obj.x = 30.0;
      _score03Obj.y =160.0;
      _score03Obj.size = 15.0;

      addChild(_titleObj);
      addChild(_playObj);
      addChild(_score00Obj);
      addChild(_score01Obj);
      addChild(_score02Obj);
      addChild(_score03Obj);

    });
  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
  }
}
