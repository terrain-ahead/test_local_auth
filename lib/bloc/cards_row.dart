import 'dart:async';
import 'package:test_local_auth/repo/get_cards_with_authorization.dart';
import 'package:rxdart/subjects.dart';
import 'package:test_local_auth/model/card_model.dart';

enum Row { ON_HOLD, IN_PROGRESS, NEEDS_REVIEW, APPROVED }

class RowSwitch {
  StreamController _OnHoldController = BehaviorSubject<List<Cards>>();
  Stream<List<Cards>> get onHoldStream => _OnHoldController.stream;
  Sink get onHoldSink => _OnHoldController.sink;

  StreamController _InProgressController = BehaviorSubject<List<Cards>>();
  Stream<List<Cards>> get inProgressStream => _InProgressController.stream;
  Sink get inProgresSink => _InProgressController.sink;

  StreamController _NeedsReviewController = BehaviorSubject<List<Cards>>();
  Stream<List<Cards>> get needsReviewStream => _NeedsReviewController.stream;
  Sink get needsReviewSink => _NeedsReviewController.sink;

  StreamController _ApprovedController = BehaviorSubject<List<Cards>>();
  Stream<List<Cards>> get approvedStream => _ApprovedController.stream;
  Sink get approvedSink => _ApprovedController.sink;

  final List<Cards> defaultCard = <Cards>[
    Cards(id: '1', seq_num: '1', row: '1', text: '1')
  ];

  void getCard(int row) {
    List<Cards> cardsRow = List<Cards>();
    List<Cards> cards = loginAndOut.cards;
    print(cards);
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].row == row.toString()) {
        cardsRow.add(cards[i]);
      }
    }
    switch (row) {
      case 0:
        {
          onHoldSink.add(cardsRow);
        }
        break;
      case 1:
        {
          inProgresSink.add(cardsRow);
        }
        break;
      case 2:
        {
          needsReviewSink.add(cardsRow);
        }
        break;
      case 3:
        {
          approvedSink.add(cardsRow);
        }
        break;
      default:
        {}
        break;
    }
  }

  close() {
    _OnHoldController?.close();
    _InProgressController?.close();
    _NeedsReviewController?.close();
    _ApprovedController?.close();
  }
}

final RowSwitch rowSwitch = RowSwitch();
