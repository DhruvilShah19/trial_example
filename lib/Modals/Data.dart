class Contact {
  Contact(
      {this.documentId,
      this.name,
      this.amount,
      this.deleted,
      this.radiobtn,
      this.done,
      this.date,
      this.uid});

  String documentId;
  String name;
  String amount;
  bool deleted;
  String radiobtn;
  bool done;
  String date;
  String uid;

  Contact.fromMap(Map<String, dynamic> map)
      : this.documentId = map['document'],
        this.name = map['name'],
        this.amount = map['amount'],
        this.deleted = map['deleted'],
        this.radiobtn = map['radiobtn'],
        this.done = map['done'],
        this.date = map['date'],
        this.uid = map['uid'];
  Map<String, dynamic> toMap() {
    return {
      'document': this.documentId,
      'name': this.name,
      'amount': this.amount,
      'deleted': this.deleted,
      'radiobtn': this.radiobtn,
      'done': this.done,
      'date': this.date,
      'uid': this.uid
    };
  }
}
