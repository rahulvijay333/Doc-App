//-----------------------------booking initiate object -required
class BookingDetails {
  final String doctorID;
  final String dateID;
  final String slotID;
  final String startTime;
  final String endTime;
  final String? paymentid;
  final String? orderID;
  final int? fees;
  final String date;

  BookingDetails(
      {required this.doctorID,
      required this.dateID,
      required this.slotID,
      required this.startTime,
      required this.endTime,
      required this.date,
      this.paymentid,
      this.orderID,
      required this.fees});
}
