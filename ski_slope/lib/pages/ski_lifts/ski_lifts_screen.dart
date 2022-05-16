import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/pages/ski_lifts/ski_lifts_bloc.dart';
import 'package:ski_slope/pages/ski_lifts/ski_lifts_item.dart';
import 'package:ski_slope/pages/tickets/tickets_screen.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/navigation.dart';
import 'package:ski_slope/widgets/empty_page.dart';
import 'package:ski_slope/widgets/menu_items_divider.dart';
import 'package:ski_slope/widgets/refresh_list.dart';

class SkiLiftsScreen extends StatelessWidget {
  SkiLiftsScreen({Key? key}) : super(key: key) {
    BlocProvider.getBloc<SkiLiftsBloc>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SkiLiftsBloc>(
      builder: (context, bloc) {
        final state = bloc.state;
        final skiLifts = state.skiLifts;

        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ErrorState) {
          return EmptyPage(
            title: context.text.emptyHere,
            subtitle: context.text.loadingFail,
          );
        }

        if (skiLifts.isEmpty) {
          return EmptyPage(
            title: context.text.emptyHere,
            subtitle: context.text.emptySkiLiftsSubtitle,
          );
        }

        return RefreshList(
          isRefreshing: bloc.state is LoadingState,
          onRefresh: bloc.load,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.listVerticalPadding),
            itemCount: bloc.state.skiLifts.length,
            separatorBuilder: (context, index) => const MenuItemsDivider(),
            itemBuilder: (context, index) {
              final skiLift = bloc.state.skiLifts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.menuItemsPadding),
                child: SkiLiftsItem(
                  name: skiLift.name,
                  description: skiLift.description,
                  skiRunLength: skiLift.skiRunLength,
                  onTap: () => navigateToPage(
                    context,
                    builder: (context) => TicketScreen(title: skiLift.name),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
