import 'package:flutter/material.dart';

class AdminPageMenu extends StatelessWidget {
  const AdminPageMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: GridView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminPageMenu()));
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple[100],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "View/edit profile",
                        style: TextStyle(color: Colors.white, fontSize: 30),
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
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightBlue[100],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.group,
                        size: 30,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Contact us",
                        style: TextStyle(color: Colors.white, fontSize: 30),
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
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.pink[50],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.group,
                        size: 30,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Notifications",
                        style: TextStyle(color: Colors.white, fontSize: 30),
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
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.pink[50],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        size: 30,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Settings",
                        style: TextStyle(color: Colors.white, fontSize: 30),
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
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.pink[50],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.group,
                        size: 30,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 30),
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
              childAspectRatio: 12,
            ),
          ),
        ),
      ),
    );
  }
}
