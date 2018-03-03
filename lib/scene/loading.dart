part of wonder_minon;

class LoadingScene extends umi.DisplayObject {

  @override
  void onInit(umi.Stage stage) {
    super.onInit(stage);
    load(stage.context);
  }

  int count = 0;
  @override
  void onPaint(umi.Stage stage, umi.Canvas canvas) {
    count++;
    double size = 100.0 + ((count / 2) % 10) * 5;
    canvas.drawRect(
        new umi.Rect(-size / 2 + 200, -size / 2 + 150, size, size),
        new umi.Paint(color: new umi.Color.argb(0xaa, 0xff, 0xaa, 0xaa)));
  }

  load(umi.GameWidget context) async {
    try {
      await Future.wait([
        context.loadImage("assets/bg_clear01.png"),
        context.loadImage("assets/bg_clear02.png"),
        context.loadImage("assets/bg_clear03.png"),
        new Future.delayed(new Duration(milliseconds: 800)),
      ]);
    } catch (e) {}

    try {
      await Future.wait([
        context.loadImage("assets/bg_clear04.png"),
        context.loadImage("assets/bg_clear05.png"),
        new Future.delayed(new Duration(milliseconds: 800)),
      ]);
    } catch (e) {}
    try {
      await Future.wait([
        context.loadImage("assets/se_start.png"),
        context.loadString("assets/se_start.json"),
        context.loadString("assets/se_play.json"),
        context.loadImage("assets/se_play.png"),
        new Future.delayed(new Duration(milliseconds: 800)),
      ]);
    } catch (e) {}

    try {
      await Future.wait([
        context.loadImage("assets/se_setting.png"),
        context.loadString("assets/se_setting.json"),
        context.loadImage("assets/font_a.png"),
        context.loadString("assets/font_a.json"),
        new Future.delayed(new Duration(milliseconds: 800)),
      ]);
    } catch (e) {}

    request(context, "start");
  }

}