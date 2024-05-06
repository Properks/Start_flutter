import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {

  static const LatLng companyPosition = LatLng(
    37.5233273,
    126.921252,
  );

  static const Marker marker = Marker(
    markerId: MarkerId("Company"),
    position: companyPosition,
  );

  static const double radiusOfCircle = 100;

  static Circle circle = Circle(
    circleId: const CircleId("choolCheckCircle"),
    center: companyPosition,
    radius: radiusOfCircle,
    fillColor: Colors.cyan.withOpacity(0.5),
    strokeColor: Colors.cyan,
    strokeWidth: 1,
  );

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),); // 위치 정보가 없으면 progress 실행
          }
          if (snapshot.data == "위치 권한이 허가되었습니다.") {
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: companyPosition,
                      zoom: 16,
                    ),
                    markers: {marker}, // 좌표에 마커 생성
                    circles: {circle}, // 좌표 주위의 원 생성
                    myLocationEnabled: true, // 내 위치 보여주기
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.timelapse_outlined,
                        color: Colors.cyan,
                        size: 50,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          final currentPosition = await Geolocator
                              .getCurrentPosition();

                          final distance = Geolocator.distanceBetween(
                              currentPosition.latitude,
                              currentPosition.longitude,
                              companyPosition.latitude,
                              companyPosition.longitude
                          );

                          bool canCheck = distance < radiusOfCircle;

                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("출석 체크"),
                                content: Text(
                                  canCheck ? "출석 체크 하시겠습니까?" : "출석 체크를 할 수 없습니다."
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text("취소"),
                                  ),
                                  if (canCheck)
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text("출석 체크"),
                                    ),
                                ],
                              );
                            }
                          );
                        },
                        child: const Text("출석 체크"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(child: Text(snapshot.data.toString()));
        },
      ),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "오늘도 출석 체크",
        style: TextStyle(
          color: Colors.cyan,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled(); // 위치 서비스의 이용 가능 여부

    if (!isLocationEnabled) {
      return "위치 서비스를 활성화해주세요";
    }

    LocationPermission permission = await Geolocator.checkPermission(); // 허가가 되었는지 체크

    if (permission == LocationPermission.deniedForever) {
      return "앱의 위치 권한을 설정에서 허가해주세요";
    }

    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      permission = await Geolocator.requestPermission(); // 허가 요청

      if (permission == LocationPermission.denied) {
        return "위치 권한을 허가해주세요";
      }
    }

    return "위치 권한이 허가되었습니다.";
  }
}