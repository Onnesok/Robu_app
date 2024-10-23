import 'dart:async';
import 'package:flutter/material.dart';
import 'lists.dart'; // Make sure to import your list file

class CategoryListView extends StatefulWidget {
  const CategoryListView({required this.callBack, super.key});

  final Function() callBack;

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final ScrollController scrollController;
  late final Timer timer;
  final double itemWidth = 280; // width of each item

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animationController.forward();

    scrollController = ScrollController();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (scrollController.hasClients) {
        double maxScrollExtent = scrollController.position.maxScrollExtent;
        double currentScrollPosition = scrollController.position.pixels;
        double newPosition = currentScrollPosition + itemWidth-100;  /// here 100 disi for animation last porjonto nite

        if (newPosition > maxScrollExtent) {
          newPosition = 0;
        }

        scrollController.animateTo(newPosition,
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    timer.cancel();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: SizedBox(
        height: 134,
        width: double.infinity,
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.only(right: 16, left: 16),
                itemCount: Category.categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = Category.categoryList.length > 10
                      ? 10
                      : Category.categoryList.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));

                  return CategoryView(
                    category: Category.categoryList[index],
                    animation: animation,
                    animationController: animationController,
                    callback: () {
                      widget.callBack();
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({
    required this.category,
    required this.animationController,
    required this.animation,
    required this.callback,
    super.key,
  });

  final VoidCallback callback;
  final Category category;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, _) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: GestureDetector(
              onTap: () {
                if (category.title == 'banner1') {
                  // Navigator.push(
                  // context,
                  // MaterialPageRoute(builder: (context) => robotics_projects()),
                  // );
                } else if (category.title == 'banner2') {
                  // Navigator.push(
                  // context,
                  // MaterialPageRoute(builder: (context) => coding_projects()),
                  // );
                } else if (category.title == 'banner3') {
                  // Navigator.push(
                  // context,
                  // MaterialPageRoute(builder: (context) => hardware_projects()),
                  // );
                } else if (category.title == 'banner4') {
                  // Navigator.push(
                  // context,
                  // MaterialPageRoute(builder: (context) => robu_projects()),
                  // );
                }
              },
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(category.imagePath),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
