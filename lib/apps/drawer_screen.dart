import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/pages/favourite/favourite_page.dart';
import 'package:news/pages/settings/setting_page.dart';
import 'package:news/pages/viewed/viewed_page.dart';
import 'package:news/provider/favourite_provider.dart';
import 'package:news/provider/sport_provider.dart';
import 'package:news/provider/viewed_provider.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              Color(0xff22CFFE),
              Color(0xff3DA2F2),
              Color(0xff005BEA),
            ])),
        child: Center(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Image.asset('assets/image/Ellipse.png'),
              const SizedBox(height: 10),
              Text(
                'App Tin Tức',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 32,
                  color: const Color(0xffFFFFFF),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 67),
              ListTile(
                title: Text(
                  'Trang chủ',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: const Color(0xfffffffff),
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {},
              ),
              const SizedBox(height: 28),
              ListTile(
                title: Text(
                  'Yêu thích',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: const Color(0xfffffffff),
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  context.read<FavouriteProvider>();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FavouritePage()));
                },
              ),
              const SizedBox(height: 28),
              ListTile(
                title: Text(
                  'Đã xem',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: const Color(0xfffffffff),
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  context.read<ViewedProvider>();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ViewedPage()));
                },
              ),
              const SizedBox(height: 28),
              ListTile(
                title: Text(
                  'Setting',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: const Color(0xfffffffff),
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  context
                      .read<SportProvider>()
                      .keyHome
                      .currentState!
                      .closeDrawer();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SettingPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
