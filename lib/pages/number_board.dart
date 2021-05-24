import 'package:flutter/material.dart';

class NumberBoard extends StatefulWidget {
  final Map<String, dynamic> data;

  const NumberBoard({Key key, this.data}) : super(key: key);

  @override
  _NumberBoardState createState() => _NumberBoardState();
}

class _NumberBoardState extends State<NumberBoard> {
  bool _showProvinces = false;

  @override
  Widget build(BuildContext context) {
    final scWidth = MediaQuery.of(context).size.width;
    final boardWidth = (scWidth - 48) / 2;
    final _provinceCasesData =
        widget.data['provinces'];

    return Column(
      children: [
        _newCasesBox(
            widget.data['newCases'], _provinceCasesData, scWidth, 150.0),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _numberBox(
                'ກຳລັງປິນປົວ', '961 ຄົນ', boardWidth, 150.0, Colors.blue, 24),
            SizedBox(width: 16),
            _numberBox(
                'ປິ່ນປົວຫາຍດີ', '800 ຄົນ', boardWidth, 150.0, Colors.green, 24),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _numberBox('ເສຍຊີວິດ', '2 ຄົນ', boardWidth, 150.0, Colors.pink, 24),
            SizedBox(width: 16),
            _numberBox('ໄດ້ຮັບການກວດ', '230,610 ຄົນ', boardWidth, 150.0,
                Colors.blueGrey, 24),
          ],
        ),
      ],
    );
  }

  Widget _newCasesBox(
      int newCases, provinceCases, width, height) {
    return Container(
      padding: EdgeInsets.all(8),
      width: width,
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Text('ຕິດເຊື້ອໃຫມ່',
              style: TextStyle(color: Colors.red, fontSize: 18)),
          SizedBox(
            height: 8,
          ),
          Text('+ $newCases ຄົນ',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    _showProvinces = !_showProvinces;
                  });
                },
                child: _showProvinces
                    ? Text('ປິດການເບິ່ງເປັນແຂວງ')
                    : Text('ກົດເບິ່ງເປັນແຂວງ')),
          ),
          _showProvinces ? _provinceList(provinceCases) : Container()
        ],
      ),
    );
  }

  Widget _provinceList(provinceCases) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: provinceCases.length,
        itemBuilder: (context, index) {
          return _provinceItem(provinceCases[index], index);
        });
  }

  Widget _provinceItem(Map<String, dynamic> itemData, index) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              child: Text(
                'ແຂວງ',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 100,
              child: Text(
                'ສະສົມ',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 100,
              child: Text(
                'ເພີ່ມໃຫມ່',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            // color: Colors.white.withOpacity(0.2),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 100, child: Text('${itemData['name']}')),
              Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text('${itemData['totalCases']}')),
              Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Text(
                    '${itemData['newCases']}',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          ),
        ));
  }

  Widget _numberBox(title, value, width, height, Color color, double fontSize) {
    return Container(
      padding: EdgeInsets.all(8),
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: color, fontSize: 18)),
          Text(value,
              style: TextStyle(
                  color: color,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold)),
          Container()
        ],
      ),
    );
  }
}
