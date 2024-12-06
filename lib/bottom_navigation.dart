import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpods_learning/home.dart';
import 'package:riverpods_learning/move_list.dart';
import 'package:riverpods_learning/movie_detail.dart';
import 'package:riverpods_learning/setting.dart';


final bottomNavProvider = StateProvider<int>((ref) => 0);

class BottomNav extends ConsumerWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);  // Monitor state

    final List<Widget> _pages = [
      Home(),
      MovieListScreen(),
      
      Setting(),

    ];

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => Scaffold(
        
        body: _pages[selectedIndex], 
        bottomNavigationBar: BottomNavigationBar(
          useLegacyColorScheme: true,
          backgroundColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: (index) {
            ref.read(bottomNavProvider.notifier).state = index;
          },
          elevation: 10,
          items: const <BottomNavigationBarItem>[
            
            BottomNavigationBarItem(
              
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}