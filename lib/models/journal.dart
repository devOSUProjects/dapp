import 'journal_entry.dart';
class Journal {
  List <JournalEntryFields> myJournal = List<JournalEntryFields>();

  Journal({this.myJournal});
  bool isEmpty() {
    if(myJournal.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  void addEntry(JournalEntryFields je) {
    this.myJournal.add(je);
  }
  void printJournal() {
    for(int i = 0; i < myJournal.length; i++) {
      print(myJournal[i].title);
      print(myJournal[i].body);
      print(myJournal[i].rating);
      print(myJournal[i].dateTime);
    }
  }

  List<Map> toMapList() {
    List<Map> temp = new List(10000);
    for(int i = 0; i < myJournal.length; i++) {
      temp[i] = {
        'title': myJournal[i].title,
        'body': myJournal[i].body,
        'date': myJournal[i].dateTime.toString(),
        'rating': myJournal[i].rating
      };
    }
    return temp;
  }
}
Journal fakeJournal() {
  Journal fake = Journal();
  DateTime now = DateTime.now();
  JournalEntryFields temp = JournalEntryFields(title: 'wasup', body: 'nm', dateTime: now, rating: 2);
  JournalEntryFields temp1 = JournalEntryFields(title: 'hehe', body: 'lol', dateTime: now, rating: 4);
  JournalEntryFields temp2 = JournalEntryFields(title: 'squirtle', body: 'lpika', dateTime: now, rating: 1);
  fake.addEntry(temp);
  fake.addEntry(temp1);
  fake.addEntry(temp2);
  return fake;
}