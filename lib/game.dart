library wonder_minon;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart' as umi;
import 'package:umiuni2d_sprite/umiuni2d_sprite_utils.dart' as umi;
import 'dart:async';

part 'scene/loading.dart';
part 'scene/start.dart';
part 'scene/room.dart';
part 'scene/play.dart';


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
    widget.stage.root.addChild(new PlayScene());
  }
}


Future onStart(umi.GameWidget widget) async {
//  widget.stage.background.
  request(widget, "loading");

  int startTime = new DateTime.now().millisecondsSinceEpoch;
  do {

    if(!widget.stage.startable) {
      //
      // in preparation
      //
      await new Future.delayed(new Duration(milliseconds: 20));
      continue;
    }


    widget.stage.kick( new DateTime.now().millisecondsSinceEpoch);
    widget.stage.markPaintshot();
    await new Future.delayed(new Duration(milliseconds: 20));
  } while(true);
}


