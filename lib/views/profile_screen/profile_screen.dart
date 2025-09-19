import 'package:flutter/material.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/views/profile_screen/components/details_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // State variables for user data
  String _userName = "Dummy User";
  final String _userEmail = "customer@example.com";
  // In a real app, you would fetch this from a database.
  final String _profileImagePath = 'assets/images/profile_image.png';

  // Controller for the text field in the dialog
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = _userName;
  }

  // Function to show the edit profile dialog
  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // In a real app, you'd use an image picker here.
              GestureDetector(
                onTap: () {
                  // This is where you would implement image picking logic.
                  // For now, it does nothing.
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(_profileImagePath),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'User Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update state and close dialog
                setState(() {
                  _userName = _nameController.text;
                  // In a real app, you would also save the new image path.
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background color
      body: SafeArea(
        child: Column(
          children: [
            // User profile section
            Container(
              padding: const EdgeInsets.all(20),
              color: Theme.of(
                context,
              ).primaryColor, // Use primary color for the header
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(_profileImagePath),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userName,
                          style: const TextStyle(
                            fontFamily: bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // FittedBox to scale the text down to fit
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _userEmail,
                            style: const TextStyle(
                              fontFamily: regular,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        _showEditProfileDialog(context), // Open edit dialog
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Log out",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: semibold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Details cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  detailsCard(
                    count: "00",
                    title: "In your cart",
                    width: MediaQuery.of(context).size.width / 3.5,
                  ),
                  detailsCard(
                    count: "00",
                    title: "In your wishlist",
                    width: MediaQuery.of(context).size.width / 3.5,
                  ),
                  detailsCard(
                    count: "00",
                    title: "You ordered",
                    width: MediaQuery.of(context).size.width / 3.5,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Menu options
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(
                        Icons.list_alt_outlined,
                        color: darkFontGrey,
                      ),
                      title: const Text(
                        "My Orders",
                        style: TextStyle(
                          fontFamily: semibold,
                          color: darkFontGrey,
                        ),
                      ),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.favorite_outline,
                        color: darkFontGrey,
                      ),
                      title: const Text(
                        "My Wishlist",
                        style: TextStyle(
                          fontFamily: semibold,
                          color: darkFontGrey,
                        ),
                      ),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.message_outlined,
                        color: darkFontGrey,
                      ),
                      title: const Text(
                        "Messages",
                        style: TextStyle(
                          fontFamily: semibold,
                          color: darkFontGrey,
                        ),
                      ),
                      onTap: () {},
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

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
