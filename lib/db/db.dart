part of wonder_minon;

class Database {
  List<int> rank = [0, 0, 0];
  umiio.FileSystem fs;
  Database(this.fs) {}

  Future<List<int>> getRank() async {
    return new List.from(rank);
  }

  Future setRank(List<int> _rank) async {
    this.rank.clear();
    this.rank.addAll(_rank);
  }

  Future<String> createData() async {
    String v = conv.JSON.encode({"v": "1", "rank": rank});
    print("##${v}");
    return v;
  }

  load() async {
    try {
      await fs.checkPermission();
      await fs.cd((await fs.getHomeDirectory()).path);
      umiio.File f = await fs.getEntry("database.dat");
      List<int> t = await f.readAsBytes(0, await f.getLength());
      String v = conv.utf8.decode(t);
      print("##### load database.dat ${v}");
      Map d = conv.json.decode(v);
      rank.clear();
      for (int v in d["rank"]) {
        print("## ${v}");
        rank.add(v);
      }
    } catch (e) {
      ;
    }
  }

  save() async {
    await fs.checkPermission();
    await fs.cd((await fs.getHomeDirectory()).path);
    umiio.File f = await fs.getEntry("database.dat");
    try {
      await f.truncate(0);
    } catch (e) {
      print("e: truncate ${e}");
    }
    await f.writeAsBytes(conv.UTF8.encode(await createData()), 0);
  }
}
