import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class GlassNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final VoidCallback onConsoleToggle;
  final bool isConsoleOpen;

  const GlassNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onConsoleToggle,
    required this.isConsoleOpen,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // Responsive design
        if (screenWidth < 768) {
          return _buildMobileNavBar(context);
        } else if (screenWidth < 1200) {
          return _buildTabletNavBar(context);
        } else {
          return _buildDesktopNavBar(context);
        }
      },
    );
  }

  Widget _buildMobileNavBar(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Navigation items (scrollable)
                Expanded(child: _buildMobileNavItems(context)),
                // Console toggle
                _buildConsoleButton(context, isCompact: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletNavBar(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.25),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Navigation items
                Expanded(child: _buildTabletNavItems(context)),
                const VerticalDivider(
                  color: Colors.white24,
                  width: 1,
                  thickness: 1,
                ),
                // Console toggle
                _buildConsoleButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNavBar(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Navigation items
                Expanded(child: _buildDesktopNavItems(context)),
                const VerticalDivider(
                  color: Colors.white30,
                  width: 1,
                  thickness: 1,
                ),
                // Console toggle
                _buildConsoleButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConsoleButton(BuildContext context, {bool isCompact = false}) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onConsoleToggle,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 6 : 8,
              vertical: isCompact ? 4 : 6,
            ),
            decoration: BoxDecoration(
              color:
                  isConsoleOpen
                      ? macAppStoreBlue.withOpacity(0.4)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              isConsoleOpen ? Icons.terminal : Icons.terminal_outlined,
              color:
                  isConsoleOpen ? Colors.white : Colors.white.withOpacity(0.8),
              size: isCompact ? 14 : 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavItems(BuildContext context) {
    final navItems = _getNavigationItems();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children:
            navItems.map((item) => _buildMobileNavItem(context, item)).toList(),
      ),
    );
  }

  Widget _buildTabletNavItems(BuildContext context) {
    final navItems = _getNavigationItems();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children:
            navItems.map((item) => _buildTabletNavItem(context, item)).toList(),
      ),
    );
  }

  Widget _buildDesktopNavItems(BuildContext context) {
    final navItems = _getNavigationItems();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children:
            navItems
                .map((item) => _buildDesktopNavItem(context, item))
                .toList(),
      ),
    );
  }

  Widget _buildMobileNavItem(BuildContext context, NavItem item) {
    final isSelected = selectedIndex == item.index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onItemSelected(item.index),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? macAppStoreBlue.withOpacity(0.4)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  color:
                      isSelected ? Colors.white : Colors.white.withOpacity(0.8),
                  size: 12,
                ),
                const SizedBox(width: 3),
                Text(
                  item.title,
                  style: TextStyle(
                    color:
                        isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.8),
                    fontSize: 9,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletNavItem(BuildContext context, NavItem item) {
    final isSelected = selectedIndex == item.index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onItemSelected(item.index),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? macAppStoreBlue.withOpacity(0.4)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  color:
                      isSelected ? Colors.white : Colors.white.withOpacity(0.8),
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  item.title,
                  style: TextStyle(
                    color:
                        isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.8),
                    fontSize: 10,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNavItem(BuildContext context, NavItem item) {
    final isSelected = selectedIndex == item.index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onItemSelected(item.index),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? macAppStoreBlue.withOpacity(0.4)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  color:
                      isSelected ? Colors.white : Colors.white.withOpacity(0.8),
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  item.title,
                  style: TextStyle(
                    color:
                        isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.8),
                    fontSize: 11,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<NavItem> _getNavigationItems() {
    return [
      NavItem(Icons.computer, 'My System', 0),
      NavItem(Icons.language, 'Browsers', 1),
      NavItem(Icons.build, 'Tools', 2),
      NavItem(Icons.security, 'Cybersecurity', 3),
      NavItem(Icons.code, 'Developer Tools', 4),
      NavItem(Icons.integration_instructions, 'IDES', 5),
      NavItem(Icons.brush, 'Content Creation', 6),
      NavItem(Icons.info_outline, 'System Info', 7),
      NavItem(Icons.videogame_asset, 'Gaming & Utilities', 8),
      NavItem(Icons.desktop_windows, 'Desktop Environment', 9),
      NavItem(Icons.build_circle, 'Advanced Debugging', 10),
      NavItem(Icons.conveyor_belt, 'Vaxp-deb', 11),
      NavItem(Icons.settings, 'Settings', 12),
    ];
  }
}

class NavItem {
  final IconData icon;
  final String title;
  final int index;

  NavItem(this.icon, this.title, this.index);
}
