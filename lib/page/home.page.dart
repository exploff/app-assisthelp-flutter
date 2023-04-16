import 'package:app_assisthelp/bloc/authentication/authentication.bloc.dart';
import 'package:app_assisthelp/bloc/children/children.bloc.dart';
import 'package:app_assisthelp/model/children.model.dart';
import 'package:app_assisthelp/page/planning.page.dart';
import 'package:app_assisthelp/repository/auth.repository.dart';
import 'package:app_assisthelp/repository/children.repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:app_assisthelp/page/profil.page.dart';
import 'package:app_assisthelp/page/children.page.dart';

import '../bloc/user/user.bloc.dart';
import '../repository/user.repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  final UserRepository userRepository = UserRepository();
  final AuthRepository authRepository = AuthRepository();
  final ChildrenRepository childrenRepository = ChildrenRepository();

  List<Widget> _buildScreens() {
    return [const Profil(), const ChildrenPage(), const Planning()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profil"),
        activeColorPrimary: Colors.blue[300]!,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.child_friendly),
        title: ("Enfants"),
        activeColorPrimary: Colors.blue[300]!,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.edit_calendar),
        title: ("Planning"),
        activeColorPrimary: Colors.blue[300]!,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assist\'Help'),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(LoggedOutEvent());
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ChildrenBloc>(
            create: (context) {
              print("BlocProvider : ChildrenBloc");
              return ChildrenBloc(
                  userRepository: userRepository,
                  authRepository: authRepository,
                  childrenRepository: childrenRepository)
                ..add(const ChildrensFetchEvent());
            },
          ),
          BlocProvider<UserBloc>(
            create: (context) {
              return UserBloc(
                  userRepository: userRepository,
                  authRepository: authRepository)
                ..add(const UserFetchEvent());
            },
          ),
        ],
        child: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style1, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}
