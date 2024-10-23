import 'package:flutter/material.dart';
import 'package:news/apps/drawer_screen.dart';
import 'package:news/pages/home/widgets/home_category.dart';
import 'package:news/pages/search/search_page.dart';
import 'package:news/provider/setting_provider.dart';
import 'package:news/provider/sport_provider.dart';
import 'package:news/widgets/loading/home_loading.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<SportProvider>().keyHome,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFEBB4B),
              ),
              child: IconButton(
                onPressed: () {
                  context
                      .read<SportProvider>()
                      .keyHome
                      .currentState!
                      .openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffFEBB4B),
              ),
              child: InkWell(
                  onTap: () async {
                    await showSearch(
                      context: context,
                      delegate: SearchPage(),
                    );
                  },
                  child: const Icon(Icons.search)),
            ),
            //   Expanded(
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //       child: TextField(
            //         style: GoogleFonts.poppins(
            //           color: const Color(0xff020202),
            //           fontSize: 12,
            //           fontWeight: FontWeight.w400,
            //           letterSpacing: 0.5,
            //         ),
            //         decoration: InputDecoration(
            //           filled: true,
            //           fillColor: const Color(0xfff1f1f1),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(8),
            //             borderSide: BorderSide.none,
            //           ),
            //           hintText: "Search for Items",
            //           hintStyle: GoogleFonts.poppins(
            //             color: const Color(0xffb2b2b2),
            //             fontSize: 10,
            //             fontWeight: FontWeight.w400,
            //             letterSpacing: 0.5,
            //             decorationThickness: 6,
            //           ),
            //           prefixIcon: const Icon(Icons.search),
            //           prefixIconColor: Colors.black,
            //         ),
            //       ),
            //     ),
            //   ),
            // ],
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<SettingsProvider>(
          builder: (_, provider, ___) {
            return provider.isLoading
                ? const HomeLoading()
                : provider.listChooseSeting.isEmpty
                    ? const Column(
                        children: [
                          SizedBox(
                            height: 400,
                          ),
                          Center(
                            child: Text('No categories available.'),
                          ),
                        ],
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.listChooseSeting.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 20);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return HomeCategory(
                            idCategory: provider.listChooseSeting[index],
                          );
                        },
                      );
          },
        ),
      ),
    );
  }
}
