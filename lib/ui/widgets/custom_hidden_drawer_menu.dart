import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';

import 'custom_hidden_menu.dart';

class CustomHiddenDrawerMenu extends StatelessWidget {
  /// List item menu and respective screens
  final List<ScreenHiddenDrawer>? screens;

  /// position initial item selected in menu( sart in 0)
  final int? initPositionSelected;

  /// Decocator that allows us to add backgroud in the content(color)
  final Color? backgroundColorContent;

  //AppBar
  /// enable auto title in appbar with menu item name
  final bool? whithAutoTittleName;

  /// Style of the title in appbar
  final TextStyle? styleAutoTittleName;

  /// change backgroundColor of the AppBar
  final Color? backgroundColorAppBar;

  ///Change elevation of the AppBar
  final double? elevationAppBar;

  ///Change leading of the AppBar
  final Widget? leadingAppBar;

  /// Add actions in the AppBar
  final List<Widget>? actionsAppBar;

  /// Set custom widget in tittleAppBar
  final Widget? tittleAppBar;

  /// Decide whether title is centered or not
  final bool? isTitleCentered;

  //Menu
  ///==== Custom Widget Allowed
  final Widget? backgroundMenu;

  /// that allows us to add backgroud in the menu(color)
  final Color? backgroundColorMenu;

  /// that allows us to add shadow above menu items
  final bool? enableShadowItensMenu;

  /// enable and disable open and close with gesture
  final bool? isDraggable;

  final Curve? curveAnimation;

  final double? slidePercent;

  /// percent the content should scale vertically
  final double? verticalScalePercent;

  /// radius applied to the content when active
  final double? contentCornerRadius;

  /// enable animation Scale
  final bool? enableScaleAnimation;

  /// enable animation borderRadius
  final bool? enableCornerAnimation;

  final bool? disableAppBarDefault;

  final TypeOpen? typeOpen;

  CustomHiddenDrawerMenu({
    this.screens,
    this.initPositionSelected = 0,
    this.backgroundColorAppBar,
    this.elevationAppBar = 4.0,
    this.leadingAppBar = const Icon(Icons.menu),
    this.backgroundMenu,
    this.backgroundColorMenu,
    this.backgroundColorContent = Colors.white,
    this.whithAutoTittleName = true,
    this.styleAutoTittleName,
    this.actionsAppBar,
    this.tittleAppBar,
    this.isTitleCentered,
    this.enableShadowItensMenu = false,
    this.curveAnimation = Curves.decelerate,
    this.isDraggable = true,
    this.slidePercent = 80.0,
    this.verticalScalePercent = 80.0,
    this.contentCornerRadius = 10.0,
    this.enableScaleAnimation = true,
    this.enableCornerAnimation = true,
    this.disableAppBarDefault = false,
    this.typeOpen = TypeOpen.FROM_LEFT,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      isDraggable: isDraggable!,
      curveAnimation: curveAnimation!,
      slidePercent: slidePercent!,
      verticalScalePercent: verticalScalePercent!,
      contentCornerRadius: contentCornerRadius!,
      enableCornerAnimation: enableCornerAnimation!,
      enableScaleAnimation: enableScaleAnimation!,
      menu: buildMenu(),
      typeOpen: typeOpen!,
      initPositionSelected: initPositionSelected!,
      screenSelectedBuilder: (position, bloc) {
        // var actions = <Widget>[];
        // if (typeOpen == TypeOpen.FROM_RIGHT) {
        //   actions.add(IconButton(
        //       icon: iconMenuAppBar,
        //       onPressed: () {
        //         bloc.toggle();
        //       }));
        // }
        // if (actionsAppBar != null) {
        //   actions.addAll(actionsAppBar);
        // }

        return Scaffold(
          backgroundColor: backgroundColorContent,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: backgroundColorAppBar,
            elevation: elevationAppBar,
            title: getTittleAppBar(position),
            centerTitle: isTitleCentered,
            leading: _buildLeading(bloc),
            actions: actionsAppBar,
          ),
          body: screens![position].screen,
        );
      },
    );
  }

  Widget getTittleAppBar(int position) {
    if (tittleAppBar == null) {
      return whithAutoTittleName!
          ? Text(
              screens![position].itemMenu.name,
              style: styleAutoTittleName,
            )
          : Container();
    } else {
      return tittleAppBar!;
    }
  }

  Widget buildMenu() {
    var _itensMenu = <ItemHiddenMenu>[];

    screens?.forEach((item) {
      _itensMenu.add(item.itemMenu);
    });

    return CustomHiddenMenu(
      menuItems: _itensMenu,
      background: backgroundMenu!,
      backgroundColorMenu: backgroundColorMenu!,
      initPositionSelected: initPositionSelected!,
      enableShadowItensMenu: enableShadowItensMenu!,
      typeOpen: typeOpen!,
    );
  }

  Widget _buildLeading(SimpleHiddenDrawerController bloc) {
    if (typeOpen == TypeOpen.FROM_LEFT) {
      return IconButton(icon: leadingAppBar!, onPressed: () => bloc.toggle());
    } else {
      return SizedBox.shrink();
    }
  }

  ///==== maybe use this if needed =====
  // PreferredSizeWidget _getAppbar(
  //   int position,
  //   SimpleHiddenDrawerController bloc,
  // ) {
  //   if (disableAppBarDefault) return null;
  //   var actions = <Widget>[];
  //   if (typeOpen == TypeOpen.FROM_RIGHT) {
  //     actions.add(
  //       IconButton(
  //         icon: leadingAppBar,
  //         onPressed: () {
  //           bloc.toggle();
  //         },
  //       ),
  //     );
  //   }
  //   if (actionsAppBar != null) {
  //     actions.addAll(actionsAppBar);
  //   }
  //   return AppBar(
  //     backgroundColor: backgroundColorAppBar,
  //     elevation: elevationAppBar,
  //     title: getTittleAppBar(position),
  //     centerTitle: isTitleCentered,
  //     leading: _buildLeading(bloc),
  //     actions: actions,
  //   );
  // }
}
