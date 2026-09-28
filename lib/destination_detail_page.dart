// ============================================================
// DESTINATION DETAIL PAGE
// ============================================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'destinationModels.dart';

// ============================================================
// HALAMAN DETAIL DESTINASI
// ============================================================

class DestinationDetailPage extends StatefulWidget {
  final DestinationModel destination;

  const DestinationDetailPage({super.key, required this.destination});

  @override
  State<DestinationDetailPage> createState() => _DestinationDetailPageState();
}

// ============================================================
// STATE DETAIL PAGE
// ============================================================

class _DestinationDetailPageState extends State<DestinationDetailPage> {
  // Status favorite
  bool isFavorite = false;

  // ==========================================================
  // SAAT HALAMAN DIBUKA
  // ==========================================================

  @override
  void initState() {
    super.initState();

    loadFavorite();
  }

  // ==========================================================
  // MEMUAT STATUS FAVORITE
  // ==========================================================

  Future<void> loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteStatus = prefs.getBool(widget.destination.name) ?? false;

    if (!mounted) return;

    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  // ==========================================================
  // MENGUBAH STATUS FAVORITE
  // ==========================================================

  Future<void> toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isFavorite = !isFavorite;
    });

    await prefs.setBool(widget.destination.name, isFavorite);
  }

  void showWikipediaUrl() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wikipedia'),
          content: SelectableText(widget.destination.wikipediaUrl),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),

      // ========================================================
      // APP BAR
      // ========================================================
      appBar: AppBar(
        backgroundColor: const Color(0xFF176B87),
        foregroundColor: Colors.white,

        title: const Text(
          'Detail Destinasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        actions: [
          // ----------------------------------------------------
          // FAVORITE BUTTON
          // ----------------------------------------------------

          IconButton(
            tooltip: isFavorite
                ? 'Hapus dari favorite'
                : 'Tambahkan ke favorite',

            onPressed: toggleFavorite,

            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,

              color: isFavorite ? Colors.red : Colors.white,

              size: 28,
            ),
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // GAMBAR UTAMA
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 260,

              child: Image.network(
                destination.imageUrl,

                fit: BoxFit.cover,

                // ------------------------------------------------
                // LOADING IMAGE
                // ------------------------------------------------
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return const Center(child: CircularProgressIndicator());
                },

                // ------------------------------------------------
                // ERROR IMAGE
                // ------------------------------------------------
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),

            // ==================================================
            // KONTEN DETAIL
            // ==================================================
            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =================================================
                  // KATEGORI
                  // =================================================

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2F1),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      destination.category,

                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF176B87),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =================================================
                  // NAMA DESTINASI
                  // =================================================
                  Text(
                    destination.name,

                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF18392B),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // =================================================
                  // LOKASI
                  // =================================================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF176B87),
                        size: 20,
                      ),

                      const SizedBox(width: 6),

                      Expanded(
                        child: Text(
                          destination.location,

                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // =================================================
                  // DESKRIPSI
                  // =================================================
                  _DetailSection(
                    title: 'Deskripsi',
                    icon: Icons.description_outlined,
                    child: Text(
                      destination.description,

                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // JAM BUKA
                  // =================================================
                  _DetailSection(
                    title: 'Jam Operasional',
                    icon: Icons.access_time_outlined,
                    child: Text(
                      destination.openingHours,

                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // INFORMASI TIKET
                  // =================================================
                  _DetailSection(
                    title: 'Informasi Tiket',
                    icon: Icons.confirmation_num_outlined,
                    child: Text(
                      destination.ticketInfo,

                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // DAYA TARIK
                  // =================================================
                  _DetailSection(
                    title: 'Daya Tarik',
                    icon: Icons.photo_camera_outlined,
                    child: Text(
                      destination.attraction,

                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // =================================================
                  // WIKIPEDIA
                  // =================================================
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),

                      border: Border.all(color: Colors.black12),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Row(
                          children: [
                            Icon(Icons.language, color: Color(0xFF176B87)),

                            SizedBox(width: 8),

                            Text(
                              'Wikipedia',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          destination.wikipediaUrl,

                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,

                          child: OutlinedButton.icon(
                            onPressed: showWikipediaUrl,

                            icon: const Icon(Icons.open_in_new),

                            label: const Text('Lihat URL Wikipedia'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // =================================================
                  // TOMBOL FAVORITE
                  // =================================================
                  SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: ElevatedButton.icon(
                      onPressed: toggleFavorite,

                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,

                        color: isFavorite ? Colors.red : Colors.white,
                      ),

                      label: Text(
                        isFavorite
                            ? 'Tersimpan di Favorite'
                            : 'Tambah ke Favorite',

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF176B87),

                        foregroundColor: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// WIDGET SECTION DETAIL
// ============================================================

class _DetailSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _DetailSection({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: Colors.black12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ------------------------------------------------------
          // JUDUL SECTION
          // ------------------------------------------------------

          Row(
            children: [
              Icon(icon, size: 21, color: const Color(0xFF176B87)),

              const SizedBox(width: 8),

              Text(
                title,

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF18392B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ------------------------------------------------------
          // ISI SECTION
          // ------------------------------------------------------
          child,
        ],
      ),
    );
  }
}
