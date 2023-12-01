class TopUpHistoryModel {
  final String email;
  final int quantity;
  final int hammersBefore;

  TopUpHistoryModel(
      {required this.hammersBefore,
      required this.email,
      required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'hammers_before': hammersBefore,
      'email': email,
      'quantity': quantity,
    };
  }
}
