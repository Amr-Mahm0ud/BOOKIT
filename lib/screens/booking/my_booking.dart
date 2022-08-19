import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/booking_controller.dart';
import 'package:movie_app/screens/booking/ticket_screen.dart';

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
                            children: controller.myTickets.map(
                              (ticket) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.off(
                                      () => TicketScreen(ticket: ticket),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.02,
                                        ),
                                        child: AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: Material(
                                            elevation: 20,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            shadowColor: Get.isDarkMode
                                                ? Get.theme.primaryColor
                                                    .withOpacity(0.3)
                                                : Get.theme.shadowColor,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      ticket.moviePoster!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        ticket.selectedMovieName!,
                                        style: Get.textTheme.headline5!,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${ticket.selectedDate!.split(' ')[0]} | ${ticket.selectedTime}'),
                                          DateTime.parse(
                                            ticket.selectedDate!.split(' ')[0],
                                          ).isAtSameMomentAs(
                                            DateTime.parse(
                                              DateTime.now()
                                                  .toString()
                                                  .split(' ')[0],
                                            ),
                                          )
                                              ? const Text(
                                                  'Today',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )
                                              : DateTime.parse(
                                                          ticket.selectedDate!)
                                                      .isBefore(DateTime.now())
                                                  ? Text(
                                                      'Expired',
                                                      style: TextStyle(
                                                          color: Get.theme
                                                              .primaryColor),
                                                    )
                                                  : const Text(
                                                      'UpComing',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                  );
          },
        ));
  }
}
