import 'package:flutter/material.dart';
import '../../../core/theme/codevanta_colors.dart';

class NavigationDestinationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const NavigationDestinationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

class ResponsiveNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestinationItem> destinations;
  final Widget body;

  const ResponsiveNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrDesktop = screenWidth >= 640;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isTabletOrDesktop) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              backgroundColor: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
              indicatorColor: CodeVantaColors.electricViolet.withValues(alpha: 0.2),
              selectedIconTheme: const IconThemeData(color: CodeVantaColors.electricViolet),
              unselectedIconTheme: IconThemeData(
                color: isDark ? CodeVantaColors.textDarkSecondary : CodeVantaColors.textLightSecondary,
              ),
              labelType: NavigationRailLabelType.selected,
              destinations: destinations
                  .map(
                    (item) => NavigationRailDestination(
                      icon: Icon(item.icon),
                      selectedIcon: Icon(item.selectedIcon),
                      label: Text(item.label),
                    ),
                  )
                  .toList(),
            ),
            VerticalDivider(
              thickness: 1,
              width: 1,
              color: isDark ? CodeVantaColors.darkSurfaceBorder : CodeVantaColors.lightSurfaceBorder,
            ),
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark ? CodeVantaColors.darkSurfaceBorder : CodeVantaColors.lightSurfaceBorder,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          backgroundColor: isDark ? CodeVantaColors.darkSurfaceCard : CodeVantaColors.lightSurfaceCard,
          indicatorColor: CodeVantaColors.electricViolet.withValues(alpha: 0.2),
          destinations: destinations
              .map(
                (item) => NavigationDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon, color: CodeVantaColors.electricViolet),
                  label: item.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
