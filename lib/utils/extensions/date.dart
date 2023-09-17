extension DeliveryDate on DateTime {
  static const List<String> _monthAbbreviations = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String get deliveryDate {
    return "${_monthAbbreviations[month - 1]} $day, $year";
  }
}
