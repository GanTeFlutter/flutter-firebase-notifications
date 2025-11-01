import 'package:flutter/material.dart';
import 'package:flutter_base_start/product/service/notification/bloc/notification_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<NotificationBloc>().add(
                  SendMessageEvent('Hello from HomeView!'),
                );
              },
              child: const Text('Send Notification Message'),
            ),
            const Text('HomeView'),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_base_start/product/service/services/firebase_fcm.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   String? lastMessageData;
//   String? lastMessageTitle;
//   String? lastMessageBody;
//   String? lastMessageTime;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadMessages();
//   }

//   Future<void> _loadMessages() async {
//     setState(() => isLoading = true);

//     try {
//       // ⭐ Direkt SharedPreferences kullanın
//       final prefs = await SharedPreferences.getInstance();

//       lastMessageData = prefs.getString(PrefKeys.lastMessageData);
//       lastMessageTitle = prefs.getString(PrefKeys.lastMessageTitle);
//       lastMessageBody = prefs.getString(PrefKeys.lastMessageBody);
//       lastMessageTime = prefs.getString(PrefKeys.lastMessageTime);

//       debugPrint('📖 ============ LOADING MESSAGES ============');
//       debugPrint('Data: $lastMessageData');
//       debugPrint('Title: $lastMessageTitle');
//       debugPrint('Body: $lastMessageBody');
//       debugPrint('Time: $lastMessageTime');
//       debugPrint('============================================');

//       // Tüm key'leri görmek için:
//       final allKeys = prefs.getKeys();
//       debugPrint('🔑 All SharedPreferences keys: $allKeys');
//     } catch (e) {
//       debugPrint('❌ Error loading messages: $e');
//     } finally {
//       if (mounted) {
//         setState(() => isLoading = false);
//       }
//     }
//   }

//   Future<void> _testSave() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(
//         PrefKeys.lastMessageTitle,
//         'Test Başlık ${DateTime.now().second}',
//       );
//       await prefs.setString(
//         PrefKeys.lastMessageBody,
//         'Test Gövde ${DateTime.now().second}',
//       );
//       await prefs.setString(PrefKeys.lastMessageData, '{test: true}');
//       await prefs.setString(
//         PrefKeys.lastMessageTime,
//         DateTime.now().toIso8601String(),
//       );

//       debugPrint('✅ Test data saved');
//       await _loadMessages();

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Test verisi kaydedildi!')),
//         );
//       }
//     } catch (e) {
//       debugPrint('❌ Test save error: $e');
//     }
//   }

//   Future<void> _clearMessages() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.remove(PrefKeys.lastMessageData);
//       await prefs.remove(PrefKeys.lastMessageTitle);
//       await prefs.remove(PrefKeys.lastMessageBody);
//       await prefs.remove(PrefKeys.lastMessageTime);

//       debugPrint('🗑️ Messages cleared');
//       await _loadMessages();

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Mesajlar temizlendi!')),
//         );
//       }
//     } catch (e) {
//       debugPrint('❌ Clear error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FCM Test'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _loadMessages,
//             tooltip: 'Yenile',
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 spacing: 16,
//                 children: [
//                   // Son Mesaj Kartı
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             '📬 Son Mesaj',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Divider(),
//                           _InfoRow(
//                             icon: Icons.data_object,
//                             label: 'Data',
//                             value: lastMessageData,
//                           ),
//                           _InfoRow(
//                             icon: Icons.title,
//                             label: 'Başlık',
//                             value: lastMessageTitle,
//                           ),
//                           _InfoRow(
//                             icon: Icons.message,
//                             label: 'Gövde',
//                             value: lastMessageBody,
//                           ),
//                           if (lastMessageTime != null)
//                             _InfoRow(
//                               icon: Icons.access_time,
//                               label: 'Zaman',
//                               value: lastMessageTime,
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   // Test Butonları
//                   ElevatedButton.icon(
//                     onPressed: _testSave,
//                     icon: const Icon(Icons.bug_report),
//                     label: const Text('Test Verisi Kaydet'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.all(16),
//                     ),
//                   ),

//                   ElevatedButton.icon(
//                     onPressed: _clearMessages,
//                     icon: const Icon(Icons.delete_sweep),
//                     label: const Text('Mesajları Temizle'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.all(16),
//                     ),
//                   ),

//                   // Bilgi Kartı
//                   Card(
//                     color: Colors.amber.shade50,
//                     child: const Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(Icons.info_outline, color: Colors.amber),
//                               SizedBox(width: 8),
//                               Text(
//                                 'Test Adımları',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 8),
//                           Text('1. "Test Verisi Kaydet" butonuna basın'),
//                           Text('2. Mesaj görünüyor mu kontrol edin'),
//                           Text("3. Firebase Console'dan mesaj gönderin"),
//                           Text('4. Uygulamayı kapatın (kill edin)'),
//                           Text("5. Firebase'den tekrar mesaj gönderin"),
//                           Text('6. Uygulamayı açın ve kontrol edin'),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

// class _InfoRow extends StatelessWidget {
//   const _InfoRow({
//     required this.icon,
//     required this.label,
//     required this.value,
//   });

//   final IconData icon;
//   final String label;
//   final String? value;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 20, color: Colors.grey.shade600),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 Text(
//                   value ?? 'Veri yok',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: value != null
//                         ? FontWeight.w500
//                         : FontWeight.normal,
//                     color: value != null ? Colors.black : Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
