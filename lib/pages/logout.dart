// import 'package:dashboard/pages/login_page.dart';
// import 'package:flutter/material.dart';

// class LogoutPage extends StatelessWidget {
//   const LogoutPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Confirm Logout',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       color: Color(0xff4B70F5)),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   '_ Are you sure you want to logout ?',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Color(0xff4B70F5)),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const LoginPage()));
//                   },
//                   style: ButtonStyle(
//                       backgroundColor:
//                           WidgetStateProperty.all(const Color(0xff4B70F5))),
//                   child: const Text('OK'),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 0,
//             child: IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:dashboard/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dashboard/main.dart'; 

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  Future<void> _performLogout(BuildContext context) async {
    final dio = Dio();
    const apiUrl = 'http://localhost:8000/api/v1/dashboard/logout';

  
    final token = storage.getString('token');
    
    if (token == null || token.isEmpty) {
      print(' No token found in storage');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No authentication token found')),
      );
      return;
    }

    print(' Using token: ${token.substring(0, 10)}...'); 

    try {
      final response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', 
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      
      print(' Response Status: ${response.statusCode}');
      print(' Response Data: ${response.data}');

      if (response.statusCode == 200) {

        await storage.remove('token');
        print(' Token removed after successful logout');
        
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      } else {
        print(' Logout failed with status: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? 'Logout failed')),
        );
      }
    } on DioException catch (e) {
      print(' Dio Error: ${e.message}');
      print(' Response: ${e.response?.data}');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.response?.data['message'] ?? e.message}')),
      );
    } catch (e) {
      print(' Unexpected Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unexpected error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Confirm Logout',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xff4B70F5)),
                ),
                const SizedBox(height: 10),
                const Text(
                  '_ Are you sure you want to logout ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff4B70F5)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _performLogout(context),
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff4B70F5))),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}


























// import 'package:dashboard/pages/login_page.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http; // <-- لإرسال الطلب للسيرفر
// import 'dart:convert'; // <-- لتحويل الرد من JSON

// class LogoutPage extends StatelessWidget {
//   const LogoutPage({super.key});

//   /// دالة تنفيذ طلب الخروج
//   Future<void> _logout(BuildContext context) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:8000/api/v1/dashboard/logout'),
//         headers: {
//           'Content-Type': 'application/json',
//           // إذا السيرفر يحتاج توكن حطّه هنا
//           // 'Authorization': 'Bearer YOUR_TOKEN',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         // عرض رسالة من السيرفر
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(data["message"] ?? "Logout successful")),
  
//         );

//         // الانتقال لصفحة تسجيل الدخول وحذف كل المسارات السابقة
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginPage()),
//           (route) => false,
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Logout failed: ${response.statusCode}")),
//         );
//       }
//     } catch (e) {
//       // في حال صار خطأ بالاتصال
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Confirm Logout',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       color: Color(0xff4B70F5)),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   '_ Are you sure you want to logout ?',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Color(0xff4B70F5)),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () => _logout(context), // استدعاء API
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.all(
//                       const Color(0xff4B70F5),
//                     ),
//                   ),
//                   child: const Text('OK'),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 0,
//             child: IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
