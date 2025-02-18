part of '../view/tender_form.dart';

class _Attachments extends StatelessWidget {
  const _Attachments();

  @override
  Widget build(BuildContext context) {
    final dto = context.read<TenderCubit>().state.dto;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('Announcer'),
          SelectableAnnouncer(
            controller: dto.announcer,
            isRequired: true,
          ),
          _buildTitle('Les sources'),
          BlocProvider(
            create: (context) {
              return SourceCubit(dto.sources);
            },
            child: SourcesWidget(
              isNew: dto is CreateTenderDTO,
              onAdd: (value) {
                dto.sources.addValue(value);
              },
              onDelete: (value) => dto.sources.removeValue(value),
              onEdit: (value) => dto.sources.replaceValue(value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24.spMax,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
