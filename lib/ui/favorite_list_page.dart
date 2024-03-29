import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/db/database_helper.dart';
import '../provider/database_provider.dart';
import '../provider/result_state.dart';
import '../widgets/platform_widget.dart';
import '../widgets/popup_menu_item.dart';
import 'detail_page.dart';

class FavoriteList extends StatelessWidget {
  static const routeName = '/favorite_page';

  static const String favoriteTitle = 'Favorite';

  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child:
          PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                'assets/images/mobile-game.png',
                fit: BoxFit.contain,
                height: 35,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 15.0, left: 5.0),
                  child: Text(favoriteTitle,
                      style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 139, 139, 139), fontWeight: FontWeight.bold)))
            ],
          ),
          centerTitle: true,
          actions: const <Widget>[
            Padding(padding: EdgeInsets.all(8.0), child: PopupMenu()),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 4, 255),
                    Color.fromARGB(255, 16, 242, 223)
                  ],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                ),
                image: DecorationImage(
                    image: AssetImage('assets/images/patern.jpg'),
                    opacity: 0.5,
                    fit: BoxFit.none,
                    repeat: ImageRepeat.repeat)),
          ),
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(favoriteTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.hasData) {
        return ListView.builder(
          itemCount: provider.favorite.length,
          itemBuilder: (context, index) {
            var favoriteGame = provider.favorite[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailPage.routeName,
                    arguments: favoriteGame.id);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 8),
                padding: const EdgeInsets.all(5),
                width: 200,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 230, 228, 228),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        favoriteGame.backgroundImage,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 8),
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.values[5],
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favoriteGame.name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            favoriteGame.genre,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Color.fromARGB(190, 0, 0, 0),
                                fontSize: 15.0),
                          ),
                          Row(
                            children: [
                              Text(
                                favoriteGame.rating.toString(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromARGB(190, 0, 0, 0),
                                    fontSize: 15.0)
                              ),
                              const SizedBox(height: 5),
                              const Icon(
                                  Icons.star,
                                  color: Colors.orangeAccent,
                                  size: 18,
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else if (provider.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Center(
          child: Material(
            child: Text(provider.message),
          ),
        );
      }
    });
  }
}
