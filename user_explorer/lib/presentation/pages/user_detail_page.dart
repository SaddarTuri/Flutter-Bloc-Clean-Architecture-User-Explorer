import 'package:flutter/material.dart';
import 'package:user_explorer/core/constants/app_colors.dart';
import 'package:user_explorer/core/constants/app_strings.dart';
import 'package:user_explorer/domain/entities/user.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.userDetailTitle), backgroundColor: colors.surface),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          const _TopTabs(),
          const SizedBox(height: 12),
          _ProfileHeader(user: user),
          const SizedBox(height: 16),
          _InfoCard(
            title: AppStrings.contactInformation,
            items: [
              _InfoItemData(label: AppStrings.emailAddress, value: user.email),
              _InfoItemData(label: AppStrings.phoneNumber, value: user.phone),
              _InfoItemData(label: AppStrings.location, value: user.city),
            ],
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: AppStrings.professionalDetails,
            items: [
              _InfoItemData(label: AppStrings.company, value: user.companyName),
              _InfoItemData(label: AppStrings.username, value: user.username),
              _InfoItemData(label: AppStrings.website, value: user.website),
            ],
          ),
          const SizedBox(height: 12),
          const _StatsPanel(),
          const SizedBox(height: 16),
          const _ActivityTimeline(),
        ],
      ),
    );
  }
}

class _TopTabs extends StatelessWidget {
  const _TopTabs();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(AppStrings.userProfile, style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.softDividerText)),
        SizedBox(width: 12),
        Text(AppStrings.appTitle, style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryBlue)),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundColor: AppColors.primaryBlue,
              child: CircleAvatar(
                radius: 49,
                backgroundImage: NetworkImage(
                  '${AppStrings.profileAvatarUrl}${(user.id % 70) + 1}',
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.settings, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          user.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        Text(
          user.companyName.isEmpty ? AppStrings.teamMember : user.companyName,
          style: const TextStyle(color: AppColors.detailMuted, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
              ),
              child: const Text(AppStrings.connect),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryBlue),
                foregroundColor: AppColors.primaryBlue,
              ),
              child: const Icon(Icons.mail_outline, size: 18),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.items});

  final String title;
  final List<_InfoItemData> items;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const Icon(Icons.badge, color: AppColors.softDividerText, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          ...items.map((item) => _InfoRow(item: item)),
        ],
      ),
    );
  }
}

class _InfoItemData {
  const _InfoItemData({required this.label, required this.value});

  final String label;
  final String value;
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.item});

  final _InfoItemData item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 9, color: AppColors.detailDot),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.detailLabel,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.value.isEmpty ? '-' : item.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.detailValue,
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

class _StatsPanel extends StatelessWidget {
  const _StatsPanel();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: const [
          _StatTile(value: '248', label: AppStrings.managedProjects),
          Divider(height: 1),
          _StatTile(value: '12.5k', label: AppStrings.totalUsers),
          Divider(height: 1),
          _StatTile(value: '98.2%', label: AppStrings.efficiencyRate),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 34,
              color: AppColors.primaryBlueDark,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: AppColors.softDividerText,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityTimeline extends StatelessWidget {
  const _ActivityTimeline();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              AppStrings.activityTimeline,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(
              AppStrings.viewHistory,
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _TimelineItem(
          title: AppStrings.updatedArchitectureDocumentation,
          subtitle: AppStrings.twoHoursAgo,
        ),
        const SizedBox(height: 10),
        _TimelineItem(
          title: AppStrings.onboardedTeamMembers,
          subtitle: AppStrings.yesterday,
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.timelineAvatarBg,
            child: Icon(Icons.groups_2, color: AppColors.primaryBlue, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.timelineText, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.timelineArrow),
        ],
      ),
    );
  }
}

