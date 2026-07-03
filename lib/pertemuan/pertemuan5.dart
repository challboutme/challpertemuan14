// pertemuan5.dart
import 'package:flutter/material.dart';

class ListviewPage extends StatelessWidget {
  const ListviewPage({super.key});

  static const Color maroon = Color(0xFF800020);
  static const Color maroonLight = Color(0xFFA0324A);
  static const Color maroonBg = Color(0xFFFBEFF1);

  final List<Map<String, dynamic>> _items = const [
    {
      "title": "Item 1",
      "subtitle": "Deskripsi singkat item 1",
      "icon": Icons.inventory_2_outlined,
    },
    {
      "title": "Item 2",
      "subtitle": "Deskripsi singkat item 2",
      "icon": Icons.shopping_bag_outlined,
    },
    {
      "title": "Item 3",
      "subtitle": "Deskripsi singkat item 3",
      "icon": Icons.category_outlined,
    },
    {
      "title": "Item 4",
      "subtitle": "Deskripsi singkat item 4",
      "icon": Icons.local_offer_outlined,
    },
    {
      "title": "Item 5",
      "subtitle": "Deskripsi singkat item 5",
      "icon": Icons.star_border_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroonBg,
      appBar: AppBar(
        backgroundColor: maroon,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          "Pertemuan 5",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _headerSection(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _items[index];
                return _itemCard(
                  context: context,
                  icon: item["icon"],
                  title: item["title"],
                  subtitle: item["subtitle"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Row(
        children: [
          Icon(Icons.format_list_bulleted_rounded, color: maroon, size: 26),
          const SizedBox(width: 8),
          Text(
            "Daftar Item",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: maroon,
            ),
          ),
          const Spacer(),
          Text(
            "${_items.length} item",
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _itemCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: 2,
      shadowColor: maroon.withOpacity(0.15),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Kamu memilih $title"),
              backgroundColor: maroon,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [maroonLight, maroon],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: maroonLight),
            ],
          ),
        ),
      ),
    );
  }
}
