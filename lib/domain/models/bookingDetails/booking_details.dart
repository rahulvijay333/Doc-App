class BookingDetails {
  final String doctorID;
  final String dateID;
  final String slotID;
  final String startDate;
  final String endTime;
  final String? paymentid;
  final String? orderID;

  BookingDetails(
      {required this.doctorID,
      required this.dateID,
      required this.slotID,
      required this.startDate,
      required this.endTime,
      this.paymentid,
      this.orderID});
}
