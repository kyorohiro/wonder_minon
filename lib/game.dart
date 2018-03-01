library wonder_minon;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart' as umi;
import 'dart:async';

part 'scene/loading.dart';

void request(umi.GameWidget widget, String requst) {
  if(requst == "loading") {
    widget.stage.root.clearChild();
    widget.stage.root.addChild(new LoadingScene());
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


