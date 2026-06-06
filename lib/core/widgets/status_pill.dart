import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class StatusPill extends StatelessWidget {
  final String status;

  const StatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'mendatang':
      case 'aktif':
        bgColor = AppTheme.statusUpcoming.withOpacity(0.15);
        textColor = AppTheme.statusUpcoming;
        break;
      case 'sedang berjalan':
      case 'disetujui':
      case 'approved':
        bgColor = AppTheme.statusActive.withOpacity(0.15);
        textColor = AppTheme.statusActive;
        break;
      case 'selesai':
        bgColor = AppTheme.statusFinished.withOpacity(0.15);
        textColor = AppTheme.statusFinished;
        break;
      case 'dibatalkan':
      case 'ditolak':
      case 'rejected':
        bgColor = AppTheme.statusCancelled.withOpacity(0.15);
        textColor = AppTheme.statusCancelled;
        break;
      case 'pending':
      case 'menunggu':
      default:
        bgColor = AppTheme.statusWarning.withOpacity(0.15);
        textColor = AppTheme.statusWarning;
        break;
    }
  
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}