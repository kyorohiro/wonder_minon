part of wonder_minon;

class StartScene extends umi.DisplayObject {
  umi.Image bgimg;
  umi.SpriteSheetInfo info;
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.BitmapTextSprite text;
  StartScene();

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene");
    this.builder = stage.builder;
    /*builder.loadImage("assets/se_start.png").then((v) {
      bgimg = v;
    });
    builder.loadString("assets/se_start.json").then((v) {
      info = new umi.SpriteSheetInfo.fronmJson(v);
    });*/

    umi.Image fontImage = null;
    String fontJsonSrc = null;
    builder.loadImage("assets/font_a.png").then((v) {
      fontImage = v;
      if(fontJsonSrc != null) {
        print("${fontJsonSrc}");
        text = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "Wonder Minon");
        text.color = new umi.Color(0xffffffff);//new umi.Color(0x11111111);
        addChild(text);
      }
    });
    builder.loadString("assets/font_a.json").then((v) {
      fontJsonSrc  = v;
      if(fontImage != null) {
        text = new umi.BitmapTextSprite(fontImage, fontJsonSrc,message: "Wonder Minon");
        text.x = 80.0;
        text.y = 100.0;
        text.size = 32.0;
        addChild(text);
      }
    });

  }

  bool isTouch = false;
  bool onTouch(umi.Stage stage, int id, umi.StagePointerType type, double globalX, globalY) {
    if (isTouch == true && type == umi.StagePointerType.UP) {
      isTouch = false;
      //
    } else if (type == umi.StagePointerType.DOWN) {
      isTouch = true;
    }
    return false;
  }
  umi.Rect t = new umi.Rect(0.0, 0.0, 100.0, 100.0);
  int i=0;
  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    if (bgimg != null && info != null) {
      canvas.drawImageRect(bgimg, info.frameFromFileName("BG001.png").srcRect, info.frameFromFileName("BG001.png").dstRect);
    }
    if(text != null) {
      i+=5;
      if(i>0xff) {
        i = 0xff;
      }
      text.color = new umi.Color.argb(i,i,i,i);
    }
  }
}
