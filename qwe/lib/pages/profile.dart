import 'package:flutter/material.dart';
import 'package:qwe/Components/colors.dart';
import 'package:qwe/Json/users.dart';
import 'package:qwe/pages/auth.dart';
import 'package:qwe/pages/welcome.dart'; // Import the WelcomePage if it's in a separate file

class Profile extends StatelessWidget {
  final Users? profile;
  const Profile({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E6), // Slightly orange background color
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/no_user.jpg"),
                  radius: 75,
                ),
                const SizedBox(height: 20),
                Text(
                  profile?.fullName ?? "",
                  style: const TextStyle(
                      fontSize: 28,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  profile?.email ?? "",
                  style: const TextStyle(fontSize: 17, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProfileInfoTile(
                            icon: Icons.person,
                            title: "Full Name",
                            value: profile?.fullName ?? ""),
                        ProfileInfoTile(
                            icon: Icons.email,
                            title: "Email",
                            value: profile?.email ?? ""),
                        ProfileInfoTile(
                            icon: Icons.account_circle,
                            title: "Username",
                            value: profile?.usrName ?? ""),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                RoundedButton(
                  label: "Edit Profile",
                  backgroundColor: primaryColor,
                  textColor: Colors.grey.shade300,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(
                          profile: profile,
                          onSave: (Users updatedProfile) {},
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                RoundedButton(
                  label: "Sign out",
                  backgroundColor: primaryColor,
                  textColor: Colors.grey.shade300,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                RoundedButton(
                  label: "Welcome Page",
                  backgroundColor: primaryColor,
                  textColor: Colors.grey.shade300,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileInfoTile(
      {super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 30, color: primaryColor),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor),
      ),
      subtitle: Text(value, style: const TextStyle(fontSize: 14)),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPress;

  const RoundedButton(
      {super.key,
      required this.label,
      required this.backgroundColor,
      required this.textColor,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  final Users? profile;
  final Function(Users updatedProfile) onSave;

  const EditProfile({super.key, required this.profile, required this.onSave});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Initialize text controllers with existing profile data
    _fullNameController.text = widget.profile?.fullName ?? '';
    _emailController.text = widget.profile?.email ?? '';
    _usernameController.text = widget.profile?.usrName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Create a new Users object with updated information
                Users updatedProfile = Users(
                  usrId: widget.profile?.usrId,
                  fullName: _fullNameController.text,
                  email: _emailController.text,
                  usrName: _usernameController.text,
                  password: widget.profile?.password ?? '',
                );
                // Call the onSave callback to pass the updated profile back to the parent widget
                widget.onSave(updatedProfile);
                // Navigate back to the profile page
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
