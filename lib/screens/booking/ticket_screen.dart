import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/ticket.dart';
import 'package:movie_app/screens/home/main_page.dart';

class TicketScreen extends StatelessWidget {
  final Ticket ticket;

  const TicketScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Get.offAll(() => MainPage());
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Awesome!',
                  style: Get.textTheme.headlineLarge!.copyWith(
                    color: Get.textTheme.titleLarge!.color,
                  ),
                ),
                Text('This is your ticket.', style: Get.textTheme.headline6),
                Container(
                  margin: EdgeInsets.all(Get.width * 0.05),
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: BorderRadius.circular(Get.width * 0.03),
                    border: Border.all(
                      color: Get.theme.dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Get.width * 0.025),
                              topRight: Radius.circular(Get.width * 0.025),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                ticket.moviePoster!,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Get.width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${ticket.selectedMovieName}',
                              style: Get.textTheme.headlineSmall,
                            ),
                            Text(
                              '${ticket.selectedType}',
                              style: Get.textTheme.headline5!
                                  .copyWith(color: Colors.grey),
                            ),
                            Divider(
                              color: Get.theme.dividerColor,
                              thickness: 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Booking ID:',
                                        style: Get.textTheme.headline6!
                                            .copyWith(
                                                color: Get.textTheme.headline4!
                                                    .color),
                                      ),
                                      Text(
                                        '${ticket.id}',
                                        style: Get.textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 25),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: Get.theme.dividerColor),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Get.theme.primaryColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            '${ticket.selectedDate!.split(' ')[0].split('-')[2]} ${(ticket.selectedDate!.split(' ')[0]).split('-')[1]} ${(ticket.selectedDate!.split(' ')[0]).split('-')[0]}',
                                            style: Get.textTheme.headline6!
                                                .copyWith(
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            '${ticket.selectedTime}',
                                            style: Get.textTheme.headline6,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.035),
                            buildInfo('Venue:', 'Laemmle Music Hall'),
                            buildInfo('Screen:', '2'),
                            buildInfo('Row:', getRow(ticket.selectedSeats!)),
                            buildInfo(
                                'Seats:', getSeats(ticket.selectedSeats!)),
                            buildInfo(
                                'Price:',
                                getPrice(
                                    ticket.selectedType, ticket.selectedTime)),
                            Divider(
                              color: Get.theme.dividerColor,
                              thickness: 2,
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Image.asset(
                                'assets/images/qrcode.png',
                                width: Get.width * 0.5,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Padding buildInfo(title, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            title,
            style: Get.textTheme.headline6!.copyWith(color: Colors.grey),
          ),
          const Spacer(),
          Text(
            value,
            style: Get.textTheme.headline6,
          ),
        ],
      ),
    );
  }

  getRow(seats) {
    final double row = int.parse(seats[0]) / 6;
    return row.ceil().toString();
  }

  getSeats(List<String> list) {
    final String seats = list.join(', ');
    return seats;
  }

  getPrice(String? selectedType, String? selectedTime) {
    int price = 10;
    if (selectedType == 'MX4D') {
      price = 40;
    } else if (selectedType == '3D') {
      price = 20;
    } else if (selectedType == 'IMAX') {
      price = 30;
    }
    if (selectedTime == '12:00 am') {
      price += 15;
    } else if (selectedTime == '9:00 pm') {
      price += 10;
    } else if (selectedTime == '6:00 pm') {
      price += 5;
    }
    return '$price EGP';
  }
}
