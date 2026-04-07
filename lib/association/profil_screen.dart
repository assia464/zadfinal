import 'package:flutter/material.dart';
// الاستيرادات حسب قائمة ملفاتك
import 'modifier_profil_screen.dart';
import 'history_screen.dart';
import 'documents_screen.dart';
import 'association_register_screen.dart';

class ZadColors {
  static const Color darkNavy = Color(0xFF1A2B4A);
  static const Color leafGreen = Color(0xFF2E7D32);
  static const Color background = Color(0xFFFFFFFF);
  static const Color labelGrey = Color(0xFF6B7A8D);
  static const Color cardBg = Color(0xFFF5F7FA);
}

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  // 1. منطق تسجيل الخروج المسڨد
  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Déconnexion"),
        content: const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Annuler",
              style: TextStyle(color: ZadColors.labelGrey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // يرجعك لصفحة "إنشاء حساب"
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const AssociationRegisterScreen(),
                ),
                (route) => false,
              );
            },
            child: const Text(
              "Déconnecter",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // 2. نافذة تغيير كلمة السر
  void _showChangePasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 25,
          right: 25,
          top: 25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Changer le mot de passe",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ZadColors.leafGreen,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Ancien mot de passe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "Nouveau mot de passe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ZadColors.leafGreen,
                ),
                child: const Text(
                  "Mettre à jour",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. نافذة التنبيهات
  void _showNotificationSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Paramètres de notifications",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ZadColors.leafGreen,
              ),
            ),
            SwitchListTile(
              title: const Text("Nouveaux dons"),
              value: true,
              onChanged: (v) {},
              activeColor: ZadColors.leafGreen,
            ),
            SwitchListTile(
              title: const Text("Messages"),
              value: true,
              onChanged: (v) {},
              activeColor: ZadColors.leafGreen,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fermer"),
            ),
          ],
        ),
      ),
    );
  }

  // 4. نافذة الدعم
  void _showSupportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Aide et Support",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ZadColors.leafGreen,
              ),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text("Appeler le support"),
              subtitle: Text("+213 5XX XX XX XX"),
            ),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text("Envoyer un email"),
              subtitle: Text("support@zad.dz"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fermer"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZadColors.background,
      body: Column(
        children: [
          // Header (Avatar & Stats)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 28),
            decoration: const BoxDecoration(
              color: Color(0xFF1B5E20),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              children: [
                _buildAvatar(),
                const SizedBox(height: 12),
                const Text(
                  'Association El KHAYR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _Stat(v: '23', l: 'Dons reçus'),
                    _Divider(),
                    _Stat(v: '48kg', l: 'Food sauvée'),
                    _Divider(),
                    _Stat(v: '4.8', l: 'Note'),
                  ],
                ),
              ],
            ),
          ),
          // Menu List - هنا رجعتلك كل العناصر اللي كانت ناقصة
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                _MenuItem(
                  icon: Icons.edit_outlined,
                  label: 'Modifier le profil',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ModifierProfilScreen(),
                    ),
                  ),
                ),
                _MenuItem(
                  icon: Icons.lock_outline,
                  label: 'Changer le mot de passe',
                  onTap: () => _showChangePasswordSheet(context),
                ),
                _MenuItem(
                  icon: Icons.notifications_outlined,
                  label: 'Paramètres de notifications',
                  onTap: () => _showNotificationSettings(context),
                ),
                _MenuItem(
                  icon: Icons.history,
                  label: 'Mon historique complet',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HistoryScreen()),
                  ),
                ),
                _MenuItem(
                  icon: Icons.folder_outlined,
                  label: 'Mes documents officiels',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DocumentsScreen()),
                  ),
                ),
                _MenuItem(
                  icon: Icons.help_outline,
                  label: 'Aide et support',
                  onTap: () => _showSupportSheet(context),
                ),
                const SizedBox(height: 12),
                _LogoutBtn(onTap: () => _handleLogout(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
      ),
      child: const Center(
        child: Text(
          'EK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ✅ تعريف الـ Widgets اللي كانوا مسببين أخطاء (Stat, Divider, MenuItem, LogoutBtn)

class _Stat extends StatelessWidget {
  final String v, l;
  const _Stat({required this.v, required this.l});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        v,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      Text(
        l,
        style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 11),
      ),
    ],
  );
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 30, color: Colors.white.withOpacity(0.3));
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ZadColors.cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: ZadColors.leafGreen, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: ZadColors.darkNavy,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: ZadColors.labelGrey, size: 20),
        ],
      ),
    ),
  );
}

class _LogoutBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _LogoutBtn({required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.logout, color: Color(0xFFE53935), size: 20),
          SizedBox(width: 12),
          Text(
            'Se déconnecter',
            style: TextStyle(
              color: Color(0xFFE53935),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
