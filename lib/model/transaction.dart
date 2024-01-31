class TransactionModel {
  String id;
  double amount;
  String from;
  String to;
  String sentDate;
  String note;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.from,
    required this.to,
    required this.sentDate,
    required this.note,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: json['amount'].toDouble(),
      from: json['from'],
      to: json['to'],
      sentDate: json['sentDate'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'from': from,
      'to': to,
      'sentDate': sentDate,
      'note': note,
    };
  }
}
