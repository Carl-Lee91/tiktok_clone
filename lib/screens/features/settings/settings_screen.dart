import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/screens/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/screens/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations.override(
      context: context,
      locale: const Locale("ko"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: ListView(
              children: [
                SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).muted,
                  onChanged: (value) {
                    ref.read(playbackConfigProvider.notifier).setMuted(value);
                  },
                  title: const Text("Auto Mute"),
                  subtitle: const Text("Videos will be muted by default."),
                ),
                SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).darkmode,
                  onChanged: (value) {
                    ref
                        .read(playbackConfigProvider.notifier)
                        .setDarkmode(value);
                  },
                  title: const Text("Switch theme"),
                  subtitle:
                      const Text("Screen will be changed dark/white theme."),
                ),
                SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).autoplay,
                  onChanged: (value) {
                    ref
                        .read(playbackConfigProvider.notifier)
                        .setAutoplay(value);
                  },
                  title: const Text("Autoplay"),
                  subtitle:
                      const Text("Videos will start playing automatically.."),
                ),
                CheckboxListTile(
                  activeColor: Colors.black,
                  value: false,
                  onChanged: (value) {},
                  title: const Text("Marketing emails"),
                  subtitle: const Text("We won't spam you."),
                ),
                ListTile(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                    );
                    if (kDebugMode) {
                      print(date);
                    }
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (kDebugMode) {
                      print(time);
                    }
                    final booking = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            appBarTheme: const AppBarTheme(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (kDebugMode) {
                      print(booking);
                    }
                  },
                  title: const Text("What is your birthday?"),
                  subtitle: const Text("I need to know!"),
                ),
                ListTile(
                  title: const Text("Log out (iOS)"),
                  textColor: Colors.red,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text("Are you sure?"),
                        content: const Text("Plx dont go"),
                        actions: [
                          CupertinoDialogAction(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("No"),
                          ),
                          CupertinoDialogAction(
                            onPressed: () {
                              ref.read(authRepo).signOut();
                              context.go("/");
                            },
                            isDestructiveAction: true,
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Log out (Android)"),
                  textColor: Colors.red,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const FaIcon(FontAwesomeIcons.skull),
                        title: const Text("Are you sure?"),
                        content: const Text("Plx dont go"),
                        actions: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const FaIcon(FontAwesomeIcons.car),
                          ),
                          TextButton(
                            onPressed: () {
                              ref.read(authRepo).signOut();
                              context.go("/");
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Log out (iOS / Bottom)"),
                  textColor: Colors.red,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: const Text("Are you sure?"),
                        message: const Text("Please don't go"),
                        actions: [
                          CupertinoActionSheetAction(
                            isDefaultAction: true,
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Not log out"),
                          ),
                          CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            onPressed: () {
                              ref.read(authRepo).signOut();
                              context.go("/");
                            },
                            child: const Text("Yes plz"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const AboutListTile(
                  applicationVersion: "1.0",
                  applicationLegalese: "Don't copy me.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
