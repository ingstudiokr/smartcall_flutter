import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ui/theme.dart';
import '../../services/business_service.dart';

class BusinessInfoScreen extends StatefulWidget {
  const BusinessInfoScreen({super.key});

  @override
  State<BusinessInfoScreen> createState() => _BusinessInfoScreenState();
}

class _BusinessInfoScreenState extends State<BusinessInfoScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBusinessInfo();
  }

  Future<void> _loadBusinessInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('business_name') ?? '스마트치킨 본점';
      _phoneController.text = prefs.getString('business_phone') ?? '010-1234-5678';
      _descriptionController.text = prefs.getString('business_description') ?? '겉바속촉 수제치킨 전문점';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '상호명을 입력해주세요';
    }
    if (value.trim().length < 2) {
      return '상호명은 2자 이상 입력해주세요';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '전화번호를 입력해주세요';
    }
    final phoneRegex = RegExp(r'^01[0-9]-\d{3,4}-\d{4}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return '올바른 전화번호 형식을 입력해주세요 (예: 010-1234-5678)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '가게 정보',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        validator: _validateName,
                        decoration: const InputDecoration(
                          labelText: '상호명',
                          hintText: '가게 이름을 입력하세요',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: _validatePhone,
                        decoration: const InputDecoration(
                          labelText: '대표 전화번호',
                          hintText: '010-0000-0000',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: '가게 소개',
                          hintText: '가게에 대한 간단한 소개를 입력하세요',
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _isLoading ? null : () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            
                            setState(() {
                              _isLoading = true;
                            });
                            
                            try {
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setString('business_name', _nameController.text);
                              await prefs.setString('business_phone', _phoneController.text);
                              await prefs.setString('business_description', _descriptionController.text);
                              
                              // 고객 앱과 데이터 동기화
                              await BusinessService.syncCurrentBusiness();
                              
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('가게 정보가 저장되었습니다.')),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('저장 중 오류가 발생했습니다: $e')),
                                );
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                          child: _isLoading 
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('저장'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '고객 앱 미리보기',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.fieldBorder),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                                                             decoration: BoxDecoration(
                                 color: AppColors.cream,
                                 shape: BoxShape.circle,
                               ),
                                                             child: ClipOval(
                                 child: Image.asset(
                                   'assets/images/logo.png',
                                   fit: BoxFit.contain,
                                   errorBuilder: (_, __, ___) => const Icon(Icons.store, color: AppColors.green),
                                 ),
                               ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _nameController.text.isEmpty ? '상호명' : _nameController.text,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _descriptionController.text.isEmpty ? '가게 소개' : _descriptionController.text,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FilledButton.icon(
                              onPressed: () async {
                                final phoneNumber = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
                                if (phoneNumber.isNotEmpty) {
                                  final url = Uri.parse('tel:$phoneNumber');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('전화를 연결할 수 없습니다.')),
                                      );
                                    }
                                  }
                                }
                              },
                              icon: const Icon(Icons.call),
                              label: const Text('주문'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}