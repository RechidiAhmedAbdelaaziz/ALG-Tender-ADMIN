part of '../view/tenders.screen.dart';

class _Filters extends StatefulWidget {
  final TenderFiltersDto filters;
  const _Filters(this.filters);

  @override
  State<_Filters> createState() => _FiltersState();
}

class _FiltersState extends State<_Filters> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12.h,
        children: [
          Row(
            children: [
              _buildTitle(),
              const Spacer(),
              _buildButtons(
                onRestore: () =>
                    setState(() => widget.filters.clear()),
                onCancel: () => context.back(),
              ),
            ],
          ),
          const Divider(),
          SelectableAnnouncer(controller: widget.filters.announcer),
          KDropDownMenu(
            items: ['itmes'],
            controller: widget.filters.marketType,
            title: 'Type de marché',
            initalized: false,
          ),
          MultiDropDownMenu(
            items: ['itmes'],
            controller: widget.filters.regions,
            title: 'Regions',
            initalized: false,
          ),
          MultiDropDownMenu(
            items: ['industries'],
            controller: widget.filters.industries,
            title: 'Industries',
            initalized: false,
          ),
          AppCheckBox(
            title: 'Startup',
            onChanged: widget.filters.isStartup.setValue,
          ),
          heightSpace(12),
          Align(
            alignment: Alignment.centerRight,
            child: SubmitButton(
              title: 'Appliquer',
              onTap: () => context.back(true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Text(
        'Filters',
        style: TextStyle(
          fontSize: 24.spMax,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildButtons({
    required void Function() onRestore,
    required void Function() onCancel,
  }) {
    return Row(
      children: [
        IconButton(onPressed: onRestore, icon: Icon(Icons.restore)),
        IconButton(onPressed: onCancel, icon: Icon(Icons.cancel)),
      ],
    );
  }
}
