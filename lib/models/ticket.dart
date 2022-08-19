class Ticket {
  final Map<String, bool> times = {
    '12:00 pm': true,
    '3:00 pm': false,
    '6:00 pm': false,
    '9:00 pm': false,
    '12:00 am': false,
  };
  final Map<String, bool> types = {
    '2D': true,
    '3D': false,
    'IMAX': false,
    'MX4D': false,
  };
  final Map<String, bool> seats = {
    '1': false,
    '2': false,
    '3': false,
    '4': false,
    '5': false,
    '6': false,
    '7': false,
    '8': false,
    '9': false,
    '10': false,
    '11': false,
    '12': false,
    '13': false,
    '14': false,
    '15': false,
    '16': false,
    '17': false,
    '18': false,
    '19': false,
    '20': false,
    '21': false,
    '22': false,
    '23': false,
    '24': false,
    '25': false,
    '26': false,
    '27': false,
    '28': false,
    '29': false,
    '30': false,
    '31': false,
    '32': false,
    '33': false,
    '34': false,
    '35': false,
    '36': false,
  };

  String? selectedDate;
  String? selectedTime;
  String? selectedType;
  List<String>? selectedSeats;
  int? selectedMovieId;
  String? selectedMovieName;
  String? userID;
  String? moviePoster;
  String? id;
  Ticket({
    this.selectedDate,
    this.selectedTime,
    this.selectedType,
    this.selectedSeats,
    this.selectedMovieId,
    this.selectedMovieName,
    this.moviePoster,
    this.userID,
    this.id,
  });

  static Ticket fromJson(Map<String, dynamic> map, id) {
    return Ticket(
      selectedDate: map['date'],
      selectedTime: map['time'],
      selectedType: map['type'],
      selectedSeats: List<String>.from(map['seatsIDs']),
      selectedMovieId: map['movieID'],
      selectedMovieName: map['movieName'],
      moviePoster: map['moviePoster'],
      userID: map['userID'],
      id: id,
    );
  }
}
