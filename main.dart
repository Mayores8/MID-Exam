import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Global Reciprocal Colleges',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Default Home icon selected

  final String logoUrl =
      'https://tse1.mm.bing.net/th/id/OIP.Od3Y_-oDAo3A-3fwgtnFewAAAA?rs=1&pid=ImgDetMain&o=7&rm=3';

  // College links
  final List<Map<String, String>> colleges = [
    {"title": "CCS", "url": "https://grc.edu.ph/college-of-computer-studies/"},
    {"title": "EDUC", "url": "https://grc.edu.ph/college-of-education/"},
    {"title": "COA", "url": "https://grc.edu.ph/college-of-accountancy/"},
    {"title": "CBAE", "url": "https://grc.edu.ph/college-of-business-administration/"},
  ];

  // Events link
  final String eventsLink = "https://grc.edu.ph/category/events/";

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Home screen
  Widget _buildHome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Image.network(
              logoUrl,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 30),
        Divider(
          color: Colors.red[700],
          thickness: 1.5,
          indent: 50,
          endIndent: 50,
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: colleges.map((college) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                backgroundColor: Colors.red[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                side: BorderSide(color: Colors.red[800]!, width: 2), // Border added
              ),
              onPressed: () => _launchURL(college["url"]!),
              child: Text(
                college["title"]!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Events screen
  Widget _buildEvents() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "EVENTS",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red[800],
          ),
        ),
        SizedBox(height: 20),
        Divider(
          color: Colors.red[700],
          thickness: 1.5,
          indent: 50,
          endIndent: 50,
        ),
        SizedBox(height: 20),
        Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: Icon(Icons.event, size: 40, color: Colors.red[700]),
            title: Text(
              "View All Events",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 20),
            onTap: () => _launchURL(eventsLink),
          ),
        ),
      ],
    );
  }

  // Contact screen
  Widget _buildContact() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Contact Page",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Divider(
            color: Colors.red[700],
            thickness: 1.5,
            indent: 50,
            endIndent: 50,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              backgroundColor: Colors.red[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
              side: BorderSide(color: Colors.red[800]!, width: 2), // Border added
            ),
            onPressed: () => _launchURL("https://grc.edu.ph/contact-us"),
            child: Text("Visit Contact Us",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              backgroundColor: Colors.red[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
              side: BorderSide(color: Colors.red[800]!, width: 2), // Border added
            ),
            onPressed: () => _launchURL("mailto:info@grc.edu.ph"),
            child: Text("Email Us",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [_buildEvents(), _buildHome(), _buildContact()];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (black & white)
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.white,
              BlendMode.saturation,
            ),
            child: Image.network(
              "https://tse2.mm.bing.net/th/id/OIP.kxPc890Pl-WTikIot05WBQHaFj?rs=1&pid=ImgDetMain&o=7&rm=3", // 👈 replace with your PNG link
              fit: BoxFit.cover,
            ),
          ),
          // Page content
          Center(child: _pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[800],
        iconSize: 40,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: AnimatedScale(
              scale: _selectedIndex == 0 ? 1.2 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Icon(Icons.event),
            ),
            label: "Events",
          ),
          BottomNavigationBarItem(
            icon: AnimatedScale(
              scale: _selectedIndex == 1 ? 1.2 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Icon(Icons.home),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: AnimatedScale(
              scale: _selectedIndex == 2 ? 1.2 : 1.0,
              duration: Duration(milliseconds: 200),
              child: Icon(Icons.contact_mail),
            ),
            label: "Contact",
          ),
        ],
      ),
    );
  }
}
