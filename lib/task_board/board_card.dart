import 'package:flutter/material.dart';

import 'board_item_model.dart';

class BoardCard extends StatelessWidget {
  final BoardItemModel item;
  final Function(BoardItemModel) onTap;

  const BoardCard({Key? key, required this.item, required this.onTap})
      : super(key: key);

  void _handleItemTap() => onTap(item);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleItemTap,
      child: Card(
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    item.subtitle,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.supervised_user_circle_outlined),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
