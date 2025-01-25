part of 'announcers.dart';

class _AnnouncersList extends StatelessWidget {
  final ValueChanged<AnnouncerModel> onSelecte;
  const _AnnouncersList({required this.onSelecte});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiAnnouncerCubit, MultiAnnouncerState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoaded,
      builder: (context, state) {
        final announcers = state.announcers;
        return Column(
          children: [
            PaginationBuilder(
              items: announcers,
              itemBuilder: (announcer) => Announcer(announcer),
              onLoadMore: context.read<MultiAnnouncerCubit>().load,
            ),
            if (state.isLoading)
              const LinearProgressIndicator(color: KColors.primary),
          ],
        );
      },
    );
  }
}
