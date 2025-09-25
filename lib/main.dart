import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_challenge/cubits/theme_cubit.dart';
import 'package:web_challenge/screens/gallery.dart';
import 'package:web_challenge/screens/profile.dart';
import 'package:web_challenge/screens/dashboard.dart';
import 'package:web_challenge/utils/singletones.dart';
import 'package:web_challenge/widgets/sidebar.dart';

void main() {
  runApp(BlocProvider(create: (_) => ThemeCubit(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final pages = const [DashboardPage(), GalleryPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Singletons.registerCubits(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Web Demo',
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              cardColor: Colors.grey[200],
              primaryColor: Colors.teal,
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.black87),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
              cardColor: Colors.grey[900],
              primaryColor: Colors.tealAccent,
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.white70),
              ),
            ),
            home: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 700) {
                  return Row(
                    children: [
                      SideBar(
                        selectedIndex: _selectedIndex,
                        onItemSelected: (index) {
                          setState(() => _selectedIndex = index);
                        },
                      ),
                      Expanded(child: pages[_selectedIndex]),
                    ],
                  );
                } else {
                  return Scaffold(
                    appBar: AppBar(title: const Text("Flutter Web Demo")),
                    drawer: Drawer(
                      child: SideBar(
                        selectedIndex: _selectedIndex,
                        onItemSelected: (index) {
                          setState(() => _selectedIndex = index);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    body: pages[_selectedIndex],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
