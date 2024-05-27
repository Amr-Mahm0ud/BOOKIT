import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/booking/ticket_screen.dart';
import 'package:movie_app/widgets/welcome/button.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/booking_controller.dart';
import '../../models/ticket.dart';

class BookingScreen extends StatefulWidget {
  final Movie movie;
  const BookingScreen({super.key, required this.movie});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late Ticket ticket;
  List<dynamic>? bookedSeats = [];

  bool isLoading = false;

  @override
  void initState() {
    ticket = Ticket(
      selectedDate: DateTime.now().toString(),
      selectedTime: Ticket().times.keys.toList()[0],
      selectedType: Ticket().types.keys.toList()[0],
    );
    getBookedSeats();
    super.initState();
  }

  Future getBookedSeats() async {
    return await FirebaseFirestore.instance
        .collection('seats')
        .doc(widget.movie.id.toString())
        .collection('tickets')
        .get()
        .then((value) {
      bookedSeats = [];
      for (var seat in value.docs) {
        if (seat.data()['date'].toString().split(' ')[0] ==
                ticket.selectedDate!.split(' ')[0] &&
            seat.data()['time'] == ticket.selectedTime &&
            seat.data()['type'] == ticket.selectedType) {
          bookedSeats!.addAll(seat.data()['seatsIDs']);
          ticket.seats.forEach((seatID, seat) {
            if (bookedSeats!.contains(seatID)) {
              ticket.seats[seatID] = false;
            }
          });

          if (ticket.selectedSeats != null && !isLoading) {
            ticket.selectedSeats!
                .removeWhere((seatID) => bookedSeats!.contains(seatID));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(widget.movie.title!),
      ),
      body: FutureBuilder(
        future: getBookedSeats(),
        builder: (_, snapshot) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: Get.height * 0.025,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available In',
                    style: Get.textTheme.titleLarge!
                        .copyWith(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 5),
                  buildDottedContainer(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ticket.types.keys
                        .map((type) => _buildType(
                            ticket.types.keys.toList().indexOf(type)))
                        .toList(),
                  )),
                  SizedBox(height: Get.height * 0.03),
                  Text(
                    'Date',
                    style: Get.textTheme.titleLarge!
                        .copyWith(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 5),
                  buildDottedContainer(buildDateTimeLine()),
                  SizedBox(height: Get.height * 0.03),
                  Text(
                    'Time',
                    style: Get.textTheme.titleLarge!
                        .copyWith(color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 5),
                  buildDottedContainer(buildTimeLine()),
                  SizedBox(height: Get.height * 0.05),
                  Container(
                    width: Get.width * 0.9,
                    height: Get.height * 0.01,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Get.width * 0.05),
                        topRight: Radius.circular(Get.width * 0.05),
                      ),
                      color: Colors.blueGrey[400],
                      boxShadow: [
                        BoxShadow(
                          color: Get.theme.primaryColor.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: const Offset(0, 9),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.025),
                  buildSeats(),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Button(
                          label: 'Confirm',
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            ticket.selectedMovieId = widget.movie.id;
                            ticket.selectedMovieName = widget.movie.title;
                            ticket.moviePoster = widget.movie.backdropPath;
                            if (AuthController.firebaseUser.value != null) {
                              ticket.userID =
                                  AuthController.firebaseUser.value!.uid;
                            } else {
                              ticket.userID =
                                  AuthController.googleSignInAccount.value!.id;
                            }
                            if (ticket.selectedSeats != null) {
                              await BookingController()
                                  .bookSeat(ticket)
                                  .then((value) {
                                if (value != null) {
                                  ticket.id = value;
                                  Get.off(() => TicketScreen(ticket: ticket));
                                }
                              });
                            } else {
                              Get.snackbar(
                                'Failed!',
                                'You must select one seat at least',
                                backgroundColor:
                                    Get.theme.colorScheme.error.withOpacity(0.5),
                                colorText: Colors.white,
                              );
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  GridView buildSeats() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.05,
        vertical: Get.height * 0.03,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 15,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: ticket.seats.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: !bookedSeats!.contains(ticket.seats.keys.toList()[index])
              ? () {
                  setState(() {
                    ticket.seats[ticket.seats.keys.toList()[index]] =
                        !ticket.seats[ticket.seats.keys.toList()[index]]!;
                    ticket.selectedSeats = ticket.seats.keys
                        .where((seat) => ticket.seats[seat] == true)
                        .toList();
                  });
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/chair.png',
                color: bookedSeats!.contains(ticket.seats.keys.toList()[index])
                    ? Get.theme.primaryColor.withOpacity(0.5)
                    : ticket.seats.values.toList()[index]
                        ? Get.theme.primaryColor
                        : Colors.blueGrey[400],
              ),
            ),
          ),
        );
      },
    );
  }

  DottedBorder buildDottedContainer(child) {
    return DottedBorder(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      color: Colors.blueGrey,
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
      dashPattern: const [5, 5],
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      child: child,
    );
  }

  Widget _buildType(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ticket.types.forEach((key, value) {
            ticket.types[key] = false;
            ticket.types[ticket.types.keys.toList()[index]] = true;
            ticket.selectedType = ticket.types.keys.toList()[index];
          });
        });
      },
      child: Container(
        padding: EdgeInsets.all(Get.width * 0.025),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ticket.types.values.toList()[index]
              ? Get.theme.primaryColor
              : Get.theme.scaffoldBackgroundColor,
        ),
        child: Text(ticket.types.keys.toList()[index],
            style: Get.textTheme.headlineSmall!.copyWith(
                color: ticket.types.values.toList()[index]
                    ? Colors.white
                    : Get.textTheme.headlineSmall!.color)),
      ),
    );
  }

  Widget buildDateTimeLine() {
    return DatePicker(
      DateTime.now(),
      dateTextStyle: context.textTheme.headlineSmall!,
      dayTextStyle: context.textTheme.bodyLarge!,
      monthTextStyle: const TextStyle(fontSize: 0),
      initialSelectedDate: DateTime.now(),
      onDateChange: (newDate) {
        setState(() {
          ticket.selectedDate = newDate.toString();
        });
      },
      selectionColor: context.theme.primaryColor,
      daysCount: 10,
    );
  }

  buildTimeLine() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ticket.times.keys.map(
          (time) {
            int index = ticket.times.keys.toList().indexOf(time);
            return GestureDetector(
              onTap: () {
                setState(() {
                  ticket.times.forEach((key, value) {
                    ticket.times[key] = false;
                    ticket.times[ticket.times.keys.toList()[index]] = true;
                    ticket.selectedTime = ticket.times.keys.toList()[index];
                  });
                });
              },
              child: Container(
                padding: EdgeInsets.all(Get.width * 0.025),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ticket.times.values.toList()[index]
                      ? Get.theme.primaryColor
                      : Get.theme.scaffoldBackgroundColor,
                ),
                child: Text(ticket.times.keys.toList()[index],
                    style: Get.textTheme.headlineSmall!.copyWith(
                        color: ticket.times.values.toList()[index]
                            ? Colors.white
                            : Get.textTheme.headlineSmall!.color)),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
