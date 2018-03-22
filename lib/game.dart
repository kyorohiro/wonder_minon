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
part 'scene/clear.dart';
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
    widget.stage.root.addChild(new RoomScene(game));
  }
  else if(requst == "play") {
    widget.stage.root.clearChild();
    widget.stage.root.addChild(new PlayScene(widget, game,
        (widget.stage.front as Front).joystick,
        (widget.stage.front as Front).buttonLEx,
        (widget.stage.front as Front).buttonREx));
  }
  else if(requst == "clear") {
    widget.stage.root.clearChild();
    widget.stage.root.addChild(new ClearScene(game.score));
  }
  else if(requst == "save") {
    await db.setRank(game.ranking);
    await db.save();
    print("${game.ranking}");
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

