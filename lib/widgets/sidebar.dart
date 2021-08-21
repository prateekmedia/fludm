import 'package:flutter/material.dart';
import 'package:fludm/utils/utils.dart';

class Sidebar extends StatelessWidget {
  final Widget? start;
  final Widget? end;

  /// The index of the current selected item from [items]
  final int currentIndex;

  /// Called When one of the [items] is tapped
  final Function(int index) onTap;

  /// The List of all the Sidebar item's
  final List<SidebarItem> items;

  const Sidebar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.start,
    this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: context.isDark ? Colors.grey[900] : Colors.grey[200],
        border: Border(
          right: BorderSide(
            color: (context.isDark ? Colors.grey[800]! : Colors.grey[300]!)
                .withAlpha(60),
          ),
        ),
      ),
      child: Column(
        children: [
          if (start != null) start!,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: items
                  .asMap()
                  .entries
                  .map(
                    (item) => _SidebarItemBuilder(
                      label: item.value.label,
                      icon: item.value.icon,
                      onTap: () => onTap(item.key),
                      isActive: currentIndex == item.key,
                    ),
                  )
                  .toList(),
            ),
          ),
          if (end != null) end!,
        ],
      ),
    );
  }
}

class SidebarItem {
  final Widget? icon;
  final String label;

  SidebarItem({
    required this.label,
    this.icon,
  });
}

class _SidebarItemBuilder extends StatelessWidget {
  final Widget? icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _SidebarItemBuilder({
    Key? key,
    required this.label,
    required this.icon,
    required this.isActive,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: isActive ? context.theme.canvasColor.withAlpha(130) : null,
          border: isActive
              ? Border(
                  left: BorderSide(
                    color: context.primaryColor,
                    width: 3,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            if (!isActive) const SizedBox(width: 3),
            if (icon != null) ...[
              Theme(
                  data: context.theme.copyWith(
                    iconTheme: IconThemeData(
                      size: 23,
                      color: isActive
                          ? context.primaryColor
                          : context.theme.iconTheme.color,
                    ),
                  ),
                  child: icon!),
              const SizedBox(width: 8),
            ],
            Text(label,
                style:
                    TextStyle(color: isActive ? context.primaryColor : null)),
          ],
        ),
      ),
    );
  }
}
