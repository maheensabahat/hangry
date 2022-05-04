class ReservationRequest {
  String status = 'pending';
  int seats;
  String time;
  int phone;
  DateTime date;
  String name;

  ReservationRequest(
      {required this.name,
      required this.phone,
      required this.time,
      required this.seats,
      required this.date});

  void approveRequest() {
    status = 'approved';
  }
}
