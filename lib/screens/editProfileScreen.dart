//edit profile
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmdapp/services/auth/doctorService.dart';
import 'package:mmdapp/utils/toast.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextStyle openSans = GoogleFonts.openSans();

  //controllers for textfields
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController(
    text: '60',
  );

  Map profileData = {};

  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    getProfileData().then((value) {
      if (value.containsKey('success')) {
        if (value['success'] == false) {
          fToast.showToast(
            child: errorToast(value['message']),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 2),
          );
        } else {
          setState(() {
            profileData['blood_group'] = value['data']['blood_group'];
            profileData['gender'] = value['data']['gender'];

            print(profileData);
            nameController.text = (value['data'].containsKey('first_name')
                ? value['data']['first_name'] ?? ''
                : '');

            var weight = (value['data'].containsKey('weight')
                ? value['data']['weight'] ?? '0'
                : '');
            weightController.text = weight.toString();
          });
        }
      }
    });
    // profileController.featchProfileDetails('1');
  }

  //function for save button
  void _saveButton() {
    if (nameController.text.isEmpty) {
      fToast.showToast(
        child: errorToast('Please enter your name'),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
      );
    } else if (weightController.text.isEmpty) {
      fToast.showToast(
        child: errorToast('Please enter your weight'),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
      );
    } else {
      profileData['first_name'] = nameController.text;
      profileData['weight'] = weightController.text;

      updateProfileData(profileData).then((value) {
        if (value.containsKey('success')) {
          if (value['success'] == false) {
            fToast.showToast(
              child: errorToast(value['message']),
              gravity: ToastGravity.BOTTOM,
              toastDuration: const Duration(seconds: 2),
            );
          } else {
            fToast.showToast(
              child: successToast(value['message']),
              gravity: ToastGravity.BOTTOM,
              toastDuration: const Duration(seconds: 2),
            );
            Get.back();
          }
        }
      });
    }
  }

  //function for blood group change
  void _bloodGroupChange(String value) {
    setState(() {
      profileData['blood_group'] = value;
    });
  }

  //function for gender change
  void _genderChange(String value) {
    setState(() {
      profileData['gender'] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Container(
                height: 1.sh,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/dummy_image.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        TextField(
                          controller: nameController,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          decoration: const InputDecoration(
                            hintText: "Your Name",
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Weight',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        TextField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Your Weight",
                          ),
                        ),
                      ],
                    ),
                    //select gender input
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Gender',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        DropdownButton(
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                                value: 'male', child: Text('Male')),
                            DropdownMenuItem(
                                value: 'female', child: Text('Female')),
                            DropdownMenuItem(
                                value: 'other', child: Text('Other'))
                          ],
                          onChanged: (value) {
                            _genderChange(value.toString());
                          },
                          value: profileData.containsKey('gender')
                              ? profileData['gender'] ?? 'male'
                              : 'male',
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Blood Group',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        DropdownButton(
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                                value: 'A+',
                                child: Text(
                                  'A+',
                                )),
                            DropdownMenuItem(value: 'A-', child: Text('A-')),
                            DropdownMenuItem(value: 'O+', child: Text('O+'))
                          ],
                          onChanged: (value) {
                            _bloodGroupChange(value.toString());
                          },
                          value: profileData.containsKey('blood_group')
                              ? profileData['blood_group'] ?? 'A-'
                              : 'A-',
                        )
                      ],
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 125, 125, 125),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _saveButton();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 7, 52, 255),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
