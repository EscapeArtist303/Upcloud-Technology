import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_project/model/coffee_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  List<Marker> allMarkers = [];

  late PageController _pageController;

  late int prevPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterData();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void filterData() {
    for (var element in coffeeShops) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.name!),
          draggable: false,
          infoWindow: InfoWindow(title: element.name, snippet: element.name),
          position: element.coordinates!));
    }
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      moveCamera();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(children: [
            Text('${coffeeShops[index].name}')
            // Center(
            //     child: Container(
            //         margin: EdgeInsets.symmetric(
            //           horizontal: 10.0,
            //           vertical: 20.0,
            //         ),
            //         height: 125.0,
            //         width: 275.0,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10.0),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.black54,
            //                 offset: Offset(0.0, 4.0),
            //                 blurRadius: 10.0,
            //               ),
            //             ]),
            //         child: Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10.0),
            //                 color: Colors.white),
            //             child: Row(children: [
            //               // Container(
            //               //     height: 90.0,
            //               //     width: 90.0,
            //               //     decoration: BoxDecoration(
            //               //         borderRadius: BorderRadius.only(
            //               //             bottomLeft: Radius.circular(10.0),
            //               //             topLeft: Radius.circular(10.0)),
            //               //         image: DecorationImage(
            //               //             image: NetworkImage(
            //               //                 coffeeShops[index].thumbNail),
            //               //             fit: BoxFit.cover))),
            //               SizedBox(width: 5.0),
            //               Column(
            //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       coffeeShops[index].shopName,
            //                       style: TextStyle(
            //                           fontSize: 12.5,
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                     Text(
            //                       coffeeShops[index].address,
            //                       style: TextStyle(
            //                           fontSize: 12.0,
            //                           fontWeight: FontWeight.w600),
            //                     ),
            //                     Container(
            //                       width: 170.0,
            //                       child: Text(
            //                         coffeeShops[index].description,
            //                         style: TextStyle(
            //                             fontSize: 11.0,
            //                             fontWeight: FontWeight.w300),
            //                       ),
            //                     )
            //                   ])
            //             ]))))
          ])),
      builder: (BuildContext context, Widget? child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
    );
    // // return AnimatedBuilder(
    // //   animation: _pageController,
    //   builder: (BuildContext context, Widget widget) {
    //     double value = 1;
    //     if (_pageController.position.haveDimensions) {
    //       value = _pageController.page - index;
    //       value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
    //     }
    //     return Center(
    //       child: SizedBox(
    //         height: Curves.easeInOut.transform(value) * 125.0,
    //         width: Curves.easeInOut.transform(value) * 350.0,
    //         child: widget,
    //       ),
    //     );
    //   },
    //   builder: (BuildContext context, Widget widget){
    //
    //   },
    //   child: InkWell(
    //       onTap: () {
    //         // moveCamera();
    //       },
    //       child: Stack(children: [
    //         Text('${coffeeShops[index].name}')
    //         // Center(
    //         //     child: Container(
    //         //         margin: EdgeInsets.symmetric(
    //         //           horizontal: 10.0,
    //         //           vertical: 20.0,
    //         //         ),
    //         //         height: 125.0,
    //         //         width: 275.0,
    //         //         decoration: BoxDecoration(
    //         //             borderRadius: BorderRadius.circular(10.0),
    //         //             boxShadow: [
    //         //               BoxShadow(
    //         //                 color: Colors.black54,
    //         //                 offset: Offset(0.0, 4.0),
    //         //                 blurRadius: 10.0,
    //         //               ),
    //         //             ]),
    //         //         child: Container(
    //         //             decoration: BoxDecoration(
    //         //                 borderRadius: BorderRadius.circular(10.0),
    //         //                 color: Colors.white),
    //         //             child: Row(children: [
    //         //               // Container(
    //         //               //     height: 90.0,
    //         //               //     width: 90.0,
    //         //               //     decoration: BoxDecoration(
    //         //               //         borderRadius: BorderRadius.only(
    //         //               //             bottomLeft: Radius.circular(10.0),
    //         //               //             topLeft: Radius.circular(10.0)),
    //         //               //         image: DecorationImage(
    //         //               //             image: NetworkImage(
    //         //               //                 coffeeShops[index].thumbNail),
    //         //               //             fit: BoxFit.cover))),
    //         //               SizedBox(width: 5.0),
    //         //               Column(
    //         //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         //                   crossAxisAlignment: CrossAxisAlignment.start,
    //         //                   children: [
    //         //                     Text(
    //         //                       coffeeShops[index].shopName,
    //         //                       style: TextStyle(
    //         //                           fontSize: 12.5,
    //         //                           fontWeight: FontWeight.bold),
    //         //                     ),
    //         //                     Text(
    //         //                       coffeeShops[index].address,
    //         //                       style: TextStyle(
    //         //                           fontSize: 12.0,
    //         //                           fontWeight: FontWeight.w600),
    //         //                     ),
    //         //                     Container(
    //         //                       width: 170.0,
    //         //                       child: Text(
    //         //                         coffeeShops[index].description,
    //         //                         style: TextStyle(
    //         //                             fontSize: 11.0,
    //         //                             fontWeight: FontWeight.w300),
    //         //                       ),
    //         //                     )
    //         //                   ])
    //         //             ]))))
    //       ])),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(''),
          centerTitle: true,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            allMarkers.isEmpty
                ? const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.black,
                    ),
                  )
                : GoogleMap(
                    initialCameraPosition: const CameraPosition(
                        target: LatLng(40.7128, -74.0060), zoom: 12.0),
                    markers: Set.from(allMarkers),
                    onMapCreated: mapCreated,
                  ),
            Positioned(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: coffeeShops.length,
                  itemBuilder: (context,index){
                    return  Container(
                      margin: EdgeInsets.all(12),
                      width: 200,
                      height: 200,
                      color: Colors.red,
                    );
                  },
                ),
              ),
              bottom: 0,
              left: 0,right: 0,
            )
          ],
        )
        // body: Stack(
        //   children: <Widget>[
        //     SizedBox(
        //       height: MediaQuery
        //           .of(context)
        //           .size
        //           .height - 50.0,
        //       width: MediaQuery
        //           .of(context)
        //           .size
        //           .width,
        //       child: GoogleMap(
        //         initialCameraPosition: const CameraPosition(
        //             target: LatLng(40.7128, -74.0060), zoom: 12.0),
        //         markers: Set.from(allMarkers),
        //         onMapCreated: mapCreated,
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 20.0,
        //       child: SizedBox(
        //         height: 200.0,
        //         width: MediaQuery
        //             .of(context)
        //             .size
        //             .width,
        //         child: PageView.builder(
        //           controller: _pageController,
        //           itemCount: coffeeShops.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             return _coffeeShopList(index);
        //           },
        //         ),
        //       ),
        //     )
        //   ],
        // )
        );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: coffeeShops[_pageController.page!.toInt()].coordinates!,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}
