part of '../view/result_form.dart';

class _Attachments extends StatelessWidget {
  const _Attachments();

  @override
  Widget build(BuildContext context) {
    final dto = context.read<SingleResultCubit>().state.dto;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('L\'appel d\'offre'),
          SelectableTender(
            controller: dto.tender,
            isRequired: true,
          ),
          _buildTitle('Les sources'),
          BlocProvider(
            create: (context) {
              return SourceCubit(context
                  .read<SingleResultCubit>()
                  .state
                  .dto
                  .sources);
            },
            child: SourcesWidget(
              isNew: dto is CreateResultDTO,
              onAdd: (value) {
                context
                    .read<SingleResultCubit>()
                    .state
                    .dto
                    .sources
                    .addValue(value);
              },
              onDelete: (value) => context
                  .read<SingleResultCubit>()
                  .state
                  .dto
                  .sources
                  .removeValue(value),
              onEdit: (value) => context
                  .read<SingleResultCubit>()
                  .state
                  .dto
                  .sources
                  .replaceValue(value),
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
