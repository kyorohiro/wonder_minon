part of wonder_minon;

class ClearScene extends umi.Scene {
//  MinoRoot root;
  umi.GameWidget builder;
  //
  umi.Image bgimg;
  umi.Rect srcRect;
  umi.Rect dstRect;
  //
  umi.Image fontimg;
  umi.Rect fontSrcRect;
  umi.Rect fontDstRect;
  String jsonText;
  umi.SpriteSheet fontInfo;
  umi.Paint p = new umi.Paint();
  int type = 0;
  String locale = "ja";

  String get currentMessage {
    if (locale.contains("ja")) {
      return message_ja[type];
    } else {
      return message_en[type];
    }
  }

  List<int> event = [
//    10,20,30,40
    0, 5000, 16000, 32000, 50000, 100000
  ];
  List<String> path = ["assets/bg_clear01.png", "assets/bg_clear02.png", "assets/bg_clear05.png", "assets/bg_clear06.png", "assets/bg_clear03.png", "assets/bg_clear04.png"];
  List<String> message_ja = ["そして、ミノーンの雪が降った。", "ミノーンが仲間になった。", "炎の妖精がこちらを見ている。", "魔法少女とお友達になった。", "闇が辺りを照らした。", "ミーティアを詠唱した。"];
  List<String> message_en = ["then, Minon snowflake fell", "Minon has become a friend", "Fairy of flame have seen here .", "Magical Girl and I became friends .", "Darkness shone around .", "Chanting the Meteor."];
  int typeFromScore(int score) {
    int type = 0;
    for (int i = 0; i < event.length; i++) {
      if (score >= event[i]) {
        type = i;
      }
    }
    return type;
  }

  umi.Joystick joystick;
  umi.ExButton buttonL;
  umi.ExButton buttonR;
  int score;
  ClearScene(this.score,this.joystick, this.buttonL, this.buttonR) {

  }

  void onInit(umi.Stage stage) {
    super.onInit(stage);
    this.builder = stage.context;
    builder.getLocale().then((String v) {
      locale = v;
    });
    initFromScore(score);
  }

  initFromScore(int score) {
    fontimg = null;
    bgimg = null;
    type = typeFromScore(score);

    String imgFileName = path[type];
    builder.loadImage(imgFileName).then((v) {
      bgimg = v;
      srcRect = new umi.Rect(0.0, 0.0, bgimg.w.toDouble(), bgimg.h.toDouble());
      dstRect = new umi.Rect(0.0, 0.0, 400.0, 300.0);
    });
    builder.loadImage("assets/font_a.png").then((v) {
      fontimg = v;
      fontSrcRect = new umi.Rect(0.0, 0.0, 0.0, 0.0);
      fontDstRect = new umi.Rect(0.0, 0.0, 0.0, 0.0);
      update();
    });
    builder.loadString("assets/font_a.json").then((String v) {
      jsonText = v;
      update();
    });
    return this;
  }

  update() {
    if(jsonText != null && fontimg != null) {
      fontInfo = new umi.SpriteSheet.bitmapfont(jsonText, fontimg.w, fontimg.h);
    }
  }
  bool isTouch = false;
  bool onTouch(umi.Stage stage, int id, umi.StagePointerType type, double globalX, globalY) {
    if (isTouch == true && type == umi.StagePointerType.UP) {
      isTouch = false;
      clickEnd(stage);
    } else if (type == umi.StagePointerType.DOWN) {
      isTouch = true;
    }
    return false;
  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    if (bgimg != null) {
      canvas.drawImageRect(bgimg, srcRect, dstRect);
    }
    if (fontimg != null && fontInfo != null) {
      fontInfo.drawText(canvas, fontimg, currentMessage, 20.0, rect: new umi.Rect(40.0, 230.0, 350.0, 200.0));
    }
  }

  void clickEnd(umi.Stage stage) {
    request(stage.context, "room");
  }

  void onTick(umi.Stage stage, int timeStamp) {
    super.onTick(stage, timeStamp);
    if(this.buttonR.isTouch || this.buttonL.isTouch) {
      clickEnd(stage);
    }
  }
}