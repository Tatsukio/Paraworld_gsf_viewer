import 'package:flutter/material.dart';
import 'package:paraworld_gsf_viewer/classes/gsf/header2/chunks/link.dart';
import 'package:paraworld_gsf_viewer/widgets/header2/widgets/chunks/attributes/chunk_attributes.dart';
import 'package:paraworld_gsf_viewer/widgets/utils/data_display.dart';

class LinkDisplay extends StatelessWidget {
  const LinkDisplay({super.key, required this.link});

  final LinkChunk link;

  @override
  Widget build(BuildContext context) {
    return DataDecorator(children: [
      GsfDataTile(label: "Attributes", data: link.attributes),
      ChunkAttributesFromHeader2WrapperDisplay(
          attributesValue: link.attributes.value),
      GsfDataTile(label: "Guid", data: link.guid),
      GsfDataTile(label: "Pos X", data: link.positionX),
      GsfDataTile(label: "Pos Y", data: link.positionY),
      GsfDataTile(label: "Pos Z", data: link.positionZ),
      GsfDataTile(label: "Quat X", data: link.quaternionX),
      GsfDataTile(label: "Quat Y", data: link.quaternionY),
      GsfDataTile(label: "Quat Z", data: link.quaternionZ),
      GsfDataTile(label: "Quat W", data: link.quaternionW),
      GsfDataTile(label: "FourCC", data: link.fourccLink),
      if (link.skeletonIndex != null)
        GsfDataTile(label: "Skeleton index", data: link.skeletonIndex!),
      if (link.boneIds != null)
        GsfDataTile(label: "Bone ids", data: link.boneIds!),
      if (link.boneWeights != null)
        GsfDataTile(label: "Bone weights", data: link.boneWeights!),
    ]);
  }
}
