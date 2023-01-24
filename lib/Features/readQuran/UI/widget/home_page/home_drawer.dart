import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/providers.dart';





class HomeDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lan = ref.watch(languageProvider);
    return SafeArea(
      child: Drawer(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(AppLocalizations.of(context).language,
                  style: TextStyle(fontSize: 20)),
              Column(
                children: [
                  TextButton(
                    child: Text(AppLocalizations.of(context).kurdish),
                    onPressed: () {
                      ref.read(languageProvider).setLanguae(Locale("fa", ""));
                    },
                  ),
                  TextButton(
                    child: Text(AppLocalizations.of(context).arabic),
                    onPressed: () {
                      ref.read(languageProvider).setLanguae(Locale("ar", ""));
                    },
                  ),
                  TextButton(
                    child: Text(AppLocalizations.of(context).english),
                    onPressed: () {
                      ref.read(languageProvider).setLanguae(Locale("en", ""));
                    },
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
