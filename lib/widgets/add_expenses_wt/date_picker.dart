import 'package:flutter/material.dart';
import 'package:expenses_app/models/models.dart';

class DatePicker extends StatefulWidget {
  final CombinedModel cModel;
  const DatePicker({Key? key, required this.cModel}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String selecteDay = 'Hoy';

  @override
  void initState() {
    if (widget.cModel.day == 0) {
      widget.cModel.years = DateTime.now().year;
      widget.cModel.month = DateTime.now().month;
      widget.cModel.day = DateTime.now().day;
    } else {
      selecteDay = 'Otro dia';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _date = DateTime.now();
    var _widgets = <Widget>[];

    _widgets.insert(0, const Icon(Icons.date_range_outlined, size: 35.0));
    _widgets.insert(1, const SizedBox(width: 4));

    _calendar() {
      showDatePicker(
        context: context,
        locale: const Locale('es', 'ES'),
        initialDate: _date.subtract(const Duration(hours: 24 * 2)),
        firstDate: _date.subtract(const Duration(hours: 24 * 30)),
        lastDate: _date.subtract(const Duration(hours: 24 * 2)),
      ).then((value) {
        if (value != null) {
          widget.cModel.years = value.year;
          widget.cModel.month = value.month;
          widget.cModel.day = value.day;
          setState(() {});
        } else {
          selecteDay = 'Hoy';
          setState(() {});
        }
      });
    }

    Map<String, DateTime> items = {
      'Hoy': _date,
      'Ayer': _date.subtract(const Duration(hours: 24)),
      'Otro dia': _date
    };
    items.forEach((name, date) {
      _widgets.add(Expanded(
        child: GestureDetector(
          onTap: () {
            selecteDay = name;
            widget.cModel.years = date.year;
            widget.cModel.month = date.month;
            widget.cModel.day = date.day;
            if (name == 'Otro dia') _calendar();
            setState(() {});
          },
          child: DateContainWidget(
            cModel: widget.cModel,
            name: name,
            isSelected: name == selecteDay,
          ),
        ),
      ));
    });

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(children: _widgets),
    );
  }
}

class DateContainWidget extends StatelessWidget {
  final CombinedModel cModel;
  final String name;
  final bool isSelected;

  const DateContainWidget({
    super.key,
    required this.cModel,
    required this.name,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.green
                  : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Center(
              child: Text(name),
            ),
          ),
        ),
        isSelected
            ? FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('${cModel.day}/${cModel.month}/${cModel.years}'),
              )
            : const Text('')
      ],
    );
  }
}
