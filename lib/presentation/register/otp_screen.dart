// import 'package:flutter/material.dart';

// class ScreenOtpForm extends StatelessWidget {
//   const ScreenOtpForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           SizedBox(
//             height: 64,
//             width: 68,
//             child: TextFormField(
//               autofocus: true,
//               keyboardType: TextInputType.number,
//               maxLength: 1,
//               onSaved: (pin1) {},
//               onChanged: (value) {
//                 if (value.length == 1) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               style: Theme.of(context).textTheme.titleLarge,
//               textAlign: TextAlign.center,
//               decoration: customOtpBoxdecoration(),
//             ),
//           ),
//           SizedBox(
//             height: 64,
//             width: 68,
//             child: TextFormField(
//               autofocus: true,
//               keyboardType: TextInputType.number,
//               maxLength: 1,
//               onSaved: (pin2) {},
//               onChanged: (value) {
//                 if (value.length == 1) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               style: Theme.of(context).textTheme.titleLarge,
//               textAlign: TextAlign.center,
//               decoration: customOtpBoxdecoration(),
//             ),
//           ),
//           SizedBox(
//             height: 64,
//             width: 68,
//             child: TextFormField(
//               autofocus: true,
//               keyboardType: TextInputType.number,
//               maxLength: 1,
//               onSaved: (pin3) {},
//               onChanged: (value) {
//                 if (value.length == 1) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               style: Theme.of(context).textTheme.titleLarge,
//               textAlign: TextAlign.center,
//               decoration: customOtpBoxdecoration(),
//             ),
//           ),
//           SizedBox(
//             height: 64,
//             width: 68,
//             child: TextFormField(
//               autofocus: true,
//               keyboardType: TextInputType.number,
//               maxLength: 1,
//               onSaved: (pin4) {},
//               onChanged: (value) {
//                 if (value.length == 1) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               style: Theme.of(context).textTheme.titleLarge,
//               textAlign: TextAlign.center,
//               decoration: customOtpBoxdecoration(),
//             ),
//           )
//         ],
//       ),
//     );
//   }
