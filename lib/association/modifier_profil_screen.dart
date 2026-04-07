import 'package:flutter/material.dart';

class ModifierProfilScreen extends StatefulWidget {
  const ModifierProfilScreen({super.key});

  @override
  State<ModifierProfilScreen> createState() => _ModifierProfilScreenState();
}

class _ModifierProfilScreenState extends State<ModifierProfilScreen> {
  // هادو الـ Controllers باش نقدرو نتحكمو في النص ونعرفو واش كتب المستخدم
  final TextEditingController _nameController = TextEditingController(
    text: "Association El KHAYR",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "contact@elkhayr.dz",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "+213 5XX XX XX XX",
  );
  final TextEditingController _addressController = TextEditingController(
    text: "Tlemcen Centre",
  );

  @override
  void dispose() {
    // مهم جداً باش نحافظو على الـ Mémoire تاع الهاتف
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Modifier le profil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1B5E20), // نفس لون الـ Header تاعك
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // الجزء العلوي (Header)
            Container(
              height: 140,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1B5E20),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      child: const Text(
                        "EK",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 18,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // هنا نزيدو Image Picker مستقبلاً
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // الحقول (Input Fields)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildTextField(
                    "Nom de l'association",
                    _nameController,
                    Icons.business,
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    "Email",
                    _emailController,
                    Icons.email_outlined,
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    "Téléphone",
                    _phoneController,
                    Icons.phone_android,
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    "Adresse",
                    _addressController,
                    Icons.location_on_outlined,
                    maxLines: 2,
                  ),

                  const SizedBox(height: 40),

                  // زر الحفظ
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // هنا نسيفو الداتا (الـ Logic تاعك)
                        String name = _nameController.text;
                        print("Updating Profile for: $name");

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profil mis à jour avec succès !'),
                            backgroundColor: Color(0xFF1B5E20),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.pop(context); // نرجعو لصفحة البروفايل
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B5E20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        "Enregistrer les modifications",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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

  // الـ Widget المساعد المعدل مع Controller و Icons
  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF1B5E20)),
        prefixIcon: Icon(icon, color: const Color(0xFF1B5E20)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF1B5E20), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF5F7FA), // نفس لون كروت الـ Menu تاعك
      ),
    );
  }
}
