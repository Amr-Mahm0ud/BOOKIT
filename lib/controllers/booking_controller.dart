import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/ticket.dart';
import 'auth/auth_controller.dart';

class BookingController extends GetxController {
  @override
  void onInit() {
    getMyTickets(
      AuthController.firebaseUser.value != null
          ? AuthController.firebaseUser.value!.uid
          : AuthController.googleSignInAccount.value!.id,
    );
    super.onInit();
  }

  RxList<Ticket> myTickets = <Ticket>[].obs;

  Future<String?> bookSeat(Ticket ticket) async {
    try {
      await FirebaseFirestore.instance
          .collection('seats')
          .doc(ticket.selectedMovieId.toString())
          .collection('tickets')
          .add({
        'date': ticket.selectedDate,
        'type': ticket.selectedType,
        'seatsIDs': ticket.selectedSeats,
        'time': ticket.selectedTime,
        'movieName': ticket.selectedMovieName,
        'userID': ticket.userID,
        'moviePoster': ticket.moviePoster,
        'movieID': ticket.selectedMovieId,
      }).then((value) async {
        ticket.id = value.id;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(ticket.userID)
            .collection('tickets')
            .doc(value.id)
            .set({
          'ticketID': FieldValue.arrayUnion([value.id]),
          'movieID': ticket.selectedMovieId,
        }).then(
          (value) {
            
          },
        );
      });
      return ticket.id;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
        colorText: Colors.white,
      );
      return null;
    }
  }

  Future<void> getMyTickets(String userID) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('tickets')
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            FirebaseFirestore.instance
                .collection('seats')
                .doc(element['movieID'].toString())
                .collection('tickets')
                .doc(element['ticketID'][0])
                .get()
                .then((value) {
              if (value.data() != null) {
                myTickets.add(Ticket.fromJson(value.data()!, value.id));
              }
            });
          }
        } else {
          myTickets.clear();
          myTickets.add(Ticket(selectedMovieName: null));
        }
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
  }
}
