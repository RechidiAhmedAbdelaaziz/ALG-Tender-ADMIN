part of '../view/result_form.dart';

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    final dto = context.read<SingleResultCubit>().state.dto;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightSpace(20),
        Text(
          'Informations sur le résultat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.spMax,
            fontWeight: FontWeight.w700,
          ),
        ),
        heightSpace(20),
        AppTextFormField(
          controller: dto.title,
          title: 'Titre du résultat',
        ),
        heightSpace(12),
        KDropDownMenu(
            items: ['item1', 'item2'],
            controller: dto.type,
            title: 'Type de résultat'),
        heightSpace(12),
        KDropDownMenu(
            items: ['item1', 'item2'],
            controller: dto.region,
            title: 'Région'),
        heightSpace(12),
        SizedBox(
          width: 300.w,
          child: DatePicker(
            controller: dto.publishedDate,
            title: 'Date de publication',
          ),
        ),
      ],
    );
  }
}
