import 'package:umiuni2d_sprite/umiuni2d_sprite.dart' as umi;
import 'package:umiuni2d_sprite_flutter/umiuni2d_sprite.dart' as uni;
import 'game.dart' as wm;

import 'package:umiuni2d_io_flutter/umiuni2d_io.dart' as uniio;

void main() {
  umi.GameWidget game = new uni.GameWidget(
    root: new umi.GameRoot(400.0, 300.0, backgroundColor: new umi.Color.argb(0x00, 0x00, 0x00, 0x00)),
    background: new umi.Background(backgroundColor: new umi.Color.argb(0xff, 0xff, 0x00, 0x00)),
  );
  game.objects["fs"] = new uniio.FileSystem();
  game.start(onStart:wm.onStart);
}
