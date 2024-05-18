import '../../../../exports.dart';

class PriceRangeSlider extends StatefulWidget {
  final double minPrice;
  final double maxPrice;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;

  PriceRangeSlider({
    required this.minPrice,
    required this.maxPrice,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  late RangeValues _values;

  @override
  void initState() {
    super.initState();
    _values = RangeValues(widget.minPrice, widget.maxPrice);
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _values,
      min: widget.min,
      max: widget.max,
      onChanged: (values) {
        setState(() {
          _values = values;
        });
        widget.onChanged(values);
      },
    );
  }
}
