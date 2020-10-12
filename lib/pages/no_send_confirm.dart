import 'package:flutter/material.dart';

class NoSendConFirmPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoSendConfirmState();
  }
}

class NoSendConfirmState extends State<NoSendConFirmPage> {
  List<int> list;
  List<ExpandStateBean> expandStateList;

  @override
  void initState() {
    super.initState();
    list = new List();
    expandStateList = new List();
    for (int i = 0; i < 10; i++) {
      list.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("expansion panel list"),),
      body: SingleChildScrollView(
        child: ExpansionPanelList(// 点击

          expansionCallback: (index,bol){
            _setCurrentIndex(index,bol);
          },
          children: list.map((index){
            return ExpansionPanel(
                headerBuilder: (context,isExpanded){ //headerBuilder:头部   isExpanded是否打开
                  return ListTile(
                      title:Text('this is No.$index')
                  );
                },
                body: ListTile(
                  title: Text('expansion no.$index'),
                ),
                isExpanded: expandStateList[index].isOpen
            );
          }).toList(),
        ),
      ),
    );
  }

  _setCurrentIndex(int index, isExpand) {
    setState(() {
      expandStateList.forEach((item) {
        if (item.index == index) {
          item.isOpen = !isExpand;
        }
      });
    });
  }
}

class ExpandStateBean {
  var isOpen;
  var index;

  ExpandStateBean(this.index, this.isOpen);
}

