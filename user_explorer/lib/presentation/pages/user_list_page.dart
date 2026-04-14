import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_explorer/core/constants/app_colors.dart';
import 'package:user_explorer/core/constants/app_strings.dart';
import 'package:user_explorer/domain/entities/user.dart';
import 'package:user_explorer/presentation/bloc/user/user_bloc.dart';
import 'package:user_explorer/presentation/bloc/user/user_event.dart';
import 'package:user_explorer/presentation/bloc/user/user_state.dart';
import 'package:user_explorer/presentation/pages/user_detail_page.dart';
import 'package:user_explorer/presentation/widgets/app_search_field.dart';
import 'package:user_explorer/presentation/widgets/app_top_header.dart';

/// Main list screen:
/// Requests users on startup and reacts to bloc state changes.
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(const FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading || state is UserInitial) {
              return const _ExplorerLoadingView();
            }

            if (state is UserError) {
              return _ExplorerErrorView(
                message: state.message,
                onRetry: () => context.read<UserBloc>().add(const FetchUsers()),
              );
            }

            if (state is UserLoaded) {
              return _ExplorerSuccessView(users: state.users);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ExplorerSuccessView extends StatelessWidget {
  const _ExplorerSuccessView({required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: AppTopHeader(title: AppStrings.appTitle),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: AppSearchField(hint: AppStrings.searchExplorersHint),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.activeUsers,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              Text(
                '${users.length} ${AppStrings.membersSuffix}',
                style: const TextStyle(
                  color: AppColors.accentBlue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return _UserCard(user: users[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final initials = _initials(user.name);
    final colorSeed = user.id % 4;
    final bgColor = AppColors.avatarPalette[colorSeed];
    final role = _roleByIndex(user.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: bgColor,
          child: Text(
            initials,
            style: const TextStyle(
              color: AppColors.chipText,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                role,
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        subtitle: Text(user.email, style: TextStyle(color: colors.outline)),
        trailing: Icon(Icons.chevron_right, color: colors.outline),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => UserDetailPage(user: user)),
          );
        },
      ),
    );
  }
}

class _ExplorerErrorView extends StatelessWidget {
  const _ExplorerErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      children: [
        const AppTopHeader(title: AppStrings.appTitle),
        const SizedBox(height: 20),
        const AppSearchField(hint: AppStrings.searchExplorersHint, enabled: false),
        const SizedBox(height: 26),
        Container(
          height: 210,
          decoration: BoxDecoration(
            color: AppColors.lightCircleBg,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Container(
              width: 118,
              height: 118,
              decoration: BoxDecoration(
                color: AppColors.lightCardBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.cloud_off, size: 52, color: AppColors.primaryBlue),
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          AppStrings.syncConnectionLost,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.mutedText,
            fontSize: 19,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              AppStrings.retryConnection,
              style: TextStyle(letterSpacing: 1.1, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: onRetry,
          child: const Text(
            AppStrings.checkStatus,
            style: TextStyle(
              color: AppColors.statusBlue,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: color.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.circle, size: 8, color: Colors.red),
              SizedBox(width: 10),
              Text(
                AppStrings.errorCode,
                style: TextStyle(
                  color: AppColors.mutedText,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExplorerLoadingView extends StatelessWidget {
  const _ExplorerLoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      children: [
        const AppTopHeader(title: AppStrings.appTitle),
        const SizedBox(height: 20),
        const AppSearchField(hint: AppStrings.searchExplorersHint, enabled: false),
        const SizedBox(height: 18),
        const _SkeletonBox(height: 560),
        const SizedBox(height: 16),
        const _SkeletonTile(),
        const SizedBox(height: 12),
        const _SkeletonTile(),
        const SizedBox(height: 12),
        const _SkeletonTile(),
      ],
    );
  }
}


class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.skeletonBase,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _SkeletonTile extends StatelessWidget {
  const _SkeletonTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.skeletonBase,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          CircleAvatar(radius: 16, backgroundColor: AppColors.skeletonAvatar),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkeletonBar(width: 120),
                SizedBox(height: 7),
                _SkeletonBar(width: 80),
              ],
            ),
          ),
          _SkeletonBar(width: 55, height: 22),
        ],
      ),
    );
  }
}

class _SkeletonBar extends StatelessWidget {
  const _SkeletonBar({required this.width, this.height = 12});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.skeletonAccent,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

String _initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return AppStrings.unknownInitial;
  if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
  return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'.toUpperCase();
}

String _roleByIndex(int id) {
  return AppStrings.roleLabels[id % AppStrings.roleLabels.length];
}
