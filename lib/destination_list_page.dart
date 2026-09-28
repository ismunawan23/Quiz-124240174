// ============================================================
// DESTINATION LIST PAGE
// ============================================================

import 'package:flutter/material.dart';

import 'destinationModels.dart';
import 'destination_detail_page.dart';

// ============================================================
// HALAMAN DAFTAR DESTINASI
// ============================================================

class DestinationListPage extends StatelessWidget {
  const DestinationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F6),

      // ========================================================
      // APP BAR
      // ========================================================
      appBar: AppBar(
        backgroundColor: const Color(0xFF176B87),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Travel Destination',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),

      // ========================================================
      // ISI HALAMAN
      // ========================================================
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----------------------------------------------------
          // HEADER
          // ----------------------------------------------------

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Destinasi Wisata Indonesia',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF18392B),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  '${destinationList.length} destinasi tersedia',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),

          // ----------------------------------------------------
          // GRID DESTINASI
          // ----------------------------------------------------
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,

                childAspectRatio: 0.72,
              ),

              itemCount: destinationList.length,

              itemBuilder: (context, index) {
                final destination = destinationList[index];

                return _DestinationCard(
                  destination: destination,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DestinationDetailPage(destination: destination),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CARD DESTINASI
// ============================================================

class _DestinationCard extends StatelessWidget {
  final DestinationModel destination;
  final VoidCallback onTap;

  const _DestinationCard({required this.destination, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      // ------------------------------------------------------
      // CARD DAPAT DIKLIK
      // ------------------------------------------------------
      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // GAMBAR DESTINASI
            // ==================================================

            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),

              child: SizedBox(
                height: 135,
                width: double.infinity,

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

                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  },

                  // ------------------------------------------------
                  // JIKA GAMBAR ERROR
                  // ------------------------------------------------
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ==================================================
            // INFORMASI DESTINASI
            // ==================================================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // ------------------------------------------------
                    // KATEGORI
                    // ------------------------------------------------

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2F1),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Text(
                        destination.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF176B87),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ------------------------------------------------
                    // NAMA DESTINASI
                    // ------------------------------------------------
                    Text(
                      destination.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF18392B),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // ------------------------------------------------
                    // LOKASI
                    // ------------------------------------------------
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Colors.black54,
                        ),

                        const SizedBox(width: 4),

                        Expanded(
                          child: Text(
                            destination.location,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // ------------------------------------------------
                    // INDIKATOR LIHAT DETAIL
                    // ------------------------------------------------
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Text(
                          'Lihat detail',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF176B87),
                          ),
                        ),

                        SizedBox(width: 3),

                        Icon(
                          Icons.arrow_forward_ios,
                          size: 11,
                          color: Color(0xFF176B87),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
