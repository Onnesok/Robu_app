class InfoBlock {
  InfoBlock({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;

  static List<InfoBlock> InfoList = <InfoBlock>[
    InfoBlock(
      imagePath: 'assets/ui/robot1.png',
      title: 'Basic of robotics',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    InfoBlock(
      imagePath: 'assets/ui/web.png',
      title: 'Events',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    InfoBlock(
      imagePath: 'assets/ui/blood_bank.png',
      title: 'Blood bank',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    InfoBlock(
      imagePath: 'assets/ui/panel.png',
      title: 'panel',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    InfoBlock(
      imagePath: 'assets/ui/search_members.png',
      title: 'Regestration',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    InfoBlock(
      imagePath: 'assets/ui/announcement.png',
      title: 'Announcements',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
    ),
    InfoBlock(
      imagePath: 'assets/ui/help.png',
      title: 'Alumni',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
    InfoBlock(
      imagePath: 'assets/ui/robu_logo.png',
      title: 'About Robu',
      lessonCount: 28,
      money: 208,
      rating: 4.9,
    ),
  ];
}

class Banner {
  Banner({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;


  static List<Banner> BannerList = <Banner>[
    Banner(
      imagePath: 'assets/banner/robosub.jpg',
      title: 'banner1',
      lessonCount: 15,
      money: 0,
      rating: 5,
    ),
    Banner(
      imagePath: 'assets/banner/test.jpg',
      title: 'Coding projects',
      lessonCount: 30,
      money: 0,
      rating: 5,
    ),
    Banner(
      imagePath: 'assets/banner/gallery.jpg',
      title: 'Hardware projects',
      lessonCount: 12,
      money: 0,
      rating: 5,
    ),
    Banner(
      imagePath: 'assets/banner/club_fair.jpg',
      title: 'Robu projects',
      lessonCount: 14,
      money: 0,
      rating: 5,
    ),
  ];
}


