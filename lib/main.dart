import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pemesanan Tiket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FlightSelectionPage(),
    );
  }
}

class FlightSelectionPage extends StatelessWidget {
  const FlightSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Penerbangan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          FlightOption(
            origin: 'Palembang',
            destination: 'Jakarta',
            price: 'Rp 800.000',
          ),
          FlightOption(
            origin: 'Palembang',
            destination: 'Bandung',
            price: 'Rp 1.000.000',
          ),
          FlightOption(
            origin: 'Palembang',
            destination: 'Surabaya',
            price: 'Rp 1.500.000',
          ),
          FlightOption(
            origin: 'Palembang',
            destination: 'Denpasar',
            price: 'Rp 2.000.000',
          ),
        ],
      ),
    );
  }
}

class FlightOption extends StatelessWidget {
  final String origin;
  final String destination;
  final String price;

  const FlightOption({
    super.key,
    required this.origin,
    required this.destination,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3,
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kota Asal: $origin',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Kota Tujuan: $destination',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
          trailing: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingPage(
                    origin: origin,
                    destination: destination,
                    price: price,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Pesan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BookingPage extends StatefulWidget {
  final String origin;
  final String destination;
  final String price;

  const BookingPage({
    super.key,
    required this.origin,
    required this.destination,
    required this.price,
  });

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPhoneValid(String value) {
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isi Form Pemesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nama Depan
              _buildTextField(firstNameController, 'Nama Depan',
                  required: true),
              const SizedBox(height: 16),
              // Nama Belakang
              _buildTextField(lastNameController, 'Nama Belakang',
                  required: true),
              const SizedBox(height: 16),
              // Nomor Telepon
              _buildTextField(phoneController, 'Nomor Telepon',
                  required: true, isPhone: true),
              const SizedBox(height: 20),
              // Tombol Selesaikan Pemesanan
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationPage(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phone: phoneController.text,
                          origin: widget.origin,
                          destination: widget.destination,
                          price: widget.price,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Selesaikan Pemesanan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPhone = false, bool required = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      style: const TextStyle(fontSize: 16),
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return 'Field ini wajib diisi';
        }
        if (isPhone && value != null && !isPhoneValid(value)) {
          return 'Nomor telepon hanya boleh angka';
        }
        return null;
      },
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String origin;
  final String destination;
  final String price;

  const ConfirmationPage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.origin,
    required this.destination,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Pemesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ikon centang dengan warna hijau untuk konfirmasi
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 20),
              // Judul yang lebih menonjol
              const Text(
                'Terima kasih atas pemesanan Anda!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Berikut adalah detail pemesanan Anda:',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              // Menampilkan detail pemesanan dalam card dengan padding
              Card(
                elevation: 5,
                shadowColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama: $firstName $lastName',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Nomor Telepon: $phone',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Penerbangan: $origin ke $destination',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Harga Tiket: $price',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Tombol kembali ke halaman utama
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Kembali ke Halaman Utama',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
