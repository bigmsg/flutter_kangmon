

class User {
  final String mb_nick;
  final String mb_id;
  final String mb_hp;

  User({this.mb_nick, this.mb_id, this.mb_hp});
}


class Portfolio {
  final User user;
  final List<String> career;
  final List<String> imgUrl;

  Portfolio({this.user, this.career, this.imgUrl});
}


class Lesson {
  final User user;
  final Portfolio portfolio;
  final String subject;
  final String content;
  final int term;
  final int price;
  final String local;
  final String category;

  Lesson({this.user, this.portfolio, this.subject, this.content, this.term, this.price, this.local, this.category });
}