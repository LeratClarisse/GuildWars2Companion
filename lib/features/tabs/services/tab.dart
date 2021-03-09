import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guildwars2_companion/core/utils/guild_wars_icons.dart';
import 'package:guildwars2_companion/features/achievement/pages/progression.dart';
import 'package:guildwars2_companion/features/bank/pages/bank.dart';
import 'package:guildwars2_companion/features/character/pages/characters.dart';
import 'package:guildwars2_companion/features/home/pages/home.dart';
import 'package:guildwars2_companion/features/tabs/enums/tab_type.dart';
import 'package:guildwars2_companion/features/tabs/models/tab.dart';
import 'package:guildwars2_companion/features/trading_post/pages/trading_post.dart';

class TabService {
  List<TabEntry> getTabs(List<TabType> types) {
    return [
      _getHomeTab(),

      if (types.contains(TabType.CHARACTERS))
        _getCharactersTab(),
      
      if (types.contains(TabType.BANK))
        _getBankTab(),

      if (types.contains(TabType.TRADING))
        _getTradingTab(),

      _getProgressionTab()
    ];
  }

  TabEntry _getHomeTab() => TabEntry(HomePage(), "Home", FontAwesomeIcons.home, 20.0, Colors.red);
  TabEntry _getCharactersTab() => TabEntry(CharactersPage(), "Characters", GuildWarsIcons.hero, 24.0, Colors.blue);
  TabEntry _getBankTab() => TabEntry(BankPage(), "Bank", GuildWarsIcons.inventory, 24.0, Colors.indigo);
  TabEntry _getTradingTab() => TabEntry(TradingPostPage(), "Trading", FontAwesomeIcons.balanceScaleLeft, 20.0, Colors.green);
  TabEntry _getProgressionTab() => TabEntry(ProgressionPage(), "Progression", GuildWarsIcons.achievement, 24.0, Colors.orange);
}