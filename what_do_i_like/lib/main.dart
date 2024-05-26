import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:what_do_i_like/ui/screens/welcome.dart';
import 'package:what_do_i_like/ui/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/env/.env');
  return runApp(const WhatDoILikeApp());
}

class WhatDoILikeApp extends StatelessWidget {
  const WhatDoILikeApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'What Do I Like?',
        themeMode: ThemeMode.system,
        theme: WhatDoILikeTheme.light,
        darkTheme: WhatDoILikeTheme.dark,
        home: const Welcome(),
      );
}
