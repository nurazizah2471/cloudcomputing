part of 'package:api_raja_ongkir/shared/shared.dart';

class RajaOngkirPage extends StatefulWidget {
  const RajaOngkirPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<RajaOngkirPage> createState() => _RajaOngkirPageState();
}

class _RajaOngkirPageState extends State<RajaOngkirPage> {
  String cost = 'apa';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the RajaOngkirPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('bawah'),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                cost,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //Data online merupakan asyncronous karena untuk dapat datanya harus menunggu
        onPressed: () async {
          //Logikanya, karena async ambil data online, maka harus menunggu. Maka pakai await
          //Isi value dibawah berisi data yang berhasil didapatkan dari fungsi getOngkir() di file rajaongkir_service.dart
          await RajaOngkirService.getOngkir().then((value) {
            var result = json.decode(value.body);
            setState(() {
              cost = result.toString();
            });
          });
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}