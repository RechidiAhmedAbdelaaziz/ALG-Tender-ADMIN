part of '../screen/home.screen.dart';

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230.w,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightSpace(55),
          _buildHeader(),
          heightSpace(60),
          ...[
            _DrawerItem(
              title: 'Tenders',
              icon: KIcons.tenders,
              routeName: AppRoutes.tender,
              onTap: () => context.to(TenderNavigator.tenders()),
            ),
          ].map((item) => _buildDrawerItem(item, context)),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: InkWell(
              onTap: () => locator<AuthCubit>().logout(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widthSpace(40),
                  Icon(
                    Icons.logout,
                    color: KColors.grey,
                    size: 24.h,
                  ),
                  widthSpace(16),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: KColors.grey,
                      fontSize: 16.spMax,
                      letterSpacing: 0.32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _buildHeader() {
    return Text(
      '     DZ TENDERS',
      style: TextStyle(
        color: KColors.primary,
        fontSize: 25.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Padding _buildDrawerItem(_DrawerItem item, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.h),
      child: InkWell(
        onTap: item.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widthSpace(40),
            SvgPicture.asset(
              item.icon,
              height: 24.h,
              width: 24.w,
              colorFilter: !item.isSelected(context)
                  ? const ColorFilter.mode(
                      KColors.grey, BlendMode.srcIn)
                  : null,
            ),
            widthSpace(16),
            Text(
              item.title,
              style: TextStyle(
                color: item.isSelected(context)
                    ? KColors.primary
                    : KColors.grey,
                fontSize: 16.spMax,
                letterSpacing: 0.32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem {
  final String title;
  final String icon;
  final String routeName;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.routeName,
    required this.onTap,
  });

  bool isSelected(BuildContext context) {
    return GoRouter.of(context).state.name?.contains(routeName) ??
        false;
  }
}
