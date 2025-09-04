import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';
import '../../../shared/widgets/app_header.dart';
import '../providers/edit_profile_provider.dart';
import '../widgets/edit_profile_widget.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final List<String> genders = [
    'Laki Laki',
    'Perempuan',
    'Tidak ingin menyebutkan',
  ];
  
  late AnimationController _notifController;
  late Animation<Offset> _notifOffset;
  late AnimationController arrowController;
  late Animation<double> arrowAnimation;
  late AnimationController dropdownController;
  late Animation<double> dropdownAnimation;

  @override
  void initState() {
    super.initState();
    
    _notifController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _notifOffset = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0.05),
    ).animate(CurvedAnimation(parent: _notifController, curve: Curves.easeOut));
    
    arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    arrowAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: arrowController, curve: Curves.easeInOut),
    );
    
    dropdownController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    dropdownAnimation = CurvedAnimation(
      parent: dropdownController,
      curve: Curves.easeInOut,
    );
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(editProfileProvider.notifier).setSelectedGender('Perempuan');
    });
  }

  void toggleDropdown() {
    final notifier = ref.read(editProfileProvider.notifier);
    final currentState = ref.read(editProfileProvider); 
    
    notifier.toggleDropdown();
    
    if (currentState.isExpanded) { 
      arrowController.forward();
      dropdownController.forward();
    } else {
      arrowController.reverse();
      dropdownController.reverse();
    }
  }

  void showNotification() {
    _scrollToTop();
    ref.read(editProfileProvider.notifier).showNotification();
    _notifController.forward();
    
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        _notifController.reverse().then((_) {
          if (mounted) {
            ref.read(editProfileProvider.notifier).hideNotification();
          }
        });
      }
    });
  }

  void hideNotification() {
    _scrollToTop();
    _notifController.reverse().then((_) {
      if (mounted) {
        ref.read(editProfileProvider.notifier).hideNotification();
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _notifController.dispose();
    _scrollController.dispose();
    arrowController.dispose();
    dropdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editProfileProvider);
    
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFF4F4F4),
          body: SafeArea(
            child: Column(
              children: [
                AppHeader(),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 400,
                      margin: const EdgeInsets.symmetric(vertical: 40),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                    'assets/images/profile_pic.png',
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    'assets/images/pencil.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Mrs. Yoo Rachel',
                              style: AppTextStyle.cardTitle,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'rachel@gmail.com',
                              style: AppTextStyle.cardSubtitle,
                            ),
                            const SizedBox(height: 20),
                            ProfileTextField(label: 'Username', value: 'Heesoo Atmaja'),
                            ProfileTextField(label: 'Email', value: 'heesoo@gmail.com'),
                            ProfileTextField(label: 'No. Telepon', value: '09876543458'),
                            GenderDropdown(
                              genders: genders,
                              selectedGender: state.selectedGender,
                              isExpanded: state.isExpanded,
                              arrowAnimation: arrowAnimation,
                              dropdownAnimation: dropdownAnimation,
                              onToggle: toggleDropdown,
                              onGenderSelected: (gender) {
                                ref.read(editProfileProvider.notifier).setSelectedGender(gender);
                              },
                            ),
                            const SizedBox(height: 20),
                            ProfileActionButtons(
                              onCancel: () => Navigator.pop(context),
                              onSave: showNotification,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (state.showNotif)
          ProfileNotification(
            slideAnimation: _notifOffset,
            onClose: hideNotification,
          ),
      ],
    );
  }
}