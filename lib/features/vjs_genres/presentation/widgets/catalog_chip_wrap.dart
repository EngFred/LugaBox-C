import 'package:flutter/material.dart';

import 'catalog_chip.dart';

class CatalogChipWrap<T> extends StatelessWidget {
  const CatalogChipWrap({
    super.key,
    required this.items,
    required this.labelFor,
    required this.onSelected,
  });

  final List<T> items;
  final String Function(T item) labelFor;
  final void Function(T item) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 9,
      runSpacing: 10,
      children: [
        for (final item in items)
          CatalogChip(
            label: labelFor(item).toUpperCase(),
            onTap: () => onSelected(item),
          ),
      ],
    );
  }
}
