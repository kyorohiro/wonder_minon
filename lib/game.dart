library wonder_minon;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart' as umi;
import 'package:umiuni2d_sprite/umiuni2d_sprite_utils.dart' as umi;
import 'dart:async';
import 'logic/minon.dart'; // monon logic
import 'dart:math' as math;

part 'scene/loading.dart';
part 'scene/start.dart';
part 'scene/room.dart';
part 'scene/play.dart';
part 'layer/front.dart';



void request(umi.GameWidget widget, String requst) {
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
    widget.stage.root.addChild(new PlayScene(widget, new MinoGame(), (widget.stage.front as Front).joystick));
    // this.builder, this.game, this.joystick,
  }
}


Future onStart(umi.GameWidget widget) async {
//  widget.stage.background.
  request(widget, "loading");

  int startTime = new DateTime.now().millisecondsSinceEpoch;
  widget.stage.front = new Front();
  do {

    if(!widget.stage.startable) {
      //
      // in preparation
      //
      await new Future.delayed(new Duration(milliseconds: 20));
      continue;
    }


    widget.stage.kick(new DateTime.now().millisecondsSinceEpoch);
    widget.stage.markPaintshot();
    await new Future.delayed(new Duration(milliseconds: 20));
  } while(true);
}

class Front extends umi.Scene {
  umi.GameWidget builder;
  umi.Paint p = new umi.Paint();

  umi.Joystick joystick;

  Front():super(
      begineColor:new umi.Color(0x00ffffff),
      endColor:new umi.Color(0xffffffff),
      duration:1000);

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    print("oninit# StartScene");
    this.builder = stage.context;

    joystick = new umi.Joystick();
    joystick.x = 100.0;
    joystick.y = 200.0;
    joystick.scaleX = 1.5;
    joystick.scaleY = 1.5;
    addChild(joystick);
  }

  void onPaint(umi.Stage stage, umi.Canvas canvas) {
  }
}

