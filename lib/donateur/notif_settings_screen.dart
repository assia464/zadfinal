import 'package:flutter/material.dart';
import '../main.dart';

class NotifSettingsScreen extends StatefulWidget {
  const NotifSettingsScreen({super.key});

  @override
  State<NotifSettingsScreen> createState() =>
      _NotifSettingsScreenState();
}

class _NotifSettingsScreenState
    extends State<NotifSettingsScreen> {
  bool _notifDons = true;
  bool _notifBenevoles = true;
  bool _notifExpired = true;
  bool _notifRating = true;
  bool _notifMessages = true;
  bool _pushEnabled = true;
  bool _emailEnabled = false;
  bool _soundEnabled = true;

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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 18),
                    ),
                    const Expanded(
                      child: Text('Paramètres notifications',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(width: 26),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        20, 20, 20, 8),
                    child: const Text('Canaux de réception',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: ZADColors.textDark)),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _NotifToggle(
                          icon: Icons.notifications_outlined,
                          label: 'Notifications push',
                          subtitle: 'Alertes sur votre appareil',
                          value: _pushEnabled,
                          onChanged: (v) => setState(
                              () => _pushEnabled = v),
                        ),
                        _NotifDivider(),
                        _NotifToggle(
                          icon: Icons.email_outlined,
                          label: 'Notifications par email',
                          subtitle: 'Résumé quotidien par email',
                          value: _emailEnabled,
                          onChanged: (v) => setState(
                              () => _emailEnabled = v),
                        ),
                        _NotifDivider(),
                        _NotifToggle(
                          icon: Icons.volume_up_outlined,
                          label: 'Son des notifications',
                          subtitle: "Activer le son d'alerte",
                          value: _soundEnabled,
                          onChanged: (v) => setState(
                              () => _soundEnabled = v),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        20, 24, 20, 8),
                    child: const Text(
                        'Types de notifications',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: ZADColors.textDark)),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _NotifToggle(
                          icon: Icons.volunteer_activism_outlined,
                          label: 'Activité des dons',
                          subtitle:
                              'Publication, livraison, confirmation',
                          value: _notifDons,
                          onChanged: (v) =>
                              setState(() => _notifDons = v),
                        ),
                        _NotifDivider(),
                        _NotifToggle(
                          icon: Icons.person_outlined,
                          label: 'Bénévoles',
                          subtitle: 'Acceptation, arrivée, départ',
                          value: _notifBenevoles,
                          onChanged: (v) => setState(
                              () => _notifBenevoles = v),
                        ),
                        _NotifDivider(),
                        _NotifToggle(
                          icon: Icons.warning_amber_outlined,
                          label: 'Dons expirés',
                          subtitle:
                              'Alerte quand un don expire sans collecte',
                          value: _notifExpired,
                          onChanged: (v) => setState(
                              () => _notifExpired = v),
                        ),
                        _NotifDivider(),
                        _NotifToggle(
                          icon: Icons.star_outline,
                          label: 'Évaluations reçues',
                          subtitle:
                              'Quand un bénévole vous évalue',
                          value: _notifRating,
                          onChanged: (v) => setState(
                              () => _notifRating = v),
                        ),
                        _NotifDivider(),
                        _NotifToggle(
                          icon: Icons.chat_bubble_outline,
                          label: 'Messages',
                          subtitle: 'Nouveaux messages reçus',
                          value: _notifMessages,
                          onChanged: (v) => setState(
                              () => _notifMessages = v),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ZADButton(
                      label: 'Enregistrer les préférences',
                      icon: Icons.check,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotifToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotifToggle({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: value
                  ? ZADColors.primarySoft
                  : ZADColors.divider.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,
                color: value
                    ? ZADColors.primary
                    : ZADColors.textLight,
                size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: ZADColors.textDark)),
                Text(subtitle,
                    style: const TextStyle(
                        color: ZADColors.textLight,
                        fontSize: 11)),
              ],
            ),
          ),
          Switch(
              value: value,
              onChanged: onChanged,
              activeColor: ZADColors.primary),
        ],
      ),
    );
  }
}

class _NotifDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
        height: 1, indent: 68, color: ZADColors.divider);
  }
}