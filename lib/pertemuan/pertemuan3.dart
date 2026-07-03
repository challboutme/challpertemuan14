import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:simple_alert_dialog/simple_alert_dialog.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPage();
}

class _ButtonPage extends State<ButtonPage> {
  static const Color maroon = Color(0xFF800020);
  static const Color maroonLight = Color(0xFFA0324A);
  static const Color maroonBg = Color(0xFFFBEFF1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroonBg,
      appBar: AppBar(
        backgroundColor: maroon,
        elevation: 4,
        centerTitle: true,
        title: Text(
          "Pertemuan 3",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _headerSection(),
            const SizedBox(height: 24),

            _actionCard(
              icon: Icons.check_circle_outline,
              label: "Submit",
              gradientColors: [Colors.green.shade400, Colors.green.shade700],
              onTap: () => _handleSubmit(context),
            ),
            const SizedBox(height: 16),

            _actionCard(
              icon: Icons.delete_outline,
              label: "Delete",
              gradientColors: [Colors.red.shade400, Colors.red.shade700],
              onTap: () => _handleDelete(context),
            ),
            const SizedBox(height: 16),

            _actionCard(
              icon: Icons.info_outline,
              label: "Show Dialog",
              gradientColors: [maroonLight, maroon],
              onTap: () => _handleShowDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerSection() {
    return Column(
      children: [
        Icon(Icons.widgets_rounded, size: 56, color: maroon),
        const SizedBox(height: 8),
        Text(
          'Aksi Tombol',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: maroon,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Pilih salah satu aksi di bawah ini',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String label,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: gradientColors.last.withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white70,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    SimpleAlertDialog.show(
      context,
      assetImagepath: AnimatedImage.confirm,
      buttonsColor: maroon,
      title: AlertTitleText("Apakah kamu yakin?"),
      content: AlertContentText("Apakah kamu ingin menambahkan data"),
      onConfirmButtonPressed: (ctx) {
        CherryToast.success(
          inheritThemeColors: true,
          title: Text("Berhasil menambahkan data!"),
          borderRadius: 12,
        ).show(context);
        Navigator.pop(context);
      },
    );
  }

  void _handleDelete(BuildContext context) {
    SimpleAlertDialog.show(
      context,
      assetImagepath: AnimatedImage.warning,
      buttonsColor: maroon,
      title: AlertTitleText("Apakah kamu yakin?"),
      content: AlertContentText("Apakah kamu ingin menghapus data"),
      onConfirmButtonPressed: (ctx) {
        CherryToast.success(
          inheritThemeColors: true,
          title: Text("Berhasil menghapus data!"),
          borderRadius: 12,
        ).show(context);
        Navigator.pop(context);
      },
    );
  }

  void _handleShowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        contentPadding: const EdgeInsets.all(20),
        title: Row(
          children: [
            Icon(Icons.info_outline, color: maroon),
            const SizedBox(width: 8),
            Text(
              "AlertDialog",
              style: TextStyle(color: maroon, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: const Text("Ini AlertDialog"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: maroon),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }
}
