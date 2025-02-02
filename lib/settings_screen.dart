import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zomato_theme_switcher/extensions.dart';
import 'package:zomato_theme_switcher/squircle.dart';
import 'package:zomato_theme_switcher/theme_switcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher(
      builder: (context, changeTheme, theme) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: switch (theme.brightness) {
                  Brightness.light => Icon(CupertinoIcons.moon_stars_fill),
                  Brightness.dark => Icon(CupertinoIcons.sun_max_fill),
                },
                onPressed: changeTheme,
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Column(
                spacing: 20,
                children: [
                  _UserDetailsCard(),
                  _ActionTile(
                    icon: Icons.sync,
                    title: "App update available",
                  ),
                  _ActionTile(
                    icon: Icons.person_outline,
                    title: "Your profile",
                  ),
                  _ActionTile(
                    icon: Icons.color_lens_outlined,
                    title: "Appearance",
                  ),
                  _ActionTile(
                    icon: Icons.star_border_rounded,
                    title: "Your rating",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Squircle(
      radius: 44,
      child: Container(
        padding: EdgeInsets.all(12),
        color: context.colorScheme.surface,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.scaffoldBackgroundColor,
              ),
              child: Icon(icon, size: 20),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyLarge?.copyWith(
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 16),
            Icon(CupertinoIcons.chevron_right, size: 16),
          ],
        ),
      ),
    );
  }
}

class _UserDetailsCard extends StatelessWidget {
  const _UserDetailsCard();

  @override
  Widget build(BuildContext context) {
    final goldColor = Color.fromRGBO(242, 218, 175, 1);

    return Squircle(
      radius: 44,
      child: Container(
        color: context.colorScheme.surface,
        child: Column(
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                spacing: 20,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: context.colorScheme.surface,
                    foregroundImage: NetworkImage(
                      "https://i.ytimg.com/vi/0WvKJhwea1U/maxresdefault.jpg",
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ALVISH",
                          style: context.textTheme.headlineMedium?.merge(
                            GoogleFonts.ibmPlexSans(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          "alvishramani.dev@gmail.com",
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "View activity",
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: context.theme.primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.arrow_right,
                              size: 22,
                              color: context.theme.primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              color: Color.fromRGBO(24, 23, 28, 1),
              child: Row(
                children: [
                  Text(
                    "Join Zomato Gold",
                    style: context.textTheme.bodyLarge?.merge(
                      GoogleFonts.lexend(
                        color: goldColor,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(CupertinoIcons.chevron_right, color: goldColor),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
