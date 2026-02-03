import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'presentation/attendance_detail_controller.dart';

class AttendanceDetailPage extends StatefulWidget {
  final DateTime date;

  const AttendanceDetailPage({super.key, required this.date});

  @override
  State<AttendanceDetailPage> createState() => _AttendanceDetailPageState();
}

class _AttendanceDetailPageState extends State<AttendanceDetailPage> {
  final controller = Get.find<AttendanceDetailController>();

  @override
  void initState() {
    super.initState();
    controller.load(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Report'),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }
        final detail = controller.detail.value;
        if (detail == null) {
          return const Center(child: Text('No attendance data available.'));
        }

        final tabStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
        return DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Material(
                color: Colors.blue,
                child: TabBar(
                  tabs: [
                    Tab(child: Text('CLOCK-IN', style: tabStyle)),
                    Tab(child: Text('CLOCK-OUT', style: tabStyle)),
                  ],
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 2, color: Colors.white)),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildDetailTab(detail.clockIn, 'CLOCK-IN'),
                    _buildDetailTab(detail.clockOut, 'CLOCK-OUT'),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetailTab(Map<String, dynamic>? att, String type) {
    if (att == null || att['id'] == null) {
      return Center(child: Text('No $type data'));
    }

    final status = att['attApproval'] ?? att['attStatus'] ?? 'Pending';
    final statusColor = _approvalColor(status);
    final approvalList = att['eligibleApprovers'] as List?;
    String approvalInfo = '';
    if (approvalList != null && approvalList.isNotEmpty) {
      final p = approvalList.first;
      approvalInfo = '${p['employeeNo']} - ${p['employeeName']}';
    }

    final timeStr = att['time'] ?? '';
    final dateStr = timeStr.isNotEmpty ? timeStr.substring(0, 10) : '';
    final timeOnly = timeStr.isNotEmpty ? timeStr.substring(11, 19) : '';

    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      children: [
        Row(
          children: [
            Expanded(child: _blueLabel('Status')),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(status.toString().toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (approvalInfo.isNotEmpty)
          Row(
            children: [
              Expanded(child: _blueLabel('Need Approval From')),
              Text(approvalInfo, style: const TextStyle(fontSize: 16)),
            ],
          ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: _blueLabel('Date')),
            Text(dateStr, style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: _blueLabel('Clock-Out Time')),
            Text(timeOnly, style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 8),
        _blueLabel('Location'),
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.red, size: 20),
            const SizedBox(width: 6),
            Expanded(
                child: Text(att['address'] ?? '',
                    style: const TextStyle(fontSize: 15, color: Colors.black54))),
          ],
        ),
        const SizedBox(height: 12),
        _blueLabel('Picture'),
        const SizedBox(height: 6),
        Container(
          color: Colors.black12,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                height: 180,
                child: att['faceRecImageUrl'] != null
                    ? Image.network(
                        _getFullImage(att['faceRecImageUrl']),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.broken_image, size: 60)),
                      )
                    : const Center(child: Icon(Icons.broken_image, size: 60)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified,
                      color: att['faceRecIsValid'] == true ? Colors.green : Colors.grey,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      att['faceRecIsValid'] == true ? 'Face Recognized' : 'Face Not Recognized',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _blueLabel('Fingerprint'),
        const SizedBox(height: 6),
        Column(
          children: [
            Icon(
              Icons.fingerprint,
              color: att['fpIsValid'] == true ? Colors.green : Colors.grey,
              size: 64,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified,
                  color: att['fpIsValid'] == true ? Colors.green : Colors.grey,
                  size: 22,
                ),
                const SizedBox(width: 6),
                Text(
                  att['fpIsValid'] == true ? 'Fingerprint Verified' : 'Fingerprint Not Verified',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  Widget _blueLabel(String text) => Text(text,
      style: const TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w400));

  Color _approvalColor(String? status) {
    switch ((status ?? '').toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'APPROVED':
        return Colors.green;
      case 'REJECTED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getFullImage(String relPath) {
    if (relPath.startsWith('http')) return relPath;
    return 'https://wf.dev.neo-fusion.com/fira-api/$relPath';
  }
}