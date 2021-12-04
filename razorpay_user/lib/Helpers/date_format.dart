import 'package:cloud_firestore/cloud_firestore.dart';

class DateFormat {
  static String monthConv(int month) {
    String formattedMonth = '';

    switch (month) {
      case 1:
        {
          formattedMonth = 'Jan';
        }
        break;
      case 2:
        {
          formattedMonth = 'Feb';
        }
        break;
      case 3:
        {
          formattedMonth = 'Mar';
        }
        break;
      case 4:
        {
          formattedMonth = 'Apr';
        }
        break;
      case 5:
        {
          formattedMonth = 'May';
        }
        break;
      case 6:
        {
          formattedMonth = 'Jun';
        }
        break;
      case 7:
        {
          formattedMonth = 'Jul';
        }
        break;
      case 8:
        {
          formattedMonth = 'Aug';
        }
        break;
      case 9:
        {
          formattedMonth = 'Sep';
        }
        break;
      case 10:
        {
          formattedMonth = 'Oct';
        }
        break;
      case 11:
        {
          formattedMonth = 'Nov';
        }
        break;
      case 12:
        {
          formattedMonth = 'Dec';
        }
        break;
    }

    return formattedMonth;
  }

  static String amPm(int railTime) {
    String time;

    if (railTime >= 12) {
      time = 'PM';
    } else {
      time = 'AM';
    }
    return time;
  }

  static int railwayTimeConv(int railTime) {
    int time;

    if (railTime > 12) {
      time = railTime - 12;
    } else {
      time = railTime;
    }
    return time;
  }

  static String formatDate(Timestamp timestamp) {
    String formattedDate;

    final dateTime = timestamp.toDate();

    formattedDate =
        '${DateFormat.monthConv(dateTime.month)} ${dateTime.day},${DateTime.now().year == dateTime.year ? '' : (dateTime.year).toString().padLeft(5, ' ')} ${railwayTimeConv(dateTime.hour)}:${dateTime.minute.toString().padLeft(2, '0')} ${amPm(dateTime.hour)}';

    return formattedDate;
  }
}
