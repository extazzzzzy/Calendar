import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentDate = DateTime.now();
  List<String> years = ['2015', '2016', '2017', '2018', '2019', '2020',
    '2021', '2022', '2023', '2024', '2025', '2026',
    '2027', '2028', '2029', '2030', '2031', '2032', '2033'];
  List<String> months = [
    'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
    'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'
  ];

  late String currentYear;
  late String currentMonth;


  @override
  void initState() {
    currentYear = DateTime.now().year.toString();
    currentMonth = months[DateTime.now().month - 1];
  }

  int getCountDaysMonth(int year, int month) {
    final firstDayNextMonth = DateTime(year, month + 1, 1);
    final lastDayMonth = firstDayNextMonth.subtract(Duration(days: 1));
    return lastDayMonth.day;
  }

  int getFirstDayMonth(int year, int month) {
    DateTime firstDayMonth = DateTime(year, month, 1);
    return firstDayMonth.weekday;
  }

  @override
  Widget build(BuildContext context) {
    int countDaysMonth = getCountDaysMonth(int.parse(currentYear),
        months.indexOf(currentMonth) + 1);
    int firstDayMonth = getFirstDayMonth(int.parse(currentYear),
        months.indexOf(currentMonth) + 1);

    List<Widget> dayWidgets = [];
    for (int i = 1; i < firstDayMonth; i++) {
      dayWidgets.add(Container());
    }

    for (int i = 1; i <= countDaysMonth; i++) {
      bool isToday = i == DateTime.now().day &&
          months.indexOf(currentMonth) + 1 == DateTime.now().month &&
          int.parse(currentYear) == DateTime.now().year;

      dayWidgets.add(
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isToday ? Colors.redAccent : null,
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$i',
              style: TextStyle(
                fontSize: 20,
                color: isToday ? Colors.white : Colors.black,
                fontFamily: 'DushaRegular',
              ),
            ),
          ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Календарь',
              style: TextStyle(
                fontFamily: 'DushaRegular',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            IconButton(
              icon: Icon(Icons.replay),
              onPressed: () {
                setState(() {
                  currentDate = DateTime.now();
                  currentYear = currentDate.year.toString();
                  currentMonth = months[currentDate.month - 1];
                });
              },
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(255, 255, 224, 1),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: currentYear,
            items: years.map((String year) {
              return DropdownMenuItem<String>(
                value: year,
                child: Text(
                  year,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'DushaRegular',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                currentYear = newValue!;
              });
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  setState(() {
                    if (currentDate.month == 1) {
                      currentDate = DateTime(currentDate.year - 1, 12);
                    } else {
                      currentDate = DateTime(currentDate.year, currentDate.month - 1);
                    }
                    currentYear = currentDate.year.toString();
                    currentMonth = months[currentDate.month - 1];
                  });
                },
              ),
              Text(
                '$currentMonth',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'DushaRegular',
                    fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {
                  setState(() {
                    if (currentDate.month == 12) {
                      currentDate = DateTime(currentDate.year + 1, 1);
                    } else {
                      currentDate = DateTime(currentDate.year, currentDate.month + 1);
                    }
                    currentYear = currentDate.year.toString();
                    currentMonth = months[currentDate.month - 1];
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Пн', style: TextStyle(fontSize: 20, fontFamily: 'DushaRegular', fontWeight: FontWeight.bold)),
              Text('Вт', style: TextStyle(fontSize: 20, fontFamily: 'DushaRegular', fontWeight: FontWeight.bold)),
              Text('Ср', style: TextStyle(fontSize: 20, fontFamily: 'DushaRegular', fontWeight: FontWeight.bold)),
              Text('Чт', style: TextStyle(fontSize: 20, fontFamily: 'DushaRegular', fontWeight: FontWeight.bold)),
              Text('Пт', style: TextStyle(fontSize: 20, fontFamily: 'DushaRegular', fontWeight: FontWeight.bold)),
              Text('Сб', style: TextStyle(fontSize: 20, fontFamily: 'DushaRegular', fontWeight: FontWeight.bold)),
              Text('Вс', style: TextStyle(fontSize: 20, fontFamily: 'DushaRegular', fontWeight: FontWeight.bold)),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: dayWidgets.length,
              itemBuilder: (context, index) {
                return dayWidgets[index];
              },
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(250, 255, 224, 1),
    );
  }
}
