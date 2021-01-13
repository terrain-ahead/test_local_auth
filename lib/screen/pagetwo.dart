import 'package:flutter/material.dart';
import 'package:test_local_auth/bloc/cards_row.dart';
import 'package:test_local_auth/elements/elements.dart';
import 'package:test_local_auth/model/card_model.dart';
import 'package:test_local_auth/repo/get_cards_with_authorization.dart';
import 'package:test_local_auth/style/styles.dart';

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    rowSwitch.getCard(0);
    rowSwitch.getCard(1);
    rowSwitch.getCard(2);
    rowSwitch.getCard(3);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: primaryTheme,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            leading: null,
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  fillColor: Colors.teal,
                  child: Icon(Icons.arrow_back),
                  onPressed: () async {
                    await loginAndOut.LogOut(context);
                  },
                ),
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "On hold",
                ),
                Tab(
                  text: "In progress",
                ),
                Tab(
                  text: "Needs review",
                ),
                Tab(
                  text: "Approved",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StreamBuilder(
                  stream: rowSwitch.onHoldStream,
                  initialData: rowSwitch.defaultCard,
                  builder: (context, snapshot) {
                    return CardRev(
                      items: snapshot.data,
                    );
                  }),
              StreamBuilder(
                  stream: rowSwitch.inProgressStream,
                  initialData: rowSwitch.defaultCard,
                  builder: (context, snapshot) {
                    return CardRev(
                      items: snapshot.data,
                    );
                  }),
              StreamBuilder(
                  stream: rowSwitch.needsReviewStream,
                  initialData: rowSwitch.defaultCard,
                  builder: (context, snapshot) {
                    return CardRev(
                      items: snapshot.data,
                    );
                  }),
              StreamBuilder(
                  stream: rowSwitch.approvedStream,
                  initialData: rowSwitch.defaultCard,
                  builder: (context, snapshot) {
                    return CardRev(
                      items: snapshot.data,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class CardRev extends StatelessWidget {
  final List<Cards> items;
  CardRev({this.items});

  List<Card> card = List<Card>();

  @override
  Widget build(BuildContext context) {
    card = Populate(items);
    print(items.length);
    int len = card.length;
    return Container(
        padding: EdgeInsets.all(4),
        child: ListView.builder(
          itemCount: len,
          itemBuilder: (context, index) {
            return card[index];
          },
        ));
  }
}
