import 'package:umiuni2d_sprite/umiuni2d_sprite.dart' as umi;
import 'package:umiuni2d_sprite_html5/umiuni2d_sprite.dart' as uni;
import 'package:wonder_minon/game.dart' as wm;

void main() {
  umi.GameWidget game = new uni.GameWidget(
    root: new umi.GameRoot(400.0, 300.0, backgroundColor: new umi.Color.argb(0xff, 0xff, 0x00, 0x00)),
    background: new umi.GameBackground(backgroundColor: new umi.Color.argb(0xff, 0xff, 0xff, 0xff)),
  );
  game.start(onStart:wm.onStart);
}