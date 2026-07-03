import 'package:flutter/material.dart';

class RadiobuttonPage extends StatefulWidget {
  const RadiobuttonPage({super.key});

  @override
  _CompleteRadioButtonFormState createState() =>
      _CompleteRadioButtonFormState();
}

class _CompleteRadioButtonFormState extends State<RadiobuttonPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();

  String? _selectedGender;
  String? _selectedJob;
  String? _selectedWorkType;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Theme colors
  static const Color maroon = Color(0xFF800020);
  static const Color maroonLight = Color(0xFFA0324A);
  static const Color maroonBg = Color(0xFFFBEFF1);

  final List<Map<String, dynamic>> _jobOptions = [
    {
      'value': 'Admin',
      'icon': Icons.support_agent,
      'description': 'Mengelola data',
    },
    {'value': 'Guru', 'icon': Icons.school, 'description': 'Mendidik generasi'},
    {
      'value': 'Programmer',
      'icon': Icons.code,
      'description': 'Mengembangkan software',
    },
    {
      'value': 'Pengusaha',
      'icon': Icons.business,
      'description': 'Mengelola bisnis',
    },
    {
      'value': 'Desainer',
      'icon': Icons.design_services,
      'description': 'Kreativitas visual',
    },
  ];

  final List<Map<String, dynamic>> _workTypeOptions = [
    {
      'value': 'Full Time',
      'subtitle': 'Bekerja 40 jam/minggu',
      'icon': Icons.work_outline,
      'benefits': ['Asuransi kesehatan', 'Tunjangan hari raya'],
    },
    {
      'value': 'Part Time',
      'subtitle': 'Bekerja < 40 jam/minggu',
      'icon': Icons.access_time,
      'benefits': ['Jadwal fleksibel', 'Liburan panjang'],
    },
    {
      'value': 'Freelance',
      'subtitle': 'Pekerja lepas',
      'icon': Icons.laptop_mac,
      'benefits': ['Kerja remote', 'Rate per project'],
    },
    {
      'value': 'Kontrak',
      'subtitle': 'Perjanjian waktu tertentu',
      'icon': Icons.description_outlined,
      'benefits': ['Bonus kontrak', 'Evaluasi berkala'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _namaController.dispose();
    _umurController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroonBg,
      appBar: AppBar(
        title: const Text(
          "Form dengan RadioButton",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: maroon,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerSection(),
                const SizedBox(height: 20),

                _sectionCard(
                  title: 'Data Diri',
                  icon: Icons.badge_outlined,
                  child: Column(
                    children: [
                      _buildModernTextField(
                        controller: _namaController,
                        label: "Nama",
                        hint: "Masukkan nama",
                        icon: Icons.person_outline,
                        validator: (v) =>
                            v == null || v.isEmpty ? "Wajib diisi" : null,
                      ),
                      const SizedBox(height: 16),
                      _buildModernTextField(
                        controller: _umurController,
                        label: "Umur",
                        hint: "Masukkan umur",
                        icon: Icons.cake_outlined,
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                            v == null || v.isEmpty ? "Wajib diisi" : null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// GENDER
                _sectionCard(
                  title: 'Jenis Kelamin',
                  icon: Icons.wc_rounded,
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildAnimatedGenderCard(
                          title: "Laki-laki",
                          value: "Laki-laki",
                          groupValue: _selectedGender,
                          icon: Icons.male_rounded,
                          onChanged: (v) => setState(() => _selectedGender = v),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildAnimatedGenderCard(
                          title: "Perempuan",
                          value: "Perempuan",
                          groupValue: _selectedGender,
                          icon: Icons.female_rounded,
                          onChanged: (v) => setState(() => _selectedGender = v),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// JOB
                _sectionCard(
                  title: 'Pekerjaan',
                  icon: Icons.work_outline_rounded,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _jobOptions.map((job) {
                      final isSelected = _selectedJob == job['value'];
                      return ChoiceChip(
                        avatar: Icon(
                          job['icon'],
                          size: 18,
                          color: isSelected ? Colors.white : maroon,
                        ),
                        label: Text(job['value']),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() => _selectedJob = job['value']);
                        },
                        selectedColor: maroon,
                        backgroundColor: maroonBg,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : maroon,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? maroon
                                : maroonLight.withOpacity(0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 20),

                /// WORK TYPE
                _sectionCard(
                  title: 'Tipe Pekerjaan',
                  icon: Icons.schedule_rounded,
                  child: Column(
                    children: _workTypeOptions.map((work) {
                      return _buildModernWorkTile(
                        work: work,
                        groupValue: _selectedWorkType,
                        onChanged: (v) => setState(() => _selectedWorkType = v),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: _buildGradientButton(
                        onPressed: _submitForm,
                        text: "Simpan",
                        icon: Icons.save_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildOutlineButton(
                        onPressed: _resetForm,
                        text: "Reset",
                        icon: Icons.refresh_rounded,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ================= WIDGET =================

  Widget _headerSection() {
    return Row(
      children: [
        Icon(Icons.assignment_ind_rounded, size: 40, color: maroon),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Formulir Data Pekerjaan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: maroon,
                ),
              ),
              const Text(
                'Isi data di bawah ini dengan lengkap',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      elevation: 8,
      shadowColor: maroon.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 22,
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
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: maroonBg,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: maroon),
          filled: true,
          fillColor: Colors.white,
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
          labelStyle: TextStyle(color: Colors.grey.shade700),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildAnimatedGenderCard({
    required String title,
    required String value,
    required String? groupValue,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    final isSelected = groupValue == value;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [maroonLight, maroon],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? maroon : maroonLight.withOpacity(0.4),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: maroon.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: isSelected ? Colors.white : maroon),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : maroon,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernWorkTile({
    required Map<String, dynamic> work,
    required String? groupValue,
    required Function(String) onChanged,
  }) {
    final isSelected = groupValue == work['value'];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSelected ? maroonBg : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? maroon : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: RadioListTile(
        title: Row(
          children: [
            Icon(work['icon'], size: 18, color: maroon),
            const SizedBox(width: 8),
            Text(
              work['value'],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                work['subtitle'],
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: (work['benefits'] as List<String>)
                    .map(
                      (b) => Chip(
                        label: Text(
                          b,
                          style: const TextStyle(fontSize: 11, color: maroon),
                        ),
                        backgroundColor: maroonBg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: maroonLight.withOpacity(0.3)),
                        ),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        value: work['value'],
        groupValue: groupValue,
        onChanged: (v) => onChanged(v.toString()),
        activeColor: maroon,
      ),
    );
  }

  Widget _buildGradientButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [maroonLight, maroon],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: maroon.withOpacity(0.35),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
  }) {
    return SizedBox(
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: maroon),
        label: Text(
          text,
          style: const TextStyle(color: maroon, fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: maroon, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  /// ================= LOGIC =================

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
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
                  child: const Icon(
                    Icons.check_circle,
                    size: 56,
                    color: maroon,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Data Berhasil Disimpan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: maroon,
                  ),
                ),
                const SizedBox(height: 12),
                Text("Nama: ${_namaController.text}"),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maroon,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("OK"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _namaController.clear();
    _umurController.clear();

    setState(() {
      _selectedGender = null;
      _selectedJob = null;
      _selectedWorkType = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Form direset"),
        backgroundColor: maroon,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
