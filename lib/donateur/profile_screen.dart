import 'package:flutter/material.dart';
import '../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZADColors.background,
      body: Column(
        children: [
          Container(
            color: ZADColors.headerBg,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18),
                        ),
                        const Spacer(),
                        const SizedBox(width: 26),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: ZADColors.primaryLight,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white, width: 3),
                        ),
                        child: const Center(
                          child: Text('BA',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 28)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/edit_profile'),
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: ZADColors.accentYellow,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.edit,
                              size: 13, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Boulangerie Atlas',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.volunteer_activism,
                            color: ZADColors.accent, size: 14),
                        SizedBox(width: 6),
                        Text('Donateur · Tlemcen Centre',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('📍 Rue Ibn Badis · Tlemcen',
                      style: TextStyle(
                          color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                      children: const [
                        _ProfileStat(value: '45', label: 'Dons'),
                        _ProfileStatDivider(),
                        _ProfileStat(
                            value: '340kg', label: 'Sauvés'),
                        _ProfileStatDivider(),
                        _ProfileStat(
                            value: '⭐4.8', label: 'Note'),
                        _ProfileStatDivider(),
                        _ProfileStat(
                            value: '40', label: 'Livrés'),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: Column(
                      children: [
                        _ProfileMenuItem(
                          icon: Icons.person_outline,
                          label: 'Modifier le profil',
                          onTap: () => Navigator.pushNamed(
                              context, '/edit_profile'),
                        ),
                        _ProfileMenuDivider(),
                        _ProfileMenuItem(
                          icon: Icons.history,
                          label: 'Historique des dons',
                          onTap: () => Navigator.pushNamed(
                              context, '/historique_dons'),
                        ),
                        // تم إزالة خيار "Mon impact environnemental"
                        _ProfileMenuDivider(),
                        _ProfileMenuItem(
                          icon: Icons.notifications_outlined,
                          label: 'Paramètres notifications',
                          onTap: () => Navigator.pushNamed(
                              context, '/notif_settings'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16),
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacementNamed(
                              context, '/register'),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              ZADColors.danger.withOpacity(0.08),
                          borderRadius:
                              BorderRadius.circular(14),
                          border: Border.all(
                              color: ZADColors.danger
                                  .withOpacity(0.3)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.logout,
                                color: ZADColors.danger,
                                size: 20),
                            SizedBox(width: 12),
                            Text('Se déconnecter',
                                style: TextStyle(
                                    color: ZADColors.danger,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ZADBottomNav(currentIndex: 0),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: ZADColors.textDark)),
        Text(label,
            style: const TextStyle(
                color: ZADColors.textLight, fontSize: 11)),
      ],
    );
  }
}

class _ProfileStatDivider extends StatelessWidget {
  const _ProfileStatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1, height: 32, color: ZADColors.divider);
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileMenuItem(
      {required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: ZADColors.primarySoft,
                  borderRadius: BorderRadius.circular(10)),
              child:
                  Icon(icon, color: ZADColors.primary, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: ZADColors.textDark)),
            ),
            const Icon(Icons.chevron_right,
                color: ZADColors.textLight, size: 20),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuDivider extends StatelessWidget {
  const _ProfileMenuDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
        height: 1,
        indent: 66,
        endIndent: 16,
        color: ZADColors.divider);
  }
}