part of 'announcers.dart';

class _AnnouncersList extends StatelessWidget {
  final ValueChanged<AnnouncerModel> onSelecte;
  const _AnnouncersList({required this.onSelecte});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiAnnouncerCubit, MultiAnnouncerState>(
      builder: (context, state) {
        final cubit = context.read<MultiAnnouncerCubit>();
        final announcers = state.announcers;
        return PaginationBuilder(
          items: announcers,
          onLoadMore: cubit.load,
          isLoading: context.select(
              (MultiAnnouncerCubit cubit) => cubit.state.isLoading),
          separator: Divider(),
          itemBuilder: (announcer) {
            return InkWell(
              onTap: () {
                onSelecte(announcer);
                Navigator.of(context).pop();
              },
              child: Announcer(
                announcer,
                onEdit: cubit.update,
                onDelete: cubit.remove,
              ),
            );
          },
        );
      },
    );
  }
}
