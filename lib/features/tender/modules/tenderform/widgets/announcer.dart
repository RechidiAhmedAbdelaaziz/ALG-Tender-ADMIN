part of '../view/tender_form.dart';

class _Announcer extends StatefulWidget {
  final EditingController<AnnouncerModel> controller;
  const _Announcer(this.controller);

  @override
  State<_Announcer> createState() => __AnnouncerState();
}

class __AnnouncerState extends State<_Announcer> {
  AnnouncerModel? announcer;

  @override
  void initState() {
    announcer = widget.controller.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (announcer != null)
          Announcer(
            announcer!,
            onEdit: (announcer) {
              widget.controller.setValue(announcer);
              setState(() => this.announcer = announcer);
            },
          ),
        ElevatedButton(
          onPressed: () {
            context.dialog(
              child: BlocProvider(
                create: (context) => MultiAnnouncerCubit()..load(),
                child: Announcers(
                  onSelecte: (announcer) {
                    widget.controller.setValue(announcer);

                    setState(() => this.announcer = announcer);
                  },
                ),
              ),
            );
          },
          child: Text(announcer == null
              ? 'Select Announcer'
              : 'Change Announcer'),
        )
      ],
    );
  }
}
