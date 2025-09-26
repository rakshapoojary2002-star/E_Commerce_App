import 'package:e_commerce_app/core/utils/flutter_secure.dart';
import 'package:e_commerce_app/domain/profile/entities/user_profile.dart';
import 'package:e_commerce_app/presentation/auth/screens/auth_page.dart';
import 'package:e_commerce_app/presentation/profile/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/core/providers/profile_providers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/presentation/profile/widgets/profile_shimmer_loading.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    Future.microtask(() => ref.read(profileScreenProvider).fetchUserProfile());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileScreenProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.h,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: colorScheme.primaryContainer,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff31628d), // Your custom primary
                      const Color(0xffcfe5ff), // Your custom primaryContainer
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xff9dcbfb,
                          ).withOpacity(0.2), // Your primary variant
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      left: -30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xff124a73,
                          ).withOpacity(0.15), // Your darker primary
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // Settings or edit profile
                },
                icon: Icon(Icons.settings, color: colorScheme.onPrimary),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Builder(
              builder: (context) {
                if (profileState.state == ProfileState.loading) {
                  return const ProfileShimmerLoading();
                } else if (profileState.state == ProfileState.error) {
                  return _buildErrorState(profileState.errorMessage);
                } else if (profileState.state == ProfileState.loaded &&
                    profileState.userProfile != null) {
                  _animationController.forward();
                  return _buildProfileContent(profileState.userProfile!);
                } else {
                  return _buildEmptyState();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(UserProfile user) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            // Profile Header
            Transform.translate(
              offset: Offset(0, -30.h),
              child: Column(
                children: [
                  Hero(
                    tag: 'profile_avatar',
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60.w,
                        backgroundColor: const Color(
                          0xfffaf8ff,
                        ), // Your surface color
                        child: CircleAvatar(
                          radius: 55.w,
                          backgroundColor: const Color(
                            0xffcfe5ff,
                          ), // Your primaryContainer
                          child: Icon(
                            Icons.person,
                            size: 50.w,
                            color: const Color(
                              0xff124a73,
                            ), // Your onPrimaryContainer
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          user.isActive
                              ? Colors.green.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: user.isActive ? Colors.green : Colors.orange,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          user.isActive ? Icons.check_circle : Icons.pending,
                          size: 12.w,
                          color: user.isActive ? Colors.green : Colors.orange,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          user.isActive ? 'Active' : 'Inactive',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: user.isActive ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    user.email,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Profile Information Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildInfoCard(
                    icon: Icons.phone_rounded,
                    title: 'Phone Number',
                    value:
                        user.phone?.isNotEmpty == true
                            ? user.phone!
                            : 'Not provided',
                    color: const Color(0xff31628d), // Your primary blue
                  ),
                  SizedBox(height: 12.h),
                  _buildInfoCard(
                    icon: Icons.calendar_today_rounded,
                    title: 'Member Since',
                    value: _formatDate(user.createdAt),
                    color: const Color(0xff6c5e0f), // Your secondary yellow
                  ),
                  SizedBox(height: 12.h),
                  _buildInfoCard(
                    icon: Icons.update_rounded,
                    title: 'Last Updated',
                    value: _formatDate(user.updatedAt),
                    color: const Color(0xff2c6a46), // Your tertiary green
                  ),
                  SizedBox(height: 32.h),

                  // Action Buttons
                  _buildActionButtons(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xfff4f3fa), // Your surfaceContainerLow
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(
            0xffd4c4b5,
          ).withOpacity(0.5), // Your outlineVariant
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xff827568,
            ).withOpacity(0.08), // Your outline with opacity
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 24.w),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        // Edit Profile Button
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Navigate to edit profile
              print('Edit profile pressed');
            },
            icon: Icon(Icons.edit_rounded),
            label: Text(
              'Edit Profile',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff31628d), // Your primary
              foregroundColor: const Color(0xffffffff), // Your onPrimary
              elevation: 2,
              shadowColor: const Color(0xff31628d).withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),

        // Logout Button
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: OutlinedButton.icon(
            onPressed: () {
              _showLogoutDialog();
            },
            icon: Icon(Icons.logout_rounded),
            label: Text(
              'Logout',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xffba1a1a), // Your error color
              side: const BorderSide(
                color: Color(0xffba1a1a),
              ), // Your error color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String? errorMessage) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64.w,
            color: const Color(0xffba1a1a), // Your error color
          ),
          SizedBox(height: 16.h),
          Text(
            'Oops! Something went wrong',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            errorMessage ?? 'Unable to load profile data',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xff504539), // Your onSurfaceVariant
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(profileScreenProvider).fetchUserProfile();
            },
            icon: Icon(Icons.refresh_rounded),
            label: Text('Try Again'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_rounded,
            size: 64.w,
            color: const Color(0xff504539), // Your onSurfaceVariant
          ),
          SizedBox(height: 16.h),
          Text(
            'No Profile Data',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Profile information is not available at the moment',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xff504539), // Your onSurfaceVariant
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(Icons.logout_rounded, color: colorScheme.error),
              SizedBox(width: 8.w),
              Text('Logout'),
            ],
          ),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await SecureStorage.clearToken();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AuthPage()),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffba1a1a), // Your error color
                foregroundColor: const Color(0xffffffff), // Your onError
              ),
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays < 1) {
      return 'Today';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
