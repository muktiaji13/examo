import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileState {
  final bool showNotif;
  final bool isExpanded;
  final String? selectedGender;
  
  EditProfileState({
    this.showNotif = false,
    this.isExpanded = false,
    this.selectedGender,
  });
  
  EditProfileState copyWith({
    bool? showNotif,
    bool? isExpanded,
    String? selectedGender,
  }) {
    return EditProfileState(
      showNotif: showNotif ?? this.showNotif,
      isExpanded: isExpanded ?? this.isExpanded,
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }
}

class EditProfileNotifier extends StateNotifier<EditProfileState> {
  EditProfileNotifier() : super(EditProfileState());
  
  void toggleDropdown() {
    state = state.copyWith(isExpanded: !state.isExpanded);
  }
  
  void showNotification() {
    state = state.copyWith(showNotif: true);
  }
  
  void hideNotification() {
    state = state.copyWith(showNotif: false);
  }
  
  void setSelectedGender(String gender) {
    state = state.copyWith(selectedGender: gender);
  }
}

final editProfileProvider = StateNotifierProvider<EditProfileNotifier, EditProfileState>(
  (ref) => EditProfileNotifier(),
);