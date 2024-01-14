import 'package:firebase_app/components/constant.dart';
import 'package:firebase_app/components/custom_button.dart';
import 'package:firebase_app/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color componentColor() {
    Color backgroundColor;
    var currentTheme = Theme.of(context);
    if (currentTheme.brightness == Brightness.light) {
      backgroundColor = secondaryColor;
    } else {
      backgroundColor = primaryColor;
    }
    return backgroundColor;
  }

  Color cekBackground() {
    Color backgroundColor;
    var currentTheme = Theme.of(context);
    if (currentTheme.brightness == Brightness.dark) {
      backgroundColor = secondaryColor;
    } else {
      backgroundColor = primaryColor;
    }
    return backgroundColor;
  }

  String cekLogo() {
    String logo;
    var currentTheme = Theme.of(context);
    if (currentTheme.brightness == Brightness.light) {
      logo = 'assets/logo_light.png';
    } else {
      logo = 'assets/logo_dark.png';
    }
    return logo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 30,
                width: 30,
                child: Image.asset(cekLogo())),
            Text(
              'Movies & Books',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: cekBackground(),
                  fontSize: 25),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                    (route) => true);
              },
              icon: Icon(
                LineIcons.bars,
                color: cekBackground(),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // banner
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/banner.jpg',
                      ),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.centerLeft
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black]
                    ),
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                padding: EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // message
                        Text(
                          'Promo Buku 50%',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: componentColor(),
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InsideButton(
                          fungsi: () {},
                          textButton: 'Redeem',
                          icon: LineIcons.arrowRight,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage(
                    //     'assets/banner.jpg',
                    //   ),
                    //   fit: BoxFit.fitWidth,
                    //   alignment: Alignment.centerLeft
                    // ),
                    gradient: LinearGradient(
                      
                      colors: [Color.fromARGB(255, 255, 181, 34), Colors.transparent]
                    ),
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                padding: EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // message
                        Text(
                          'Promo Buku 50%',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: componentColor(),
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InsideButton(
                          fungsi: () {},
                          textButton: 'Redeem',
                          icon: LineIcons.arrowRight,
                        )
                      ],
                    ),
                    Icon(
                      LineIcons.photoVideo,
                      color: componentColor(),
                      size: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
          // GridView.builder(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: crossAxisCount
          //   ), 
          //   itemBuilder: (context, index)
          // )
        ],
      ),
    );
  }
}
