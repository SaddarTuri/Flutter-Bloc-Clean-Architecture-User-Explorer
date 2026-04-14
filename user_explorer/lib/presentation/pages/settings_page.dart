import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_explorer/core/constants/app_colors.dart';
import 'package:user_explorer/core/constants/app_strings.dart';
import 'package:user_explorer/presentation/bloc/theme/theme_bloc.dart';
import 'package:user_explorer/presentation/bloc/theme/theme_event.dart';
import 'package:user_explorer/presentation/bloc/theme/theme_state.dart';
import 'package:user_explorer/presentation/widgets/section_container.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.onBackToExplorer});

  final VoidCallback onBackToExplorer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onBackToExplorer,
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
        ),
        title: const Text(AppStrings.settings),
        actions: const [Padding(padding: EdgeInsets.only(right: 8), child: Icon(Icons.more_vert))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        children: const [
          _ProfileCard(),
          SizedBox(height: 12),
          _BalanceCard(),
          SizedBox(height: 16),
          _AccountSection(),
          SizedBox(height: 12),
          _NotificationSection(),
          SizedBox(height: 12),
          _AppPreferencesSection(),
          SizedBox(height: 12),
          _SupportSection(),
          SizedBox(height: 18),
          _LogoutButton(),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SectionContainer(
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colors.primaryContainer,
            child: Icon(Icons.person, color: colors.primary),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(AppStrings.profileName, style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 4),
                Text(AppStrings.profileMembership, style: TextStyle(color: AppColors.settingsSecondary)),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: const Text(AppStrings.editProfile)),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.account_balance_wallet, color: Colors.white70),
            SizedBox(height: 6),
            Text(
              '\$42,850',
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
            ),
            Text(
              AppStrings.netBalance,
              style: TextStyle(color: Colors.white70, letterSpacing: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountSection extends StatelessWidget {
  const _AccountSection();

  @override
  Widget build(BuildContext context) {
    return _SettingsSection(
      title: AppStrings.account,
      children: const [
        _SettingsTile(icon: Icons.person, title: AppStrings.personalInfo),
        _SettingsTile(icon: Icons.lock, title: AppStrings.password),
        _SettingsTile(icon: Icons.shield, title: AppStrings.security),
      ],
    );
  }
}

class _NotificationSection extends StatelessWidget {
  const _NotificationSection();

  @override
  Widget build(BuildContext context) {
    return _SettingsSection(
      title: AppStrings.notifications,
      children: const [
        _ToggleTile(title: AppStrings.pushNotifications, initialValue: true),
        _ToggleTile(title: AppStrings.emailAlerts, initialValue: false),
      ],
    );
  }
}

class _AppPreferencesSection extends StatelessWidget {
  const _AppPreferencesSection();

  @override
  Widget build(BuildContext context) {
    return _SettingsSection(
      title: AppStrings.appPreferences,
      children: [
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return _ToggleTile(
              title: AppStrings.darkMode,
              initialValue: state.isDarkMode,
              onChanged: (value) {
                context.read<ThemeBloc>().add(SetThemeEvent(isDarkMode: value));
              },
            );
          },
        ),
        const _SettingsTile(
          icon: Icons.language,
          title: AppStrings.language,
          trailingText: AppStrings.englishUS,
        ),
      ],
    );
  }
}

class _SupportSection extends StatelessWidget {
  const _SupportSection();

  @override
  Widget build(BuildContext context) {
    return _SettingsSection(
      title: AppStrings.support,
      children: const [
        _SettingsTile(icon: Icons.help, title: AppStrings.helpCenter),
        _SettingsTile(icon: Icons.chat, title: AppStrings.contactUs),
      ],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 3, height: 18, color: AppColors.primaryBlue),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 8),
        SectionContainer(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.trailingText,
  });

  final IconData icon;
  final String title;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: colors.primaryContainer,
        child: Icon(icon, size: 18, color: colors.primary),
      ),
      title: Text(title),
      trailing: trailingText == null
          ? Icon(Icons.chevron_right, color: colors.outline)
          : Text(trailingText!, style: const TextStyle(color: AppColors.settingsTrailing)),
      dense: true,
    );
  }
}

class _ToggleTile extends StatefulWidget {
  const _ToggleTile({
    required this.title,
    required this.initialValue,
    this.onChanged,
  });

  final String title;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  @override
  State<_ToggleTile> createState() => _ToggleTileState();
}

class _ToggleTileState extends State<_ToggleTile> {
  late bool _value = widget.initialValue;

  @override
  void didUpdateWidget(covariant _ToggleTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.title),
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
        widget.onChanged?.call(value);
      },
      activeColor: AppColors.primaryBlue,
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.logoutText,
            side: const BorderSide(color: AppColors.logoutBorder),
            minimumSize: const Size(120, 44),
          ),
          child: const Text(AppStrings.logout),
        ),
        const SizedBox(height: 8),
        const Text(
          AppStrings.versionText,
          style: TextStyle(color: AppColors.versionText, fontSize: 11),
        ),
      ],
    );
  }
}
