import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_location_app/controllers/auth_controller.dart';
import 'package:live_location_app/ui/screens/login/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Divider(
                color: Theme.of(context).colorScheme.primary,
                endIndent: 20,
                indent: 20,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    minVerticalPadding: 5,
                    onTap: () {
                      authController.signOut();
                      Get.off(() => LoginScreen());
                    },
                    title: Text(
                      "Logout",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
