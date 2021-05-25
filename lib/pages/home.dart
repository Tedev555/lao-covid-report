import 'package:flutter/material.dart';
import 'package:lao_covid_tracker/components/my_app_bar.dart';
import 'package:lao_covid_tracker/pages/number_board.dart';
import 'package:lao_covid_tracker/pages/web_api.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _menuList = [
    {'title': 'ລາວ', 'tag': 'LAOS'},
    {'title': 'ທົ່ວໂລກ', 'tag': 'GLOBAL'},
  ];
  double appVersion = 0.1;
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

  void _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void showAppInfo() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('ກ່ຽວກັບແອັບຯ LaoCovidInfo'),
            content: Container(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Developed by:'),
                  Text('Thanongsine Chanthakham'),
                  SizedBox(height: 16,),
                  Text('E-mail: thanong984@gmail.com'),
                  Text('Phone: +85620-58888-059'),
                  SizedBox(height: 16,),
                  Text('Information: ສູນຂ່າວສານການແພດສຸຂະສຶກສາ'),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(showInfo: showAppInfo),
        body: Container(
          color: Theme.of(context).primaryColor,
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
                        SizedBox(height: 8),
                        Text('ກຳລັງໂຫລດຂໍ້ມູນ',
                            style: TextStyle(color: Colors.white))
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
    if (appVersion != data['appVersion']) {
      return AlertDialog(
        title: Text('ແຈ້ງເຕືອນ'),
        content: Text('ຕອນນີ້ແອັບຯມີເວີຊັນໃຫມ່ແລ້ວ, ກະລຸນາອັບເດດ!'),
        actions: [
          TextButton(
              onPressed: () {
                _launchURL(data['updateURL']);
              },
              child: Text('ກົດເພື່ອອັບເດດ'))
        ],
      );
    }
    return ListView(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16, right: 24),
            child: Column(
              children: [
                Text('ສະຖິຕິການຕິດເຊື້ອ',
                    style: TextStyle(fontSize: 24, color: Colors.white)),
              ],
            )),
        Container(
          padding: EdgeInsets.only(left: 16, right: 24, bottom: 8),
          child: Text('ໂຄວິດ-19 ຢູ່ລາວ',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: EdgeInsets.only(right: 32, bottom: 8),
          alignment: Alignment.centerRight,
          child: Text(
            'ອັບເດດຂໍ້ມູນວັນທີ: ${data['infoDate']}',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: NumberBoard(data: data)),
        SizedBox(
          height: 16,
        ),
        Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Text('ຂ່າວສານ',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            )),
        Container(
            margin: EdgeInsets.only(right: 16, left: 16),
            child: Column(
              children: [_listNews(data['newsList']), SizedBox(height: 16)],
            ))
      ],
    );
  }

  Widget _listNews(newsList) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                _launchURL(newsList[index]['link']);
              },
              tileColor: Colors.white,
              leading:
                  Icon(Icons.mail_outline, color: Colors.black87, size: 30),
              title: Text(newsList[index]['title'],
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              // trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black87),
            ),
          );
        });
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
