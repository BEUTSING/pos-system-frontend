import 'package:flutter/material.dart';
import 'package:pos_front/Dashboards/dashboardPage.dart';
import 'package:pos_front/Product/categoryPage.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;

        return Scaffold(
          appBar: AppBar(title: const Text("My App")),

          // Drawer for mobile
          drawer: isDesktop ? null : const AppDrawer(),

          body: Row(
            children: [
              // Sidebar for desktop
              if (isDesktop) const SizedBox(width: 250, child: AppDrawer()),

              // Page content
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          // DrawerHeader(
          //   decoration: BoxDecoration(color: Colors.blue),
          //   child: Text('Navigation', style: TextStyle(color: Colors.white, fontSize: 24)),
          // ),
          SizedBox(height: 20),
          ListTile(leading: Icon(Icons.dashboard),
          title: Text('Dashboard'),
          onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
          },
           
          ),
          ListTile(leading: Icon(Icons.home), title: Text('Home')),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('category'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  CategoryPage(),),
              );
            },
          ),
          ListTile(leading: Icon(Icons.home), title: Text('Product'),
           onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>  CategoryPage(),),
              // );
              },
              ),
          ListTile(leading: Icon(Icons.home), title: Text('sale'),
           onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>  CategoryPage(),),
              // );
              },
              ),
          ListTile(leading: Icon(Icons.home), title: Text('User'),
           onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>  CategoryPage(),),
              // );
              },
              ),
          ListTile(leading: Icon(Icons.home), title: Text('Supply'),
           onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>  CategoryPage(),),
              // );
              },
              ),

          ListTile(leading: Icon(Icons.settings), title: Text('Settings'),
           onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>  CategoryPage(),),
              // );
              },
              ),
        ],
      ),
    );
  }
}
