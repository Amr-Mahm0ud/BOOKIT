import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/ticket.dart';

import '../screens/booking/ticket_screen.dart';

class TicketTile extends StatelessWidget {
  final Ticket ticket;
  const TicketTile({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.off(
          () => TicketScreen(ticket: ticket),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02,
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(15),
                shadowColor: Get.isDarkMode
                    ? Get.theme.primaryColor.withOpacity(0.3)
                    : Get.theme.shadowColor,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(ticket.moviePoster!),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '${ticket.selectedDate!.split(' ')[0]} | ${ticket.selectedTime}'),
              DateTime.parse(
                ticket.selectedDate!.split(' ')[0],
              ).isAtSameMomentAs(
                DateTime.parse(
                  DateTime.now().toString().split(' ')[0],
                ),
              )
                  ? const Text(
                      'Today',
                      style: TextStyle(color: Colors.green),
                    )
                  : DateTime.parse(ticket.selectedDate!)
                          .isBefore(DateTime.now())
                      ? Text(
                          'Expired',
                          style: TextStyle(color: Get.theme.primaryColor),
                        )
                      : const Text(
                          'UpComing',
                          style: TextStyle(color: Colors.green),
                        ),
            ],
          ),
        ],
      ),
    );
  }
}
