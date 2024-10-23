import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/apps/theme_custom.dart';
import 'package:news/models/category_model.dart';
import 'package:news/provider/setting_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    context.read<SettingsProvider>().initAddList();
    _categoriesFuture = context.read<SettingsProvider>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeCustom.lightTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Setting Page'),
        ),
        body: Stack(
          children: [
            FutureBuilder(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  List<CategoryModel> categories =
                      snapshot.data as List<CategoryModel>;

                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 1,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color:
                              Colors.primaries[index % Colors.primaries.length],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Consumer<SettingsProvider>(
                          builder: (_, provider, __) {
                            return CheckboxListTile(
                              checkboxShape: const CircleBorder(),
                              activeColor: Colors.white,
                              checkColor: Colors.white,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                categories[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              value: provider.listSubmitCategories
                                  .contains(categories[index].id),
                              onChanged: (newValue) {
                                provider
                                    .handleClickCategory(categories[index].id);
                              },
                              controlAffinity: ListTileControlAffinity.trailing,
                            );
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                return const Center(child: Text('No categories available.'));
              },
            ),
            Positioned(
              bottom: 30,
              left: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  context.read<SettingsProvider>().sumbmitForm();
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Text(
                    'Submit',
                    style: GoogleFonts.actor(
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                      color: const Color(0xffFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
