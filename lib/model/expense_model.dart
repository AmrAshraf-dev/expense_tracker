class ExpenseModel {
  int? id;
  String category;
  double amount;
  String date;
  String? imagePath;
  String? filePath;

  ExpenseModel({
    this.id,
    required this.category,
    required this.amount,
    required this.date,
    this.imagePath,
    this.filePath,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      category: map['category'],
      amount: map['amount'],
      date: map['date'],
      imagePath: map['imagePath'],
      filePath: map['filePath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date,
      'imagePath': imagePath,
      'filePath': filePath,
    };
  }
}
