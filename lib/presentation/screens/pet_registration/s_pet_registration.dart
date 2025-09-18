import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:withpet/core/constants/app_sizes.dart';
import 'package:withpet/core/theme/colors.dart';
import 'package:withpet/presentation/widgets/w_custom_bottom_button.dart';

import '../../../data/models/pet_model.dart';
import '../../viewmodels/pet_register_view_model.dart';
import '../../widgets/w_loading_overlay.dart';

class PetRegistrationScreen extends ConsumerStatefulWidget {
  const PetRegistrationScreen({super.key});

  @override
  ConsumerState<PetRegistrationScreen> createState() =>
      _PetRegistrationScreenState();
}

class _PetRegistrationScreenState extends ConsumerState<PetRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _notesController = TextEditingController();

  XFile? _imageFile;
  DateTime _birthDate = DateTime.now();
  PetGender _gender = PetGender.male;
  bool _isNeutered = false;
  DateTime? _adoptedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('PetRegistrationScreen rebuilt');
    ref.listen(petRegistrationViewModelProvider, (previous, next) {
      if (previous is AsyncLoading && !next.hasError) {
        // 등록 성공 시 이전 화면으로 돌아감
        context.pop();
      }
      if (previous is AsyncLoading && next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    final registrationState = ref.watch(petRegistrationViewModelProvider);

    return LoadingOverlay(
      isLoading: registrationState.isLoading,
      child: Scaffold(
        /// 하단 버튼
        bottomNavigationBar: CustomBottomButton(
          text: '저장',
          onPressed: _onSave,
          /// TODO: 로딩 중 + 모든 필수 입력값이 채워졌을 때만 활성화
          isDisabled: registrationState.isLoading,
        ),
        appBar: AppBar(
          backgroundColor: AppColors.appBackground,
          scrolledUnderElevation: 0,
          title: const Text('반려동물 등록'),
          // actions: [TextButton(onPressed: _onSave, child: const Text('저장'))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. 프로필 사진
                GestureDetector(
                  onTap: () async {
                    final selectedImage =
                        await ref
                            .watch(petRegistrationViewModelProvider.notifier)
                            .pickImage();
                    if (selectedImage == null) {
                      return;
                    } else {
                      print('Selected image path: ${selectedImage.path}');
                    }
                    setState(() => _imageFile = selectedImage);
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        _imageFile != null
                            ? FileImage(File(_imageFile!.path))
                            : null,
                    child:
                        _imageFile == null
                            ? const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.grey,
                            )
                            : null,
                  ),
                ),
                const SizedBox(height: 24),

                // 2. 이름, 품종
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: '이름*'),
                  validator: (value) => value!.isEmpty ? '이름을 입력해주세요.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _breedController,
                  decoration: const InputDecoration(labelText: '품종*'),
                  validator: (value) => value!.isEmpty ? '품종을 입력해주세요.' : null,
                ),
                const SizedBox(height: 16),

                // // 3. 생년월일
                // ListTile(
                //   contentPadding: EdgeInsets.zero,
                //   leading: const Icon(Icons.cake_outlined),
                //   title: const Text('생년월일*'),
                //   subtitle: Text(
                //     DateFormat('yyyy년 MM월 dd일').format(_birthDate),
                //   ),
                //   onTap: () => _selectDate(context),
                // ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: '생년월일*',
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  controller: TextEditingController(
                    text: DateFormat('yyyy년 MM월 dd일').format(_birthDate),
                  ),
                  onTap: () => _selectDate(context),
                ),

                const SizedBox(height: 8),

                // 4. 성별
                Row(
                  children: [
                    const Text(
                      '성별',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                ToggleSwitch(
                  // customIcons: [
                  //   Icon(Icons.male, size: 26),
                  //   Icon(Icons.female, size: 26)
                  // ],
                  // borderWidth: 1.5,
                  // borderColor: [
                  //   AppColors.primary
                  // ],
                  activeBorders: [
                    Border.all(color: AppColors.primary, width: 1.5),
                  ],
                  minWidth: double.infinity,
                  minHeight: 50.0,
                  fontSize: 16.0,
                  initialLabelIndex: 0,
                  // activeBgColors: [[Colors.blue], [Color(0xffF27294)]],
                  activeBgColor: [AppColors.primary.withValues(alpha: 0.85)],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.white,
                  inactiveFgColor: Colors.black,
                  totalSwitches: 2,
                  labels: ['남자', '여자'],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),

                const SizedBox(height: 16),

                // // 5. 중성화 여부
                // SwitchListTile(
                //   contentPadding: EdgeInsets.zero,
                //   title: const Text('중성화 여부'),
                //   value: _isNeutered,
                //   onChanged: (value) {
                //     setState(() {
                //       _isNeutered = value;
                //     });
                //   },
                // ),
                SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  title: Text('중성화 여부'),
                  subtitle: Text('중성화 수술을 완료한 경우 켜주세요'),
                  value: _isNeutered,
                  onChanged: (val) => setState(() => _isNeutered = val),
                ),

                const SizedBox(height: 8),

                // 6. 입양일 (선택)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today_outlined),
                  title: const Text('입양일 (선택)'),
                  subtitle: Text(
                    _adoptedDate == null
                        ? '날짜를 선택해주세요'
                        : DateFormat('yyyy년 MM월 dd일').format(_adoptedDate!),
                  ),
                  onTap: () => _selectDate(context, isBirthDate: false),
                ),
                const SizedBox(height: 16),

                // // 7. 특이사항 (선택)
                // TextFormField(
                //   controller: _notesController,
                //   decoration: const InputDecoration(
                //     labelText: '특이사항 (선택)',
                //     alignLabelWithHint: true,
                //   ),
                //   maxLines: 3,
                // ),
                TextFormField(
                  controller: _notesController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: '특이사항 (선택)',
                    hintText: '반려동물의 건강 상태나 성격 등을 입력해주세요',
                    prefixIcon: Icon(Icons.note_alt_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ========================= 메서드 =========================
  // 날짜 선택 로직
  Future<void> _selectDate(
    BuildContext context, {
    bool isBirthDate = true,
  }) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: isBirthDate ? _birthDate : (_adoptedDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        if (isBirthDate) {
          _birthDate = pickedDate;
        } else {
          _adoptedDate = pickedDate;
        }
      });
    }
  }

  // 저장 버튼 로직
  void _onSave() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate() && _imageFile != null) {
      final petData = Pet(
        ownerUid: '',
        // ViewModel에서 채워줄 것이므로 비워둠
        name: _nameController.text.trim(),
        breed: _breedController.text.trim(),
        imageUrl: '',
        // ViewModel에서 채워줄 것이므로 비워둠
        birthDate: _birthDate,
        gender: _gender,
        isNeutered: _isNeutered,
        adoptedDate: _adoptedDate,
        notes: _notesController.text.trim(),
      );

      ref
          .read(petRegistrationViewModelProvider.notifier)
          .addPet(petData: petData, imageFile: _imageFile!);
    } else if (_imageFile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('프로필 사진을 선택해주세요.')));
    }
  }
}
