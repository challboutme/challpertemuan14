import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  _FormCheckboxExampleState createState() => _FormCheckboxExampleState();
}

class _FormCheckboxExampleState extends State<CheckboxPage> {
  // Theme colors
  static const Color maroon = Color(0xFF800020);
  static const Color maroonLight = Color(0xFFA0324A);
  static const Color maroonBg = Color(0xFFFBEFF1);

  // Form controllers
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _kelasController = TextEditingController();

  // Checkbox states
  bool _isCheckedSyarat = false;
  String _errorText = '';

  // Hobby checkboxes
  Map<String, bool> _hobbies = {
    'Membaca': false,
    'Olahraga': false,
    'Musik': false,
    'Game': false,
    'Traveling': false,
  };

  // Form validation errors
  String _namaError = '';
  String _nimError = '';
  String _kelasError = '';
  String _hobbyError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroonBg,
      appBar: AppBar(
        title: const Text(
          "Form Pendaftaran",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: maroon,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerSection(),
              const SizedBox(height: 20),

              // Form Section
              Card(
                elevation: 8,
                shadowColor: maroon.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle('Data Diri', Icons.badge_outlined),
                      const SizedBox(height: 20),

                      _buildTextField(
                        controller: _namaController,
                        label: 'Nama Lengkap',
                        hint: 'Masukkan nama lengkap Anda',
                        icon: Icons.person_outline,
                        errorText: _namaError,
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        controller: _nimController,
                        label: 'NIM',
                        hint: 'Masukkan NIM Anda',
                        icon: Icons.numbers,
                        errorText: _nimError,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        controller: _kelasController,
                        label: 'Kelas',
                        hint: 'Contoh: 01SIFP001',
                        icon: Icons.class_outlined,
                        errorText: _kelasError,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Hobi Section
              Card(
                elevation: 8,
                shadowColor: maroon.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _sectionTitle('Hobi', Icons.favorite_border),
                          const SizedBox(width: 8),
                          Text(
                            '(Pilih minimal 1)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: maroonBg,
                        ),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 3,
                          children: _hobbies.keys.map((hobby) {
                            return CheckboxListTile(
                              title: Text(
                                hobby,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: _hobbies[hobby],
                              onChanged: (bool? value) {
                                setState(() {
                                  _hobbies[hobby] = value ?? false;
                                  if (_hobbies.values.any(
                                    (selected) => selected,
                                  )) {
                                    _hobbyError = '';
                                  }
                                });
                              },
                              activeColor: maroon,
                              checkColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              dense: false,
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          }).toList(),
                        ),
                      ),

                      if (_hobbyError.isNotEmpty) _buildErrorText(_hobbyError),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Syarat dan Ketentuan
              Card(
                elevation: 4,
                shadowColor: maroon.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: const Text(
                          'Saya menyetujui syarat dan ketentuan yang berlaku',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: _isCheckedSyarat,
                        onChanged: (bool? value) {
                          setState(() {
                            _isCheckedSyarat = value ?? false;
                            if (_isCheckedSyarat) {
                              _errorText = '';
                            }
                          });
                        },
                        activeColor: maroon,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                      if (_errorText.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildErrorText(_errorText),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _validateAndSubmit(context);
                  },
                  icon: const Icon(Icons.how_to_reg_rounded),
                  label: const Text(
                    'DAFTAR SEKARANG',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: maroon,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.app_registration_rounded, size: 40, color: maroon),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Formulir Pendaftaran',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: maroon,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Lengkapi data di bawah ini dengan benar',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: maroon,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Icon(icon, size: 20, color: maroon),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String errorText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: maroonBg,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: maroonLight.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: maroon, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          errorText: errorText.isNotEmpty ? errorText : null,
          prefixIcon: Icon(icon, color: maroon),
          labelStyle: TextStyle(color: Colors.grey.shade700),
        ),
      ),
    );
  }

  Widget _buildErrorText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_amber_rounded, size: 16, color: Colors.red),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ),
    );
  }

  void _validateAndSubmit(BuildContext context) {
    setState(() {
      // Reset errors
      _namaError = '';
      _nimError = '';
      _kelasError = '';
      _hobbyError = '';
      _errorText = '';

      // Validate Nama
      if (_namaController.text.trim().isEmpty) {
        _namaError = 'Nama tidak boleh kosong';
      }

      // Validate NIM
      if (_nimController.text.trim().isEmpty) {
        _nimError = 'NIM tidak boleh kosong';
      } else if (_nimController.text.trim().length < 8) {
        _nimError = 'NIM minimal 8 karakter';
      }

      // Validate Kelas
      if (_kelasController.text.trim().isEmpty) {
        _kelasError = 'Kelas tidak boleh kosong';
      }

      // Validate Hobby (minimal 1 dipilih)
      if (!_hobbies.values.any((selected) => selected)) {
        _hobbyError = 'Pilih minimal 1 hobi';
      }

      // Validate Terms
      if (!_isCheckedSyarat) {
        _errorText = 'Anda harus menyetujui syarat dan ketentuan';
      }

      // If all validations pass
      if (_namaError.isEmpty &&
          _nimError.isEmpty &&
          _kelasError.isEmpty &&
          _hobbyError.isEmpty &&
          _isCheckedSyarat) {
        List<String> selectedHobbies = _hobbies.keys
            .where((hobby) => _hobbies[hobby] == true)
            .toList();

        showDialog(
          context: context,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: maroonBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check_circle, size: 64, color: maroon),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Pendaftaran Berhasil!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: maroon,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.person, 'Nama', _namaController.text),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.numbers, 'NIM', _nimController.text),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        Icons.class_,
                        'Kelas',
                        _kelasController.text,
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        Icons.favorite,
                        'Hobi',
                        selectedHobbies.join(', '),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _resetForm();
                        Fluttertoast.showToast(
                          msg: 'Pendaftaran Berhasil Disimpan!!',
                          gravity: ToastGravity.TOP,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maroon,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: maroon),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  void _resetForm() {
    setState(() {
      _namaController.clear();
      _nimController.clear();
      _kelasController.clear();
      _hobbies.updateAll((key, value) => false);
      _isCheckedSyarat = false;
      _namaError = '';
      _nimError = '';
      _kelasError = '';
      _hobbyError = '';
      _errorText = '';
    });
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _kelasController.dispose();
    super.dispose();
  }
}
