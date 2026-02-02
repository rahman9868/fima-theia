import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'domain/entity/attendance_event_type.dart';
import 'presentation/work_calendar_controller.dart';

class AttendanceDetailPage extends StatelessWidget {
  final DateTime date;

  const AttendanceDetailPage({super.key, required this.date});

  Widget _rowLabelValue(String label, Widget value, {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w400)),
          Expanded(child: Align(alignment: Alignment.centerRight, child: value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final controller = Get.find<WorkCalendarController>();
    final attendance = controller.attendances[date];
    // Mock detail data
    final statusLabel = (attendance?.status.label ?? 'Pending');
    final statusColor = _eventColor(attendance?.status ?? AttendanceEventType.pending);
    final approvalName = '18248 - ARIS DWI RANTO';
    final timeStr = '13:04:17';
    final locationStr = 'Jl. Tol Tahi Bonar Simatupang No.Kav.15, RT.4/RW.1, Lb. Bulus, Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12440, Indonesia';
    final pictureAsset = 'assets/sample_face_blur.png'; // Replace with real
    final faceRecognized = true;
    final fingerprintVerified = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Report'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18.0),
        children: [
          Row(
            children: [
              Expanded(
                child: _rowLabelValue('Status',
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(statusLabel, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Need Approval From',
                style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(approvalName, style: const TextStyle(fontSize: 18)),
            ],
          ),
          _rowLabelValue('Date', Text(DateFormat('yyyy-MM-dd').format(date), style: const TextStyle(fontSize: 18))),
          _rowLabelValue('Clock-Out Time', Text(timeStr, style: const TextStyle(fontSize: 18))),
          const SizedBox(height: 8),
          _rowLabelValue(
            'Location',
            Row(children:[
              const Icon(Icons.location_on, color: Colors.red, size: 20),
              Expanded(child: Text(locationStr, style: const TextStyle(fontSize: 15, color: Colors.black54), maxLines: 3))
            ]),
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          const SizedBox(height: 18),
          const Text('Picture', style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          Container(
            color: Colors.black12,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 180,
                  child: Image.asset(
                    pictureAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 60)),
                  ),
                ),
                Row(
                  children: const [
                    Icon(Icons.verified, color: Colors.green, size: 22),
                    SizedBox(width: 6),
                    Expanded(child: Text('Face Recognized', style: TextStyle(fontSize: 16))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Fingerprint', style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          Column(
            children: [
              const Icon(Icons.fingerprint, color: Colors.green, size: 64),
              Row(
                children: const [
                  Icon(Icons.verified, color: Colors.green, size: 22),
                  SizedBox(width: 6),
                  Expanded(child: Text('Fingerprint Verified', style: TextStyle(fontSize: 16))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Color _eventColor(AttendanceEventType type) {
  switch (type) {
    case AttendanceEventType.late:
      return Colors.yellow;
    case AttendanceEventType.present:
      return Colors.green;
    case AttendanceEventType.pending:
      return Colors.orange;
    case AttendanceEventType.leave:
      return Colors.blue;
    case AttendanceEventType.businessTrip:
      return Colors.purple;
    case AttendanceEventType.working:
      return Colors.white;
    case AttendanceEventType.absent:
      return Colors.red;
    case AttendanceEventType.unknown:
    default:
      return Colors.grey;
  }
}
