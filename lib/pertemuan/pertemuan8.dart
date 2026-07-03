import 'package:flutter/material.dart';

class Pert8 extends StatefulWidget {
  const Pert8({super.key});

  @override
  State<Pert8> createState() => _Pert8State();
}

class _Pert8State extends State<Pert8> {
  // Theme colors
  static const Color maroon = Color(0xFF800020);
  static const Color maroonLight = Color(0xFFA0324A);
  static const Color maroonBg = Color(0xFFFBEFF1);

  final List<String> kota = [
    'Jakarta',
    'Bandung',
    'Depok',
    'Bogor',
    'Bekasi',
    'Surabaya',
    'Yogyakarta',
    'Semarang',
    'Medan',
    'Bali',
  ];

  String? selectedKota;
  String hasilAutocomplete = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroonBg,
      appBar: AppBar(
        title: const Text(
          'Pertemuan 8',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: maroon,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerSection(),
            const SizedBox(height: 20),

            // Autocomplete Section
            _sectionCard(
              title: 'Autocomplete',
              icon: Icons.search_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }

                      return kota.where((String option) {
                        return option.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        );
                      });
                    },
                    onSelected: (String selection) {
                      setState(() {
                        hasilAutocomplete = selection;
                      });
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 6,
                          borderRadius: BorderRadius.circular(12),
                          shadowColor: maroon.withOpacity(0.3),
                          child: Container(
                            width: 300,
                            constraints: const BoxConstraints(maxHeight: 220),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              shrinkWrap: true,
                              itemCount: options.length,
                              separatorBuilder: (_, __) =>
                                  Divider(height: 1, color: maroonBg),
                              itemBuilder: (context, index) {
                                final option = options.elementAt(index);
                                return ListTile(
                                  dense: true,
                                  leading: Icon(
                                    Icons.location_city_rounded,
                                    color: maroon,
                                    size: 20,
                                  ),
                                  title: Text(
                                    option,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  onTap: () => onSelected(option),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: maroonBg,
                            ),
                            child: TextField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                hintText: 'Cari Kota',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: maroonLight.withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: maroon,
                                    width: 2,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: maroon,
                                ),
                              ),
                            ),
                          );
                        },
                  ),
                  const SizedBox(height: 16),
                  _resultBadge(
                    icon: Icons.check_circle_outline_rounded,
                    label: 'Hasil AutoComplete',
                    value: hasilAutocomplete.isEmpty ? '-' : hasilAutocomplete,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Dropdown Section
            _sectionCard(
              title: 'Spinner / DropdownButton',
              icon: Icons.expand_circle_down_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: maroonBg,
                      border: Border.all(color: maroonLight.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedKota,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          color: maroon,
                        ),
                        hint: Row(
                          children: [
                            Icon(
                              Icons.location_city_rounded,
                              size: 18,
                              color: maroon.withOpacity(0.6),
                            ),
                            const SizedBox(width: 8),
                            const Text('Pilih Kota'),
                          ],
                        ),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        items: kota.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_city_rounded,
                                  size: 18,
                                  color: maroon,
                                ),
                                const SizedBox(width: 8),
                                Text(item),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedKota = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _resultBadge(
                    icon: Icons.place_rounded,
                    label: 'Kota Dipilih',
                    value: selectedKota ?? '-',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerSection() {
    return Row(
      children: [
        Icon(Icons.travel_explore_rounded, size: 40, color: maroon),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pencarian & Pemilihan Kota',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: maroon,
                ),
              ),
              const Text(
                'Coba fitur autocomplete dan dropdown di bawah',
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

  Widget _resultBadge({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [maroonLight, maroon],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
