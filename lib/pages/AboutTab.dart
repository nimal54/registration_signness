import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slimy_card/slimy_card.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      body: StreamBuilder(
        initialData: false,
        stream: slimyCard.stream,
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.fromLTRB(90, 10, 50, 50),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    direction: Axis.horizontal,
                    children: [
                      const SizedBox(width: 60),
                      Center(
                          child: Text("Meet Our Team",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                  color: Colors.black54))),
                      Divider(),
                      Divider(color: Colors.transparent),
                      Container(
                          width: 200,
                          child: SlimyCard(
                            topCardWidget: topCardWidget(
                                (snapshot.data)
                                    ? 'assets/picAboutPage/jiril.jpeg'
                                    : 'assets/picAboutPage/jiril.jpeg',
                                "Jiril",
                                "CEO"),
                            bottomCardWidget: bottomCardWidget("CEO, Signness"),
                          )),
                      const SizedBox(width: 20, height: 20),
                      Container(
                          width: 200,
                          child: SlimyCard(
                            topCardWidget: topCardWidget(
                                (snapshot.data)
                                    ? 'assets/picAboutPage/nimal2.jpeg'
                                    : 'assets/picAboutPage/nimal1.jpeg',
                                "Nimal",
                                "Developer"),
                            bottomCardWidget: bottomCardWidget(
                                "Website Design & Development"),
                          )),
                      const SizedBox(width: 20, height: 20),
                      Container(
                          width: 200,
                          child: SlimyCard(
                            topCardWidget: topCardWidget(
                                (snapshot.data)
                                    ? 'assets/picAboutPage/mary.jpeg'
                                    : 'assets/picAboutPage/mary.jpeg',
                                "Mary Grace",
                                "Data Engineer"),
                            bottomCardWidget:
                                bottomCardWidget("Data Processing & Analysis"),
                          )),
                      const SizedBox(width: 20, height: 20),
                      Container(
                        width: 200,
                        child: SlimyCard(
                          topCardWidget: topCardWidget(
                              (snapshot.data)
                                  ? 'assets/picAboutPage/dona.jpeg'
                                  : 'assets/picAboutPage/dona.jpeg',
                              "Dona",
                              "Infra"),
                          bottomCardWidget:
                              bottomCardWidget("Technical Support"),
                        ),
                      ),
                      const SizedBox(width: 20, height: 20),
                      Container(
                        width: 200,
                        child: SlimyCard(
                          topCardWidget: topCardWidget(
                              (snapshot.data)
                                  ? 'assets/picAboutPage/sneha.jpeg'
                                  : 'assets/picAboutPage/sneha.jpeg',
                              "Sneha",
                              "Client executive"),
                          bottomCardWidget:
                              bottomCardWidget("Client Executive"),
                        ),
                      ),
                      const SizedBox(width: 20, height: 20),
                      Container(
                        width: 200,
                        child: SlimyCard(
                          topCardWidget: topCardWidget(
                              (snapshot.data)
                                  ? 'assets/picAboutPage/shyla.jpeg'
                                  : 'assets/picAboutPage/shyla.jpeg',
                              "Shyla",
                              "Client Executive"),
                          bottomCardWidget:
                              bottomCardWidget("Client Executive"),
                        ),
                      ),
                      const SizedBox(width: 20, height: 20),
                    ],
                  )));
        }),
      ),
    );
  }

  // This widget will be passed as Top Card's Widget.
  Widget topCardWidget(String imagePath, String _titleName, String _caption) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            image: DecorationImage(image: AssetImage(imagePath)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 3),
        Text(
          _titleName,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
        ),
        SizedBox(height: 1),
        Text(
          _caption,
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  // This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget(String _bottomContent) {
    return Text(
      _bottomContent,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }
}
