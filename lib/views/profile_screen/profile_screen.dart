import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/controllers/profile_controller.dart';
import 'package:myapp/views/auth_screen/login_screen.dart';
import 'package:myapp/views/profile_screen/components/details_card.dart';
import 'package:velocity_x/velocity_x.dart';

// Changed to StatefulWidget to resolve hot reload state issue
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final AuthController authController;
  late final ProfileController profileController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    authController = Get.find<AuthController>();
    profileController = Get.find<ProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background color
      body: SafeArea(
        child: Obx(() {
          // Show loading indicator while fetching data
          if (profileController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.brown),
              ),
            );
          }

          // Main profile UI
          return Column(
            children: [
              // User profile section
              _buildProfileHeader(context, profileController),

              const SizedBox(height: 20),

              // Details cards
              _buildDetailsCards(context, profileController),

              const SizedBox(height: 30),

              // Menu options
              _buildMenuOptions(
                context,
                authController,
              ), // Pass context and auth controller
            ],
          );
        }),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    ProfileController controller,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.brown, // Theme color
      child: Row(
        children: [
          Obx(
            () => CircleAvatar(
              radius: 40,
              backgroundImage: controller.profileImageUrl.value.isNotEmpty
                  ? NetworkImage(controller.profileImageUrl.value)
                  : const AssetImage('assets/images/profile_placeholder.png')
                        as ImageProvider,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    controller.userName.value,
                    style: const TextStyle(
                      fontFamily: bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Obx(
                  () => Text(
                    controller.userEmail.value,
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
            icon: const Icon(Icons.edit, color: Colors.white),
            tooltip: 'Edit Profile',
            onPressed: () => _showEditProfileDialog(context, controller),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCards(BuildContext context, ProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            detailsCard(
              count: controller.cartCount.value.toString(),
              title: "In your cart",
              width: context.screenWidth / 3.5,
            ),
            detailsCard(
              count: controller.wishlistCount.value.toString(),
              title: "In your wishlist",
              width: context.screenWidth / 3.5,
            ),
            detailsCard(
              count: controller.orderCount.value.toString(),
              title: "You ordered",
              width: context.screenWidth / 3.5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOptions(
    BuildContext context,
    AuthController authController,
  ) {
    return Expanded(
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
            const ListTile(
              leading: Icon(Icons.list_alt_outlined, color: darkFontGrey),
              title: Text(
                "My Orders",
                style: TextStyle(fontFamily: semibold, color: darkFontGrey),
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.favorite_outline, color: darkFontGrey),
              title: Text(
                "My Wishlist",
                style: TextStyle(fontFamily: semibold, color: darkFontGrey),
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.message_outlined, color: darkFontGrey),
              title: Text(
                "Messages",
                style: TextStyle(fontFamily: semibold, color: darkFontGrey),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: darkFontGrey),
              title: const Text(
                "Log out",
                style: TextStyle(fontFamily: semibold, color: darkFontGrey),
              ),
              onTap: () async {
                await authController.signOutMethod(
                  context,
                ); // Pass context here
                Get.offAll(() => const LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(
    BuildContext context,
    ProfileController controller,
  ) {
    final nameController = TextEditingController(
      text: controller.userName.value,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  controller.pickImage();
                },
                child: Obx(
                  () => CircleAvatar(
                    radius: 40,
                    backgroundImage: controller.profileImageUrl.value.isNotEmpty
                        ? NetworkImage(controller.profileImageUrl.value)
                        : const AssetImage(
                                'assets/images/profile_placeholder.png',
                              )
                              as ImageProvider,
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
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
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
              onPressed: () async {
                await controller.updateProfile(newName: nameController.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
