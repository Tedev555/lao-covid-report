import 'package:flutter/material.dart';
import 'package:lao_covid_tracker/pages/number_board.dart';
import 'package:lao_covid_tracker/pages/web_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _menuList = [
    {'title': 'ລາວ', 'tag': 'LAOS'},
    {'title': 'ທົ່ວໂລກ', 'tag': 'GLOBAL'},
  ];
  String _selectedMenu;
  WebApi _webApi = WebApi();

  @override
  void initState() {
    super.initState();
    _selectedMenu = "LAOS";
  }

  void onSelectMenu(String menu) {
    switch (menu) {
      case 'LAOS':
        break;
      case 'YESTERDAY':
        setState(() {
          _selectedMenu = menu;
        });
        break;
      case 'TOTAL':
        setState(() {
          _selectedMenu = menu;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder<Map<String, dynamic>>(
          future: _webApi.getCovidCasesData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('ກຳລັງໂຫລດຂໍ້ມູນ')
                  ],
                ));
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return _buildBody(snapshot.data);
            }
          }),
    ));
  }

  Widget _buildBody(Map<String, dynamic> data) {
    return ListView(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16, right: 24, top: 16),
            child: Column(
              children: [
                Text('ສະຖິຕິການຕິດເຊື້ອ',
                    style: TextStyle(fontSize: 24, color: Colors.black54)),
              ],
            )),
        Container(
          padding: EdgeInsets.only(left: 16, right: 24, bottom: 16),
          child: Text('ໂຄວິດ-19 ຢູ່ລາວ',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: NumberBoard(data: data))
      ],
    );
  }

  Widget _buildMenuTap(Map item) {
    Color textColor = Colors.white;
    Color bgColor = Colors.white.withOpacity(0);
    if (_selectedMenu == item['tag']) {
      textColor = Colors.black;
      bgColor = Colors.white;
    }

    return InkWell(
      onTap: () {
        setState(() {
          _selectedMenu = item['tag'];
        });
      },
      child: Container(
        width: 180,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Text(item['title'],
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            )),
      ),
    );
  }
}
