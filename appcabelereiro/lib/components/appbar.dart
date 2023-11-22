// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:appcabelereiro/core/services/auth_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AuthService _authService = AuthService();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      centerTitle: true,
      title: Icon(
        Icons.spa,
        size: 30,
        color: Colors.white,
      ),
      backgroundColor: Colors.black,
      elevation: 0,
      actions: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.grey.shade900,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Sair'),
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                _authService.logout();
              }
            },
          ),
        ),
      ],
    );
  }
}
