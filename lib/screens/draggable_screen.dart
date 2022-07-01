import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureDetectorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        width: double.infinity,
        height: double.infinity,
        child: MainContent(),
      ),
    );
  }
}

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  GlobalKey key = GlobalKey();

  String dragDirection = '';
  String startDXPoint = '';
  String startDYPoint = '';
  String dXPoint;
  String dYPoint;
  String velocity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStartHandler,
      onVerticalDragStart: _onVerticalDragStartHandler,
      // onHorizontalDragUpdate: _onHorizontalDragUpdateHandler,
      // onVerticalDragUpdate: _onVerticalDragUpdateHandler,
      onHorizontalDragUpdate: _onDragUpdateHandler,
      onVerticalDragUpdate: _onDragUpdateHandler,
      onHorizontalDragEnd: _onDragEnd,
      onVerticalDragEnd: _onDragEnd,
      dragStartBehavior: DragStartBehavior.start, // default
      behavior: HitTestBehavior.translucent,
      onTap: () {
        print("SINGLE TAP");
      },
      onDoubleTap: () {
        print("DOUBLE TAB");
      },
      onLongPress: () {
        print("LONG PRESS");
      },
      child: Stack(
        children: [
          this.startDXPoint == '' || this.startDXPoint == ''
              ? Container()
              : Positioned(
              left: double.parse(this.startDXPoint),
              top: double.parse(this.startDYPoint),
              child: CircleAvatar(radius: 15, backgroundColor: Colors.greenAccent,)
          ),
          Container(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      this.dragDirection,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Start DX point: ${this.startDXPoint}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Start DY point: ${this.startDYPoint}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    velocity == null ? Container() : Text(
                      'Velocity: ${this.velocity}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

  void _onHorizontalDragStartHandler(DragStartDetails details) {
    setState(() {
      this.dragDirection = "HORIZONTAL";
      this.startDXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.startDYPoint = '${details.globalPosition.dy.floorToDouble()}';
    });
  }

  /// Track starting point of a vertical gesture
  void _onVerticalDragStartHandler(DragStartDetails details) {
    setState(() {
      this.dragDirection = "VERTICAL";
      this.startDXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.startDYPoint = '${details.globalPosition.dy.floorToDouble()}';
    });
  }

  void _onDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      this.dragDirection = "UPDATING";
      this.startDXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.startDYPoint = '${details.globalPosition.dy.floorToDouble()}';
    });
  }

  /// Track current point of a gesture
  void _onHorizontalDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      this.dragDirection = "HORIZONTAL UPDATING";
      this.dXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.dYPoint = '${details.globalPosition.dy.floorToDouble()}';
      this.velocity = '';
    });
  }

  /// Track current point of a gesture
  void _onVerticalDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      this.dragDirection = "VERTICAL UPDATING";
      this.dXPoint = '${details.globalPosition.dx.floorToDouble()}';
      this.dYPoint = '${details.globalPosition.dy.floorToDouble()}';
      this.velocity = '';
    });
  }

  /// What should be done at the end of the gesture ?
  void _onDragEnd(DragEndDetails details) {
    double result = details.velocity.pixelsPerSecond.dx.abs().floorToDouble();
    setState(() {
      this.velocity = '$result';
    });
  }

}

//
// import 'package:flutter/material.dart';
//
// class MyCustomPainterMain extends StatefulWidget {
//   @override
//   State createState() => new MyCustomPainterMainState();
// }
//
// class MyCustomPainterMainState extends State<MyCustomPainterMain> {
//   GlobalKey _paintKey = new GlobalKey();
//   Offset _offset;
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('CustomPaint example'),
//       ),
//       body: new Listener(
//         onPointerDown: (PointerDownEvent event) {
//           RenderBox referenceBox = _paintKey.currentContext.findRenderObject();
//           Offset offset = referenceBox.globalToLocal(event.position);
//           setState(() {
//             _offset = offset;
//           });
//         },
//         child: new CustomPaint(
//           key: _paintKey,
//           painter: new MyCustomPainter(_offset),
//           child: new ConstrainedBox(
//             constraints: new BoxConstraints.expand(),
//           ),
//         ),
//       ),
//     );
//   }
//
// }
//
// class MyCustomPainter extends CustomPainter {
//   final Offset _offset;
//   MyCustomPainter(this._offset);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (_offset == null) return;
//     canvas.drawCircle(_offset, 10.0, new Paint()..color = Colors.blue);
//   }
//
//   @override
//   bool shouldRepaint(MyCustomPainter other) => other._offset != _offset;
// }