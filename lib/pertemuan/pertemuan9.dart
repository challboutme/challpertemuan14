import 'package:flutter/material.dart';

class Pert9 extends StatefulWidget {
  const Pert9({super.key});

  @override
  State<Pert9> createState() => _Pert9State();
}

class _Pert9State extends State<Pert9> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Fungsi pilih tanggal
  Future<void> pilihTanggal() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  // Fungsi pilih waktu
  Future<void> pilihWaktu() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Date & Time Picker")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DATE PICKER
            const Text(
              'DATE PICKER',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: pilihTanggal,
              child: const Text('Pilih Tanggal'),
            ),

            const SizedBox(height: 10),

            Text(
              selectedDate == null
                  ? 'Belum memilih tanggal'
                  : 'Tanggal : ${selectedDate.toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 40),

            // TIME PICKER
            const Text(
              'TIME PICKER',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: pilihWaktu,
              child: const Text('Pilih Waktu'),
            ),

            const SizedBox(height: 10),

            Text(
              selectedTime == null
                  ? 'Belum memilih waktu'
                  : 'Waktu : ${selectedTime!.format(context)}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
