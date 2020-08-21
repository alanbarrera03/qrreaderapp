import 'package:flutter/material.dart';
//import 'package:barcode_scan/barcode_scan.dart';

import 'package:qrreaderapp/src/Bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_models.dart';

import 'package:qrreaderapp/src/pages/mapas_pages.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScanTODOS,
          )
        ],
      ),
      body: Center(child: _callPage(currentIndex)),
      bottomNavigationBar: _crearBottonNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  //geo:25.62993233293621,-100.29293611487277

  _scanQR() async {
    //dynamic futureString = '';

    //try {
    //  futureString = await BarcodeScanner.scan();
    //} catch (e) {
    //  futureString = e.toString();
    //}

    //print('Future String: ${futureString.rawContent}');

    String futureString = 'https://www.facebook.com/Alan.Eduardo.Perez.Barrera';

    if (futureString != null) {
      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScan(scan);
    }

    /*_scanQR() async {
    String captura = '';
    try {
      captura = await BarcodeScanner.scan() as String;
    } catch (e) {
      captura = e.toString();
    }

    print('Future String: $captura');

    if (captura != null) {
      print('Tenemos información');
    }*/
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }

  Widget _crearBottonNavBar() {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Map')),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_drop_down_circle),
              title: Text('Direcciones')),
        ]);
  }
}
