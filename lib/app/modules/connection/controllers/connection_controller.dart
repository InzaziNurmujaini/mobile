import 'package:codelab3/app/modules/connection/views/connection_view.dart';
import 'package:codelab3/app/modules/product/views/product_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  String? _lastRoute; // Menyimpan rute terakhir
  RxBool isPopupVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((connectivityResults) {
      if (connectivityResults.isNotEmpty) {
        _updateConnectionStatus(connectivityResults.first);
      }
    });
  }

  // Fungsi untuk mengupdate status koneksi
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      // Simpan rute halaman terakhir
      _lastRoute = Get.currentRoute;

      // Tampilkan pop-up jika belum ditampilkan
      if (!isPopupVisible.value) {
        isPopupVisible.value = true; // Tandai pop-up sebagai ditampilkan
        _showNoConnectionPopup();
      }
    } 
    else {
      // Tutup pop-up jika koneksi kembali
      if (isPopupVisible.value) {
        isPopupVisible.value = false; // Tandai pop-up sebagai ditutup
        if (Navigator.canPop(Get.context!)) {
          Navigator.pop(Get.context!);
        }
      }

      // Kembali ke halaman terakhir jika ada
      if (_lastRoute != null && Get.currentRoute != _lastRoute) {
        Get.offAllNamed(_lastRoute!);
      } else {
        Get.offAll(() => ProductView());
      }
    }
  }

  // Fungsi untuk menampilkan pop-up no connection
  void _showNoConnectionPopup() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const NoConnectionView();
      },
    ).whenComplete(() {
      // Ketika pop-up ditutup secara manual
      isPopupVisible.value = false;
    });
  }
}
