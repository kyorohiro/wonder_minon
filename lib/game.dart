library wonder_minon;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart' as umi;
import 'package:umiuni2d_sprite/umiuni2d_sprite_utils.dart' as umi;
import 'dart:async';
import 'logic/minon.dart'; // monon logic
import 'dart:math' as math;
import 'dart:convert' as conv;
import 'package:umiuni2d_io/umiuni2d_io.dart' as umiio;

part 'scene/loading.dart';
part 'scene/start.dart';
part 'scene/room.dart';
part 'scene/play.dart';
part 'layer/front.dart';
part 'db/db.dart';


MinoGame game = new MinoGame();
Database db;

request(umi.GameWidget widget, String requst) async {
  if(requst == "loading") {
    widget.stage.root.clearChild();
    widget.stage.root.addChild(new LoadingScene());
  }
  else if(requst == "start") {
    print("start request");
    widget.stage.root.clearChild();
    widget.stage.root.addChild(new StartScene());
  }
  else if(requst == "room") {
    widget.stage.root.clearChild();
    widget.stage.root.addChild(new RoomScene());
  }
  else if(requst == "play") {
    widget.stage.root.clearChild();
    widget.stage.root.addChild(new PlayScene(widget, new MinoGame(),
        (widget.stage.front as Front).joystick,
        (widget.stage.front as Front).buttonLEx,
        (widget.stage.front as Front).buttonREx));
  }
  else if(requst == "save") {
    await db.setRank(game.ranking);
    await db.save();
  }
}

loadScore() async {
  await db.load();
  List<int> r = await db.getRank();
  for (int i in r) {
    game.updateRanking(currentScore: i);
  }
}

Future onStart(umi.GameWidget widget) async {
//  widget.stage.background.
  request(widget, "loading");

  // init db
  umiio.FileSystem fs = widget.objects["fs"];
  db = new Database(fs);
  loadScore();

  //
  int startTime = new DateTime.now().millisecondsSinceEpoch;
  int curretTime = startTime;
  int prevTime = startTime;
  widget.stage.front = new Front();
  int wait = 15;
  do {
    if(!widget.stage.startable) {
      //
      // in preparation
      await new Future.delayed(new Duration(milliseconds: 20));
      continue;
    }

    curretTime = new DateTime.now().millisecondsSinceEpoch;
    widget.stage.kick(new DateTime.now().millisecondsSinceEpoch);
    prevTime = curretTime;
    widget.stage.markPaintshot();
    await new Future.delayed(
      new Duration(milliseconds: 
            (curretTime-prevTime > wait?1:wait-(curretTime-prevTime))
      ));
  } while(true);
}

class Front extends umi.Scene {
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.Joystick joystick;
  umi.Sprite buttonL;
  umi.ExButton buttonLEx;
  umi.Sprite buttonR;
  umi.ExButton buttonREx;


  Front():super(
      begineColor:new umi.Color(0x00ffffff),
      endColor:new umi.Color(0xffffffff),
      duration:1000);

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene");
    this.builder = stage.context;

    Future.wait([builder.loadImage("assets/se_play.png"), builder.loadString("assets/se_play.json")]).then((List<Object> vs) {
      umi.Image image = vs[0];
      umi.SpriteSheetInfo spriteInfo = new umi.SpriteSheetInfo.fronmJson(vs[1]);

      umi.Rect src2 = spriteInfo.frameFromFileName("BT01.png").srcRect;
      umi.Rect dst2 = spriteInfo.frameFromFileName("BT01.png").dstRect;

      umi.Rect src1 = spriteInfo.frameFromFileName("BT02.png").srcRect;
      umi.Rect dst1 = spriteInfo.frameFromFileName("BT02.png").dstRect;

      //1
      buttonL = new umi.Sprite.simple(image,srcs: [src2], dsts: [dst2]);
      buttonR = new umi.Sprite.simple(image,srcs: [src1], dsts: [dst1]);

      buttonL.addExtension(buttonLEx= new umi.ExButton(buttonL, "l", (String l){}));
      buttonR.addExtension(buttonREx= new umi.ExButton(buttonL, "r", (String l){}));

      addChild(buttonL);
      addChild(buttonR);

    });

    //
    joystick = new umi.Joystick();
    addChild(joystick);
  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    if(joystick != null) {
      joystick.x = 100.0;
      joystick.y = stage.h-100.0;
      joystick.scaleX = 2.2;
      joystick.scaleY = 2.2;
    }
    if(buttonL != null) {
      buttonL.x = stage.w-130.0;
      buttonL.y = stage.h-70.0;
      buttonL.scaleX = 0.2;
      buttonL.scaleY = 0.2;
    }
    if(buttonR != null) {
      buttonR.x = stage.w-60.0;
      buttonR.y = stage.h-100.0;
      buttonR.scaleX = 0.2;
      buttonR.scaleY = 0.2;
    }
  }
}

