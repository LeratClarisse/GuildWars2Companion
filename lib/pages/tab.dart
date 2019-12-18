import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guildwars2_companion/blocs/account/bloc.dart';
import 'package:guildwars2_companion/pages/token.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  int _currentIndex = 0;

  final List<TabEntry> _tabs = [
    TabEntry(null, "Home", Icons.home, Colors.red),
    TabEntry(null, "Test", Icons.vpn_key, Colors.blue),
    TabEntry(null, "Hmm", Icons.person, Colors.green),
  ];
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.light
    ));

    return BlocListener<AccountBloc, AccountState>(
      condition: (previous, current) => current is UnauthenticatedState,
      listener: (BuildContext context, state) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => TokenPage()));
      },
      child: BlocBuilder<AccountBloc, AccountState>(
        condition: (previous, current) => current is LoadingAccountState || current is AuthenticatedState,
        builder: (BuildContext context, state) {
          if (state is LoadingAccountState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return _buildTabPage(context, state);
        },
      ),
    );
  }

  Widget _buildTabPage(BuildContext context, AuthenticatedState authenticatedState) {
    return Scaffold(
      body: Center(child: Text('Welcome ${authenticatedState.account.name}')),
      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        currentIndex: _currentIndex,
        opacity: 1,
        hasInk: true,
        inkColor: Color.fromRGBO(0, 0, 0, .15),
        onTap: (index) => setState(() => _currentIndex = index),
        items: _tabs.map((t) =>
          BubbleBottomBarItem(
            icon: Icon(
              t.icon,
              color: t.color,
            ),
            activeIcon: Icon(
              t.icon,
              color: Colors.white,
            ),
            title: Text(
              t.title,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            backgroundColor: t.color
          )
        ).toList(),
      ),
    );
  }
}

class TabEntry {
  Widget widget;
  String title;
  IconData icon;
  Color color;

  TabEntry(Widget widget, String title, IconData icon, Color color) {
    this.widget = widget;
    this.title = title;
    this.icon = icon;
    this.color = color;
  }
}