import 'package:flutter/material.dart';
import 'package:robu/themes/app_theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class AlumniPage extends StatefulWidget {
  const AlumniPage({
    super.key,
  });

  @override
  State<AlumniPage> createState() => _AlumniPageState();
}

class _AlumniPageState extends State<AlumniPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  List<AlumniListItem> pdfs = [
    AlumniListItem(
      title: "2019-2020",
      link: "https://bracurobu.com/docs/panel/2019-2020.pdf",
      height: 850,
    ),
    AlumniListItem(
      title: "2020-2021",
      link: "https://bracurobu.com/docs/panel/2020-2021.pdf",
      height: 3180,
    ),
    AlumniListItem(
      title: "2021-2023",
      link: "https://bracurobu.com/docs/panel/2021-2023.pdf",
      height: 3500,
    ),
    AlumniListItem(
      title: "2023-2024",
      link: "https://bracurobu.com/docs/panel/2023-2024.pdf",
      height: 3550,
    ),
    AlumniListItem(
      title: "2024-2025",
      link: "https://bracurobu.com/docs/panel/2024-2025.pdf",
      height: 3500,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text("Alumni", style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // body: SfPdfViewer.asset(
      //   'assets/pdf/robu_panel.pdf',
      //   key: _pdfViewerKey,
      //   enableTextSelection: false,
      //   canShowScrollStatus: false,
      //   canShowScrollHead: false,
      //   canShowPageLoadingIndicator: false,
      //   pageSpacing: 0,
      // ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: pdfs.length,
        itemBuilder: (_, index) {
          return ExpansionTile(
            title: Text(
              pdfs[index].title,
              style: AppTheme.headline,
            ),
            children: [
              SizedBox(
                height: pdfs[index].height,
                child: SfPdfViewer.network(
                  pdfs[index].link,
                  key: _pdfViewerKey,
                  enableTextSelection: false,
                  canShowScrollStatus: false,
                  canShowScrollHead: false,
                  canShowPageLoadingIndicator: false,
                  pageSpacing: 0,
                ),
              ),
            ],
          );
        },
      ),

      // ListView(
      //   children: [
      //     ExpansionTile(
      //       title: Text(
      //         "2023-2024",
      //         style: AppTheme.headline,
      //       ),
      //       children: [
      //         SizedBox(
      //           height: 900,
      //           child: SfPdfViewer.network(
      //             'https://bracurobu.com/docs/robu_panel.pdf',
      //             key: _pdfViewerKey,
      //             enableTextSelection: false,
      //             canShowScrollStatus: false,
      //             canShowScrollHead: false,
      //             canShowPageLoadingIndicator: false,
      //             pageSpacing: 0,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),

      //'https://bracurobu.com/docs/robu_panel.pdf',
    );
  }
}

class AlumniListItem {
  String title;
  String link;
  double height;

  AlumniListItem({
    required this.title,
    required this.link,
    required this.height,
  });
}
