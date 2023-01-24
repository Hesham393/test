import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/constant/constants.dart';
import '../../../domain/entity/surah.dart';
import '../../../providers/providers.dart';
import '../../bloc/ReadQuranBloc.dart';
import '../../bloc/Read_Quran_event.dart';
import '../../bloc/readQuranState.dart';

class QuickAccessList extends StatelessWidget {
  const QuickAccessList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<ReadQuranBloc>().add(AllSurahEvent());
      },
    );
    return SizedBox(
      height: 40,
      child: BlocBuilder<ReadQuranBloc, ReadQuranState>(
        builder: (context, state) {
          if (state is AllSurahState) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return QuickAccessItem(surah: state.allSurah[index]);
              },
              itemCount: state.allSurah.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}

class QuickAccessItem extends ConsumerWidget {
  final Surah surah;
  const QuickAccessItem({
    @required this.surah,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final language = ref.watch(languageProvider).getLocale.languageCode;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: atlanticGullColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            language == "en" ? surah.englishName : "${surah.name} ",
            style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
