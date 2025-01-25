part of 'announcers.dart';

class _AnnouncersList extends StatelessWidget {
  final ValueChanged<AnnouncerModel> onSelecte;
  const _AnnouncersList({required this.onSelecte});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiAnnouncerCubit, MultiAnnouncerState>(
      buildWhen: (previous, current) => previous.isLoading,
      builder: (context, state) {
        final cubit = context.read<MultiAnnouncerCubit>();
        final announcers = state.announcers;
        return SingleChildScrollView(
          child: Column(
            children: [
              ...announcers.map((announcer) {
                return Announcer(
                  announcer,
                  onEdit: cubit.update,
                  onDelete: cubit.remove,
                );
              }),
              if (state.isLoading) const LinearProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
