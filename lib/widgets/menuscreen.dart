import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/about_screen.dart';
import '../features/bookmark/presentation/screens/bookmark_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  Widget title(String text, BuildContext context, IconData icons) {
    var mediaQuery = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        left: mediaQuery.width * 0.05,
      ),
      child: Row(
        children: [
          FaIcon(
            icons,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget socialMedia(
      String url, IconData icon, String name, BuildContext context) {
    return TextButton(
      onPressed: () {
        _launch(url);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).iconTheme.color,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyText1?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: mediaQuery.width * 0.65,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: mediaQuery.height * 0.03),
                child: SizedBox(
                  width: mediaQuery.width * 0.5,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              const Divider(
                color: Colors.red,
                thickness: 1.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(BookmarkScreen.routeName);
                },
                child: title('Bookmark', context, Icons.bookmark),
              ),
              TextButton(
                  onPressed: () => null,
                  child: title('Rate US', context, Icons.star_rounded)),
              TextButton(
                  onPressed: () => null,
                  child: title('Help and Support', context, Icons.help)),
              TextButton(
                  onPressed: () => null,
                  child: title('Share Sanchar Dainik', context, Icons.share)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AboutScreen.routeName);
                  },
                  child: title('About US', context, Icons.article)),
              TextButton(
                  onPressed: () => null,
                  child:
                      title('Subscribe', context, Icons.subscriptions_rounded)),
              TextButton(
                  onPressed: () => null,
                  child: title('Update', context, Icons.update)),
              Padding(
                padding: EdgeInsets.only(
                  left: mediaQuery.width * 0.06,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Others',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.headline1!.color,
                      ),
                    ),
                    const Divider(
                      color: Colors.red,
                      thickness: 1,
                    ),
                    socialMedia('https://www.facebook.com',
                        FontAwesomeIcons.facebook, 'Facebook', context),
                    socialMedia('https://www.youtube.com',
                        FontAwesomeIcons.youtube, 'Youtube', context),
                    socialMedia('https://www.sanchardainik.com', Icons.web,
                        'Our Website', context),
                    socialMedia('https://www.twitter.com',
                        FontAwesomeIcons.twitter, 'Twitter', context),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: const [
                          Text(
                            'Powered BY:',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Text(
                              'BITS',
                              style: TextStyle(
                                color: Color.fromRGBO(
                                  0,
                                  74,
                                  153,
                                  1,
                                ),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_launch(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}
