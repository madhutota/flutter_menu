import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Color color = new Color(0xFF4A4A58);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapse = true;
  double screeWidth;
  double screenHeight;
  final Duration duration = const Duration(microseconds: 300);

  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<Offset> _offSetAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    _offSetAnimation = Tween<Offset>(begin: Offset(-1,0),end: Offset(0,0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    screenHeight = size.height;
    screeWidth = size.width;
    return Scaffold(
      backgroundColor: color,
      body: Stack(
        children: <Widget>[menu(context), dashboard(context)],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _offSetAnimation,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              SizedBox(height: 10),
              Text('Messages',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              SizedBox(height: 10),
              Text('Utility Bills',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              SizedBox(height: 10),
              Text('Funds Transfer',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              SizedBox(height: 10),
              Text('Branches',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      /*top: isCollapse ? 0 : 0.2 * screenHeight,
      bottom: isCollapse ? 0 : 0.2 * screeWidth,*/
      left: isCollapse ? 0 : 0.6 * screeWidth,
      right: isCollapse ? 0 : -0.4 * screeWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: color,
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 48),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child: Icon(Icons.menu, color: Colors.white),
                      onTap: () {
                        setState(() {
                          if(isCollapse){
                            _controller.forward();
                          }else{
                            _controller.reverse();
                          }


                          isCollapse = !isCollapse;
                        });
                      },
                    ),
                    Text('My Dashboard',
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                    Icon(Icons.settings, color: Colors.white),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  height: 500,
                  child: PageView(
                    controller: PageController(
                        viewportFraction: 0.8
                    ),
                    scrollDirection: Axis.horizontal,
                    pageSnapping: true,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.redAccent,
                        width: 100,
                      ), Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.yellow,
                        width: 100,
                      ), Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.blue,
                        width: 100,
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
