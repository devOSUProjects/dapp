class JournalEntryFields {
  String title;
  String body;
  DateTime dateTime;
  double rating;

  JournalEntryFields({this.title, this.body, this.dateTime, this.rating});


  String toString() {
    return 'Title: $title, Body: $body, Time: $dateTime, Rating: $rating';
  }
}