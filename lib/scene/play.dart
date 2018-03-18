part of wonder_minon;


class PlayScene extends umi.DisplayObject {
  static final umi.Color bgColor = new umi.Color.argb(0xff, 0xee, 0xee, 0xff);
  static final umi.Color colorEmpty = new umi.Color.argb(0xaa, 0x88, 0x88, 0x88);
  static final umi.Color colorFrame = new umi.Color.argb(0xaa, 0x55, 0x33, 0x33);
  static final umi.Color colorMinon = new umi.Color.argb(0xaa, 0xff, 0xff, 0xff);

  static final umi.Color colorO = new umi.Color.argb(0xaa, 0x00, 0x00, 0x00);
  static final umi.Color colorS = new umi.Color.argb(0xaa, 0xff, 0xaa, 0xaa);
  static final umi.Color colorZ = new umi.Color.argb(0xaa, 0xaa, 0xff, 0xaa);
  static final umi.Color colorJ = new umi.Color.argb(0xaa, 0xaa, 0xaa, 0xff);
  static final umi.Color colorL = new umi.Color.argb(0xaa, 0xff, 0xff, 0xaa);
  static final umi.Color colorT = new umi.Color.argb(0xaa, 0xaa, 0xff, 0xff);

  umi.GameWidget builder;
  MinoGame game;
  bool isStart = true;

  MinoTableUI playboard;
  MinoNextUI nextUI;
  ScoreUI scoreUI;
  ScoreUI levelUI;
  umi.SpriteSheetInfo spriteInfo;
  umi.Image image;
  umi.Joystick joystick;
  umi.ExButton rotateL;
  umi.ExButton rotateR;

  PlayScene(this.builder, this.game, this.joystick,  this.rotateL,this.rotateR,{int level: 1}) {
    playboard = new MinoTableUI(builder, game.table);
    nextUI = new MinoNextUI(builder);
    scoreUI = new ScoreUI(this.spriteInfo, this.image);
    levelUI = new ScoreUI(this.spriteInfo, this.image);
    levelUI.size = 3;

    addChild(playboard);
    addChild(nextUI);
    addChild(scoreUI);
    addChild(levelUI);

    playboard.mat.scale(1.25, 1.25, 0.0);
    playboard.mat.translate(80.0, 25.0, 0.0);
    nextUI.mat.translate(250.0, 153.0, 0.0);
    scoreUI.mat.translate(250.0, 50.0, 0.0);
    levelUI.mat.translate(250.0, 85.0, 0.0);
    //
    //
    builder.loadImage("assets/se_play.png").then((umi.Image i) {
      image = i;
      scoreUI.image = i;
      levelUI.image = i;
    });
    builder.loadString("assets/se_play.json").then((String x) {
      spriteInfo = new umi.SpriteSheetInfo.fronmJson(x);
      scoreUI.spriteInfo = spriteInfo;
      levelUI.spriteInfo = spriteInfo;
    });
    game.baseLevel = level;
    game.level = level;
    game.clear();
    print("### game =  ${game.baseLevel}");
  }
  PlayScene initFromLevel(int level) {
    game.baseLevel = level;
    game.level = level;
    joystick.clearStatus();
    return this;
  }

  umi.Paint p = new umi.Paint();
  umi.Rect d1 = new umi.Rect(0.0, 0.0, 50.0, 50.0);
  umi.Rect d2 = new umi.Rect(0.0, 0.0, 50.0, 50.0);


  void onTick(umi.Stage stage, int timeStamp) {
    scoreUI.score = game.score;
    levelUI.score = game.level + 1;
    if (game.nexts.length > 1 && game.nexts[1] != null) {
      nextUI.setMinon(game.nexts[1]);
    }
    if (isStart == false) {
      onTickStop(stage, timeStamp);
    } else {
      onTickGame(stage, timeStamp);
    }
  }

  void onTickGame(umi.Stage stage, int timeStamp) {
    game.onTouchStart(timeStamp);
    bool isMoved = false;
    double mbase = 0.55;
    if (joystick.directionY > 0.80) {
      mbase = 0.68;
    }
    if (joystick.directionX > mbase || (joystick.registerDown == true && joystick.registerUp == true && joystick.directionX_released > mbase)) {
      joystick.registerDown = false;
      game.rightWithLevel(timeStamp, force: joystick.registerUp);
      isMoved = true;
    } else if (joystick.directionX < -1 * mbase || (joystick.registerDown == true && joystick.registerUp == true && joystick.directionX_released < -1 * mbase)) {
      joystick.registerDown = false;
      game.leftWithLevel(timeStamp, force: joystick.registerUp);
      isMoved = true;
    }
    if (joystick.directionY < -0.6) {
      game.downWithLevel(timeStamp, force: joystick.registerUp);
    } else if (joystick.directionY > 0.83 && isMoved == false) {
      game.downPlusWithLevel(timeStamp, force: joystick.registerUp);
    }

    if (rotateR.isTouch || (rotateR.registerDown == true && rotateR.registerUp == true)) {
      rotateR.registerDown = false;
      if(game.rotateRWithLevel(timeStamp, force: rotateR.registerUp)) {
//        this.root.startB();
      }
    }
    if (rotateL.isTouch || (rotateL.registerDown == true && rotateL.registerUp == true)) {
      rotateL.registerDown = false;
      //rotateL.registerUp = false;
      if(game.rotateLWithLevel(timeStamp, force: rotateL.registerUp)) {
     //   this.root.startB();
      }
    }

    if (game.isGameOver) {
      request(stage.context, "room");
      request(stage.context, "save");
    }
    game.onTouchEnd(timeStamp);
    if(game.registerNext == true) {
//      this.root.startA();
    }
    if(game.registerClear == true) {
//      this.root.startC();
    }
    joystick.registerUp = false;
    rotateL.registerUp = false;
    rotateR.registerUp = false;
    game.registerNext = false;
    game.registerClear = false;
  }

  bool onTouch(umi.Stage stage, int id, umi.StagePointerType type, double globalX, globalY) {
    return false;
  }

  void onTickStop(umi.Stage stage, int timeStamp) {}
  onTouchCallback(String id) {
    if (id == "s") {
      isStart = (!isStart);
    }
  }
}



class MinoTableUI extends umi.DisplayObject {
  umi.GameWidget builder;
  MinoTable table;
  MinoTableUI(this.builder, this.table) {
    ;
  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    umi.Rect rect = new umi.Rect(0.0, 0.0, 7.0, 7.0);
    umi.Paint p = new umi.Paint();
    p.style = umi.PaintStyle.fill;
    p.strokeWidth = 1.0;

    {
      p.color = PlayScene.bgColor;
      umi.Rect rect = new umi.Rect(0.0, 0.0, 8.0*table.fieldWWithFrame, 8.0*table.fieldHWithFrame);
      canvas.drawRect(rect, p);
    }
    for (int y = 0; y < table.fieldHWithFrame; y++) {
      for (int x = 0; x < table.fieldWWithFrame; x++) {
        rect.x = x * 8.0;
        rect.y = y * 8.0;
        Mino m = table.getMino(x, y);
        if (m.type == MinoTyoe.frame) {
          p.color = PlayScene.colorFrame;
        } else if (m.type == MinoTyoe.empty) {
          p.color = PlayScene.colorEmpty;
        } else if (m.type == MinoTyoe.l) {
          p.color = PlayScene.colorMinon;
        } else if (m.type == MinoTyoe.o) {
          p.color = PlayScene.colorO;
        } else if (m.type == MinoTyoe.t) {
          p.color = PlayScene.colorT;
        } else if (m.type == MinoTyoe.s) {
          p.color = PlayScene.colorS;
        } else if (m.type == MinoTyoe.z) {
          p.color = PlayScene.colorZ;
        } else if (m.type == MinoTyoe.j) {
          p.color = PlayScene.colorJ;
        } else if (m.type == MinoTyoe.L) {
          p.color = PlayScene.colorL;
        } else {
          p.color = PlayScene.colorL;
        }
        canvas.drawRect(rect, p);
      }
    }
  }
}


class MinoNextUI extends umi.DisplayObject {
  umi.GameWidget builder;
  MinoTable table;

  MinoNextUI(this.builder) {
    table = new MinoTable(fieldW:5,fieldH:5);
  }

  setMinon(Minon minon) {
    table.clear();
    for (MinonElm e in minon.minos) {
      Mino m = table.getMino(3 + e.x, 3 + e.y);
      if (m.type != MinoTyoe.out) {
        m.type = e.type;
      }
    }
  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    umi.Rect rect = new umi.Rect(0.0, 0.0, 7.0, 7.0);
    umi.Paint p = new umi.Paint();
    p.style = umi.PaintStyle.fill;
    p.strokeWidth = 1.0;

    for (int y = 0; y < table.fieldHWithFrame; y++) {
      for (int x = 0; x < table.fieldWWithFrame; x++) {
        rect.x = x * 8.0;
        rect.y = y * 8.0;
        Mino m = table.getMino(x, y);
        if (m.type == MinoTyoe.frame) {
          p.color = PlayScene.colorFrame;
        } else if (m.type == MinoTyoe.empty) {
          p.color = PlayScene.colorEmpty;
        } else if (m.type == MinoTyoe.l) {
          p.color = PlayScene.colorMinon;
        } else if (m.type == MinoTyoe.o) {
          p.color = PlayScene.colorO;
        } else if (m.type == MinoTyoe.t) {
          p.color = PlayScene.colorT;
        } else if (m.type == MinoTyoe.s) {
          p.color = PlayScene.colorS;
        } else if (m.type == MinoTyoe.z) {
          p.color = PlayScene.colorZ;
        } else if (m.type == MinoTyoe.j) {
          p.color = PlayScene.colorJ;
        } else if (m.type == MinoTyoe.L) {
          p.color = PlayScene.colorL;
        } else {
          p.color = PlayScene.colorO;
        }
        canvas.drawRect(rect, p);
      }
    }
  }
}



class ScoreUI extends umi.DisplayObject {

  umi.SpriteSheetInfo spriteInfo;
  umi.Image image;
  int score = 0;
  int size = 7;
  ScoreUI(this.spriteInfo, this.image) {

  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    if(spriteInfo == null || image == null) {
      return;
    }

    for(int i=0;i<size;i++) {
      int v = (size-1-i);
      v =(v==0?1:math.pow(10,v));
      v = score~/v;
      v = v % 10;
      drawScore(stage, canvas, v, i*12);
    }
  }

  void drawScore(umi.Stage stage, umi.Canvas canvas, int v, int x) {
    umi.Paint p = new umi.Paint();
    umi.Rect dst = new umi.Rect(0.0+x, 0.0, 15.0, 15.0);
    canvas.drawImageRect(image,
        spriteInfo.frameFromFileName("NUM00${v}.png").srcRect,
        dst,
        paint: p);
  }
}