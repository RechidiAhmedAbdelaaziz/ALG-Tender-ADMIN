part of '../view/tender_form.dart';

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    final dto = context.read<TenderCubit>().state.dto;
    return Column(
      children: [
        heightSpace(20),
        Text(
          'Informations sur l\'appel d\'offre',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.spMax,
            fontWeight: FontWeight.w700,
          ),
        ),
        heightSpace(20),
        AppTextFormField(
          controller: dto.title,
          title: 'Titre de l\'appel d\'offre',
        ),
        heightSpace(12),
        KDropDownMenu(
          items: ['item1', 'item2'],
          controller: dto.industry,
          title: 'Secteur d\'activité',
        ),
        heightSpace(12),
        KDropDownMenu(
          items: ['item1', 'item2'],
          controller: dto.marketType,
          title: 'Type de marché',
        ),
        heightSpace(12),
        KDropDownMenu(
          items: ['item1', 'item2'],
          controller: dto.region,
          title: 'Région',
        ),
        heightSpace(12),
        AppTextFormField(
          controller: dto.chargePrice,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          title: 'Prix de charge',
          keyboardType: TextInputType.number,
        ),
        heightSpace(12),
        Row(
          children: [
            Expanded(
                child: DatePicker(
                    controller: dto.publishedDate,
                    title: 'Date de publication')),
            widthSpace(24),
            Expanded(
              child: DatePicker(
                controller: dto.closingDate,
                title: 'Date de clôture',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
