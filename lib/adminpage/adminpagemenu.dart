import 'package:cbms/edit_user_profile.dart';
import 'package:flutter/material.dart';

class AdminPageMenu extends StatelessWidget {
  const AdminPageMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GridView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => editProfile()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 196, 161, 202),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "View/edit profile",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminPageMenu()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 129, 182, 207),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.group,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Contact us",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminPageMenu()));
                },
                child: Container(
                  
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 245, 179, 201),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.group,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Notifications",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminPageMenu()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 231, 201, 186),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Settings",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminPageMenu()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 233, 221, 167),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.group,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
            ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 40,
              childAspectRatio: 5,
            ),
          ),
        ),
      ),
    );
  }
}
