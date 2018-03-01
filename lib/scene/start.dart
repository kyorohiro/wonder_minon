part of wonder_minon;

class StartScene extends umi.DisplayObject {
  umi.Image bgimg;
  umi.SpriteSheetInfo info;
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  StartScene();

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene");
    this.builder = stage.builder;
    builder.loadImage("assets/se_start.png").then((v) {
      bgimg = v;
    });
    builder.loadString("assets/se_start.json").then((v) {
      info = new umi.SpriteSheetInfo.fronmJson(v);
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
  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    if (bgimg != null && info != null) {
      canvas.drawImageRect(bgimg, info.frameFromFileName("BG001.png").srcRect, info.frameFromFileName("BG001.png").dstRect);
    }
  }
}
