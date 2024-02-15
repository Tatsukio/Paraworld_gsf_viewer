import 'dart:typed_data';

import 'package:paraworld_gsf_viewer/classes/gsf/model_anim.dart';
import 'package:paraworld_gsf_viewer/classes/gsf/walk_set_table.dart';
import 'package:paraworld_gsf_viewer/classes/gsf_data.dart';

class ModelInfo extends GsfPart {
  ModelInfo({
    required offset,
    required this.name,
    required this.index,
    required this.animCount,
    required this.modelAnims,
    required this.walkSetTable,
  }) : super(offset: offset);

  late final Standard4BytesData<int> nameLength;
  late final GsfData<String> name;
  late final Standard4BytesData<int> index;
  late final Standard4BytesData<int> animCount;
  late final List<ModelAnim>
      modelAnims; // watch out for 4 zero bytes between each anim
  late final WalkSetTable walkSetTable;

  ModelInfo.fromBytes(Uint8List bytes, int offset) : super(offset: offset) {
    nameLength =
        Standard4BytesData<int>(position: 0, bytes: bytes, offset: offset);

    name = GsfData.fromPosition(
      pos: nameLength.relativeEnd,
      length: nameLength.value,
      bytes: bytes,
      offset: offset,
    );
    print("model info name: $name");

    index = Standard4BytesData(
        position: name.relativeEnd, bytes: bytes, offset: offset);

    animCount = Standard4BytesData(
        position: index.relativeEnd, bytes: bytes, offset: offset);
    print("model info anim count: $animCount");

    modelAnims = [];
    if (animCount.value > 0) {
      for (var i = 0; i < animCount.value; i++) {
        modelAnims.add(ModelAnim.fromBytes(
          bytes,
          modelAnims.isNotEmpty
              ? modelAnims.last.getEndOffset()
              : animCount.offsettedLength(offset),
        ));
      }
    }

    walkSetTable = WalkSetTable.fromBytes(
      bytes,
      modelAnims.isNotEmpty
          ? modelAnims.last.getEndOffset()
          : animCount.offsettedLength(offset),
    );
  }

  @override
  int getEndOffset() {
    return walkSetTable.getEndOffset();
  }

  @override
  String toString() {
    return 'ModelInfo: $name, $index, $animCount, $modelAnims, $walkSetTable';
  }
}
