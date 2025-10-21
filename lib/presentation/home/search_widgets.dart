import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'search_service.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<SearchResult> results;
  final String query;
  final Function(SearchableItem) onItemTap;
  final VoidCallback onClose;

  const SearchResultsWidget({
    super.key,
    required this.results,
    required this.query,
    required this.onItemTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return _buildEmptyState(context);
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(113, 0, 0, 0),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const Divider(color: Color.fromARGB(255, 121, 120, 120), height: 1),
          _buildResultsList(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.search, color: macAppStoreBlue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search Results for "$query"',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            '${results.length} result${results.length == 1 ? '' : 's'}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.close, color: macAppStoreGray),
            onPressed: onClose,
            iconSize: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color.fromARGB(122, 26, 26, 26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 48,
            color: const Color.fromARGB(255, 71, 71, 71),
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching for applications, tools, or categories',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: macAppStoreGray),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 16),
            label: const Text('Close'),
            style: ElevatedButton.styleFrom(
              backgroundColor: macAppStoreBlue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(BuildContext context) {
    // Group results by category
    final groupedResults = <String, List<SearchResult>>{};
    for (final result in results) {
      final category = result.item.category;
      groupedResults.putIfAbsent(category, () => []).add(result);
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 400),
      child: SingleChildScrollView(
        child: Column(
          children:
              groupedResults.entries.map((entry) {
                return _buildCategorySection(context, entry.key, entry.value);
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String category,
    List<SearchResult> categoryResults,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: macAppStoreBlue.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(color: macAppStoreLightGray.withOpacity(0.2)),
            ),
          ),
          child: Text(
            category,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: macAppStoreBlue,
            ),
          ),
        ),
        ...categoryResults.map((result) => _buildResultItem(context, result)),
      ],
    );
  }

  Widget _buildResultItem(BuildContext context, SearchResult result) {
    final item = result.item;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onItemTap(item),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(item.icon, color: item.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: macAppStoreGray),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.packageName.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Package: ${item.packageName}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: macAppStoreBlue,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: macAppStoreBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getSectionName(item.sectionId),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: macAppStoreBlue,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(Icons.chevron_right, color: macAppStoreGray, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSectionName(String sectionId) {
    switch (sectionId) {
      case 'my_system':
        return 'System';
      case 'browsers':
        return 'Browsers';
      case 'tools':
        return 'Tools';
      case 'cybersecurity':
        return 'Security';
      case 'developer_tools':
        return 'Dev Tools';
      case 'ides':
        return 'IDEs';
      case 'content_creation':
        return 'Content';
      case 'system_info':
        return 'System Info';
      case 'gaming_utilities':
        return 'Gaming';
      case 'desktop_environment':
        return 'Desktop';
      case 'advanced_debugging':
        return 'Debugging';
      case 'vaxp_deb':
        return 'Vaxp-deb';
      case 'settings':
        return 'Settings';
      default:
        return 'Unknown';
    }
  }
}

class SearchOverlay extends StatefulWidget {
  final Function(SearchableItem) onItemTap;
  final VoidCallback onClose;

  const SearchOverlay({
    super.key,
    required this.onItemTap,
    required this.onClose,
  });

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // Simulate search delay for better UX
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        final results = SearchService.search(query);
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Column(
        children: [
          // Search input
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(113, 27, 27, 27),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search applications, tools, and categories...',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                prefixIcon: const Icon(Icons.search, color: macAppStoreBlue),
                suffixIcon:
                    _isSearching
                        ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                macAppStoreBlue,
                              ),
                            ),
                          ),
                        )
                        : IconButton(
                          icon: const Icon(Icons.close, color: macAppStoreGray),
                          onPressed: widget.onClose,
                        ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Search results
          Expanded(
            child:
                _searchController.text.trim().isEmpty
                    ? _buildSearchSuggestions(context)
                    : SearchResultsWidget(
                      results: _searchResults,
                      query: _searchController.text.trim(),
                      onItemTap: widget.onItemTap,
                      onClose: widget.onClose,
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSuggestions(BuildContext context) {
    final suggestions = [
      'Firefox',
      'Steam',
      'GIMP',
      'VS Code',
      'Git',
      'Docker',
      'KDE Plasma',
      'Xfce',
      'Wine',
      'OBS Studio',
      'Blender',
      'Python',
      'Node.js',
      'Wireshark',
      'htop',
      'GParted',
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: macAppStoreCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: macAppStoreBlue, size: 20),
                const SizedBox(width: 12),
                Text(
                  'Popular Searches',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: macAppStoreGray),
                  onPressed: widget.onClose,
                  iconSize: 20,
                ),
              ],
            ),
          ),
          const Divider(color: macAppStoreLightGray, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      suggestions.map((suggestion) {
                        return InkWell(
                          onTap: () {
                            _searchController.text = suggestion;
                            _onSearchChanged();
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: macAppStoreBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: macAppStoreBlue.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              suggestion,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: macAppStoreBlue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 24),
                Text(
                  'Search Tips',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '• Search by application name (e.g., "Firefox")\n'
                  '• Search by category (e.g., "Browsers", "Gaming")\n'
                  '• Search by package name (e.g., "firefox")\n'
                  '• Search by tags (e.g., "video editor", "IDE")',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: macAppStoreGray,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
