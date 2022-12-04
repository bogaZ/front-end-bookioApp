import 'package:flutter/widgets.dart';
import '../models/rating.dart';

class RatingProvider with ChangeNotifier {
  // DATA DUMMY //! RATING DARI SETIAP STUDIO
  List<Rating> _dataRating = [
    // Rating('0', '0', 'budi', 4, '12 agustus 2022', 'baik sekali'),
    Rating('0', '1', 'rani', 4, '12 agustus 2022', 'baik sekali'),
    Rating('0', '1', 'andi', 2, '12 januari 2022', 'buruk sekali'),
    Rating('0', '1', 'Buni', 4, '12 agustus 2022', 'baik sekali'),
    Rating('1', '0', 'Sasa', 2, '12 januari 2022', 'buruk sekali'),
    Rating('1', '0', 'Erni', 4, '12 agustus 2022', 'baik sekali'),
    Rating('1', '1', 'Leni', 2, '12 januari 2022', 'buruk sekali')
  ];

  List<Rating> get dataRating => _dataRating;
}
