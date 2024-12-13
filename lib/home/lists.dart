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
      imagePath: 'assets/ui/podcast.png',
      title: 'Robust',
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
      title: 'Registration',
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
      imagePath: 'assets/banner/space.jpg',
      title: 'space week',
      lessonCount: 15,
      money: 0,
      rating: 5,
    ),
    Banner(
      imagePath: 'assets/banner/recruitement.jpg',
      title: 'banner1',
      lessonCount: 15,
      money: 0,
      rating: 5,
    ),
    Banner(
      imagePath: 'assets/banner/pusti.jpg',
      title: 'banner2',
      lessonCount: 15,
      money: 0,
      rating: 5,
    ),
    Banner(
      imagePath: 'assets/banner/robosub.jpg',
      title: 'banner3',
      lessonCount: 15,
      money: 0,
      rating: 5,
    ),
    Banner(
      imagePath: 'assets/banner/test.jpg',
      title: 'banner4',
      lessonCount: 30,
      money: 0,
      rating: 5,
    ),
    Banner(
      imagePath: 'assets/banner/gallery.jpg',
      title: 'banner5',
      lessonCount: 12,
      money: 0,
      rating: 5,
    ),
    Banner(
      imagePath: 'assets/banner/club_fair.jpg',
      title: 'banner6',
      lessonCount: 14,
      money: 0,
      rating: 5,
    ),
  ];
}


