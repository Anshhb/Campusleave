import 'dart:io';

import 'package:campusleave/core/common/error_text.dart';
import 'package:campusleave/core/common/loader.dart';
import 'package:campusleave/features/auth/controller/auth_controller.dart';
import 'package:campusleave/features/user_profile/controller/user_profile_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WardenEditProfileScreen extends ConsumerStatefulWidget {
   final String uid;
  const WardenEditProfileScreen({super.key, required this.uid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WardenEditProfileScreenState();
}

class _WardenEditProfileScreenState extends ConsumerState<WardenEditProfileScreen> {

    File? profileFile;

  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(userProvider)!.name);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  Future<FilePickerResult?> pickImage() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
  }

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  void save() {
    ref.read(userProfileControllerProvider.notifier).editCommunity(
          profileFile: profileFile,
          context: context,
          name: nameController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
   final isLoading = ref.watch(userProfileControllerProvider);
    return ref.watch(getUserDataProvider(widget.uid)).when(
          data: (user) => Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: save,
                ),
              ],
            ),
            body: isLoading
                ? const Loader()
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: selectProfileImage,
                          child: profileFile != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(profileFile!),
                                  radius: 32,
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user.profilePic),
                                  radius: 32,
                                ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Name',
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(18),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          loading: () => const Loader(),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
        );
  }
}