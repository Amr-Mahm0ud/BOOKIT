import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/booking_controller.dart';
import 'package:movie_app/widgets/ticket_tile.dart';

class MyBooking extends GetView<BookingController> {
  const MyBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Obx(
          () {
            return controller.myTickets.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                    ),
                    child: controller.myTickets[0].selectedMovieName == null
                        ? Center(
                            child: Text(
                              'No Bookings',
                              style: Get.textTheme.headline4,
                            ),
                          )
                        : ListView(
                            physics: const BouncingScrollPhysics(),
                            children: controller.myTickets.map(
                              (ticket) {
                                return TicketTile(
                                  ticket: ticket,
                                );
                              },
                            ).toList(),
                          ),
                  );
          },
        ));
  }
}
