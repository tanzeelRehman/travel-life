//TODO: DELETE THIS FILE

// import 'package:flutter/material.dart';
// import 'package:gradient_borders/box_borders/gradient_box_border.dart';

// //! Custom Radiobutton selected Value
// String selectedValue = "Riding";

// class CategoryDialog extends StatefulWidget {
//   @override
//   State<CategoryDialog> createState() => _CategoryDialogState();
// }

// class _CategoryDialogState extends State<CategoryDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff212643),
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//           child: Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.7,
//                 width: MediaQuery.of(context).size.width,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                 decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(25),
//                       topRight: Radius.circular(25),
//                     ),
//                     color: Color(0xff777c88)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Category",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     categoryRow(context, "Riding Gear", "Riding"),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     categoryRow(context, "Saftet Gear", "Saftey"),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     categoryRow(context, "Maintenence", "Maintenence"),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     categoryRow(context, "Performance", "Performance"),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Row categoryRow(BuildContext context, String title, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(vertical: 0),
//           height: 50,
//           alignment: Alignment.centerLeft,
//           padding: const EdgeInsets.only(left: 12),
//           width: MediaQuery.of(context).size.width * 0.6,
//           decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.black.withOpacity(.4),
//               ),
//               borderRadius: BorderRadius.circular(12)),
//           child: Text(
//             title,
//             style: const TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//         CustomRadioButton(
//           selectedValue: selectedValue,
//           value: title,
//           isActive: selectedValue == value,
//           ontap: () {
//             setState(() {
//               selectedValue = value;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
// //! WIDGETS ================================================>
// //?---------------------------------------------------------

// class CustomRadioButton extends StatefulWidget {
//   final String value;
//   final String selectedValue;
//   final Function() ontap;
//   final bool isActive;
//   const CustomRadioButton({
//     required this.value,
//     required this.ontap,
//     required this.selectedValue,
//     required this.isActive,
//   });

//   @override
//   State<CustomRadioButton> createState() => _CustomRadioButtonState();
// }

// class _CustomRadioButtonState extends State<CustomRadioButton> {
//   @override
//   Widget build(BuildContext context) {
//     // checkActiveOrNot();
//     return GestureDetector(
//       onTap: widget.ontap,
//       child: SizedBox(
//         height: 50,
//         width: 50,
//         child: Stack(
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: Container(
//                 height: 38,
//                 width: 38,
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: widget.isActive
//                         ? const LinearGradient(
//                             colors: [Color(0xff38acea), Color(0xff4378ee)])
//                         : const LinearGradient(
//                             colors: [Color(0xff404755), Color(0xff4a5160)])),
//               ),
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Container(
//                 height: 45,
//                 width: 45,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: GradientBoxBorder(
//                     gradient: widget.isActive
//                         ? const LinearGradient(
//                             colors: [Color(0xff38acea), Color(0xff4378ee)])
//                         : const LinearGradient(
//                             colors: [Color(0xff404755), Color(0xff4a5160)]),
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
