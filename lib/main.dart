import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:fludm/utils/utils.dart';
import 'package:fludm/widgets/sidebar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluDM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepPurple[100],
        fontFamily: 'Poppins',
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Sidebar(
            currentIndex: currentIndex,
            onTap: (index) {
              currentIndex = index;
              setState(() {});
            },
            start: Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                "FluDM",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ),
            items: [
              SidebarItem(
                icon: const Icon(LineAwesomeIcons.arrow_circle_down),
                label: 'All Downloads',
              ),
              SidebarItem(
                icon: const Icon(LineAwesomeIcons.download),
                label: 'Downloading',
              ),
              SidebarItem(
                icon: const Icon(LineAwesomeIcons.check_circle),
                label: 'Finished',
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentIndex != 2) ...[
                    Text(
                      "Downloading",
                      style: context.textTheme.headline5!
                          .copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                  if (currentIndex != 1) ...[
                    Text(
                      "Finished",
                      style: context.textTheme.headline5!
                          .copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
