import 'package:flutter/material.dart';
import 'package:pertemuan_listview/ui/produk_detail.dart';

class Produkform extends StatefulWidget {
  @override
  _Produkformstate createState() => _Produkformstate();
}

class _Produkformstate extends State<Produkform> {
  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  static const Color maroon = Color(0xFF800020);
  static const Color maroonLight = Color(0xFFA0324A);
  static const Color maroonBg = Color(0xFFFBEFF1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroonBg,
      appBar: AppBar(
        title: Text(
          'Form Produk',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: maroon,
        elevation: 4,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _cardHeader(),
            const SizedBox(height: 20),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _textboxkodeProduk(),
                    const SizedBox(height: 16),
                    _textboxnamaProduk(),
                    const SizedBox(height: 16),
                    _textboxHargaProduk(),
                    const SizedBox(height: 28),
                    _tombolSimpan(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardHeader() {
    return Column(
      children: [
        Icon(Icons.inventory_2_rounded, size: 60, color: maroon),
        const SizedBox(height: 8),
        Text(
          'Tambah Produk Baru',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: maroon,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: maroon),
      prefixIcon: Icon(icon, color: maroon),
      filled: true,
      fillColor: maroonBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: maroonLight, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: maroon, width: 2),
      ),
    );
  }

  Widget _textboxkodeProduk() {
    return TextField(
      decoration: _inputStyle("Kode Produk", Icons.qr_code),
      controller: _kodeProdukTextboxController,
    );
  }

  Widget _textboxnamaProduk() {
    return TextField(
      decoration: _inputStyle("Nama Produk", Icons.shopping_bag_outlined),
      controller: _namaProdukTextboxController,
    );
  }

  Widget _textboxHargaProduk() {
    return TextField(
      decoration: _inputStyle("Harga Produk", Icons.attach_money),
      controller: _hargaProdukTextboxController,
      keyboardType: TextInputType.number,
    );
  }

  Widget _tombolSimpan() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: maroon,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        icon: const Icon(Icons.save),
        label: const Text(
          'Simpan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          String kode_produk = _kodeProdukTextboxController.text;
          String nama_produk = _namaProdukTextboxController.text;
          int harga = int.tryParse(_hargaProdukTextboxController.text) ?? 0;

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProdukDetail(
                kodeProduk: kode_produk,
                namaProduk: nama_produk,
                harga: harga,
              ),
            ),
          );
        },
      ),
    );
  }
}
