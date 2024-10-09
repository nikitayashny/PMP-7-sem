import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(24, 25, 43, 1),
                Color.fromRGBO(76, 84, 146, 1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Valorant',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 400.285,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/valorant.jpg'), // Замените на ваш путь к изображению
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Valorant',
                        style: TextStyle(
                          fontSize: 72,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              print('First Button Pressed');
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.redAccent.withOpacity(0.2),
                            ),
                            child: const Text('Shooter'),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              print('Second Button Pressed');
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromRGBO(102, 98, 252, 1),
                            ),
                            child: const Text('Follow'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 410,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(24, 25, 43, 1),
                  Color.fromRGBO(76, 84, 146, 1),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoBlock(Icons.people, '10M', 'Followers'),
                      _buildInfoBlock(Icons.people_alt, '50.6M', 'Players'),
                      _buildInfoBlock(Icons.wifi, '1.8K', 'Streamers'),
                    ],
                  ),
                  const SizedBox(height: 14),
                Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Valorant is a free-to-play first-person hero shooter developed and published by ...',
                          style: TextStyle(color: Color.fromARGB(180, 255, 255, 255), fontSize: 16),
                        ),
                        TextSpan(
                          text: 'Read more',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold, // Делаем текст жирным
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Lives', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                print('See all clicked');
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(0, 0),
                              ),
                              child: Text(
                                'See all',
                                style: TextStyle(fontSize: 14, color: Color.fromARGB(180, 255, 255, 255)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 164,
                    child: PageView(
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/valorant_gameplay.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Positioned(
                                top: 20,
                                left: 10,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    'Live',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 10,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    '3.7k',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/profile.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Quick Valorant WatchParty',
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                        Text(
                                          '@usero11',
                                          style: TextStyle(fontSize: 14, color: Color.fromARGB(180, 255, 255, 255)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/valorant_gameplay.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Positioned(
                                top: 20,
                                left: 10,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    'Live',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 10,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    '3.7k',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/profile.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Quick Valorant WatchParty',
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                        Text(
                                          '@usero11',
                                          style: TextStyle(fontSize: 14, color: Color.fromARGB(180, 255, 255, 255)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, ),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Players', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                print('See all clicked');
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(0, 0),
                              ),
                              child: Text(
                                'See all',
                                style: TextStyle(fontSize: 14, color: Color.fromARGB(180, 255, 255, 255)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBlock(IconData icon, String title, String description) {
    return Row(
      children: [
        Icon(
          icon,
          size: 40,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              description,
              style: TextStyle(color: Color.fromARGB(180, 255, 255, 255), fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}