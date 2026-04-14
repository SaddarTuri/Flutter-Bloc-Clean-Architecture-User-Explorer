import 'package:flutter/material.dart';
import 'package:user_explorer/core/constants/app_strings.dart';
import 'package:user_explorer/presentation/widgets/app_search_field.dart';
import 'package:user_explorer/presentation/widgets/section_container.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key, required this.onBackToExplorer});

  final VoidCallback onBackToExplorer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onBackToExplorer,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(AppStrings.search),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        children: const [
          AppSearchField(hint: AppStrings.searchHintLong),
          SizedBox(height: 18),
          _SearchCategorySection(),
          SizedBox(height: 12),
          _RecentSearchesSection(),
          SizedBox(height: 12),
          _TrendingSection(),
        ],
      ),
    );
  }
}

class _SearchCategorySection extends StatelessWidget {
  const _SearchCategorySection();

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.quickCategories,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: AppStrings.searchCategories
                .map((label) => _ChipItem(label: label))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _RecentSearchesSection extends StatelessWidget {
  const _RecentSearchesSection();

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.recentSearches,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          const SizedBox(height: 10),
          ...AppStrings.recentSearchItems.map((item) => _SearchRow(label: item)),
        ],
      ),
    );
  }
}

class _TrendingSection extends StatelessWidget {
  const _TrendingSection();

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.trending,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          const SizedBox(height: 10),
          ...AppStrings.trendingItems.map((item) => _SearchRow(label: item)),
        ],
      ),
    );
  }
}

class _SearchRow extends StatelessWidget {
  const _SearchRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: colors.primaryContainer,
        child: Icon(Icons.search, size: 16, color: colors.primary),
      ),
      title: Text(label),
      trailing: Icon(Icons.chevron_right, color: colors.outline),
      dense: true,
    );
  }
}

class _ChipItem extends StatelessWidget {
  const _ChipItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600),
      ),
    );
  }
}
