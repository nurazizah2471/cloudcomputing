part of 'package:api_raja_ongkir/shared/shared.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  final _loginForm = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the SendEmailPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(32),
        child: Form(
          key: _loginForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email penerima", prefixIcon: Icon(Icons.email)),
                controller: ctrlEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return !EmailValidator.validate(value.toString())
                      ? 'Email tidak valid!'
                      : null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //Data online merupakan asyncronous karena untuk dapat datanya harus menunggu
        onPressed: () async {
          if (_loginForm.currentState!.validate()) {
            //Logikanya, karena async ambil data online, maka harus menunggu. Maka pakai await
            //Isi value dibawah berisi data yang berhasil didapatkan dari fungsi getOngkir() di file rajaongkir_service.dart
            await RajaOngkirService.sendemail(ctrlEmail.text).then((value) {
              var result = json.decode(value.body);
              Fluttertoast.showToast(
                  msg: result["mymessage"].toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  fontSize: 14,
                  backgroundColor: Colors.greenAccent,
                  textColor: Colors.white);
            });
          } else {
            Fluttertoast.showToast(
                msg: "Please fill all fields!",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 14,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white);
          }
        },
        tooltip: 'Send Email',
        child: const Icon(Icons.send_and_archive),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}