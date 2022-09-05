import 'package:flutter/cupertino.dart';
import 'package:esikshya/models/quiz_models/quiz_model.dart';

//Category means the subject like mathematics, physics, chemistry
class Category {
  final String categoryName;
  final String description;
  final Color bgColor;
  final List<Question> questions;
  final String imgUrl;

  Category(this.categoryName, this.description, this.bgColor, this.questions,
      this.imgUrl);
}
