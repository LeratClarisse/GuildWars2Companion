import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guildwars2_companion/core/utils/guild_wars_icons.dart';
import 'package:guildwars2_companion/core/widgets/accent.dart';
import 'package:guildwars2_companion/core/widgets/appbar.dart';
import 'package:guildwars2_companion/features/error/widgets/error.dart';
import 'package:guildwars2_companion/core/widgets/button.dart';
import 'package:guildwars2_companion/core/widgets/list_view.dart';
import 'package:guildwars2_companion/features/bank/bloc/bank_bloc.dart';
import 'package:guildwars2_companion/features/bank/pages/build_selection.dart';
import 'package:guildwars2_companion/features/bank/pages/generic_bank.dart';
import 'package:guildwars2_companion/features/bank/pages/material.dart';

class BankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CompanionAccent(
      lightColor: Colors.indigo,
      child: Scaffold(
        appBar: CompanionAppBar(
          title: 'Bank',
          color: Colors.indigo,
        ),
        body: BlocBuilder<BankBloc, BankState>(
          builder: (context, state) {
            if (state is ErrorBankState) {
              return Center(
                child: CompanionError(
                  title: 'the bank',
                  onTryAgain: () =>
                    BlocProvider.of<BankBloc>(context).add(LoadBankEvent()),
                ),
              );
            }

            if (state is LoadedBankState) {
              return RefreshIndicator(
                backgroundColor: Theme.of(context).accentColor,
                color: Theme.of(context).cardColor,
                onRefresh: () async {
                  BlocProvider.of<BankBloc>(context).add(LoadBankEvent());
                  await Future.delayed(Duration(milliseconds: 200), () {});
                },
                child: CompanionListView(
                  children: <Widget>[
                    if (state.bank != null)
                      CompanionButton(
                        color: Colors.green,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GenericBankPage(BankType.BANK),
                          ));
                        },
                        title: 'Bank',
                        leading: Icon(
                          FontAwesomeIcons.archive,
                          size: 36.0,
                          color: Colors.white,
                        ),
                      ),
                    if (state.materialCategories != null)
                      CompanionButton(
                        color: Colors.deepOrange,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MaterialBankPage(),
                          ));
                        },
                        title: 'Materials',
                        leading: Icon(
                          FontAwesomeIcons.th,
                          size: 36.0,
                          color: Colors.white,
                        ),
                      ),
                    if (state.inventory != null)
                      CompanionButton(
                        color: Colors.blue,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GenericBankPage(BankType.INVENTORY),
                          ));
                        },
                        title: 'Shared inventory',
                        leading: Icon(
                          GuildWarsIcons.inventory,
                          size: 48.0,
                          color: Colors.white,
                        ),
                      ),
                    if (state.builds != null)
                      CompanionButton(
                        color: Colors.purple,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BankBuildSelectionPage(),
                          ));
                        },
                        title: 'Build storage',
                        leading: Icon(
                          FontAwesomeIcons.hammer,
                          size: 36.0,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
