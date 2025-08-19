import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../ui/theme.dart';
import '../../models/business.dart' as models;
import '../../services/business_service.dart';

// 기존 MenuItem을 models.MenuItem으로 대체

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<models.MenuItem> _menuItems = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // 데모 데이터
    _menuItems.addAll([
      models.MenuItem(id: '1', name: '후라이드 치킨', price: 15000),
      models.MenuItem(id: '2', name: '양념 치킨', price: 16000),
      models.MenuItem(id: '3', name: '간장 치킨', price: 16000),
    ]);
  }

  Future<void> _addMenuItem() async {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    XFile? selectedImage;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                '메뉴 추가',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  selectedImage = await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.fieldBorder),
                  ),
                  child: selectedImage != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(selectedImage!.path),
                      fit: BoxFit.cover,
                    ),
                  )
                      : const Icon(Icons.add_a_photo, size: 40, color: AppColors.green),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: '메뉴명',
                  hintText: '메뉴 이름을 입력하세요',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: '가격',
                  hintText: '가격을 입력하세요',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
                      final price = double.tryParse(priceController.text) ?? 0;
                      if (price > 0) {
                        setState(() {
                          _menuItems.add(models.MenuItem(
                            id: DateTime.now().toString(),
                            name: nameController.text,
                            price: price,
                            imagePath: selectedImage?.path,
                          ));
                        });
                        // 메뉴 변경 시 동기화
                        await BusinessService.saveMenuItems(_menuItems);
                        if (mounted) {
                          Navigator.pop(context);
                        }
                      }
                    }
                  },
                  child: const Text('추가'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: item.imagePath != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(item.imagePath!),
                          fit: BoxFit.cover,
                        ),
                      )
                          : const Icon(Icons.restaurant, color: AppColors.green),
                    ),
                    title: Text(item.name),
                    subtitle: Text('${item.price.toStringAsFixed(0)}원'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        setState(() {
                          _menuItems.removeAt(index);
                        });
                        // 메뉴 변경 시 동기화
                        await BusinessService.saveMenuItems(_menuItems);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMenuItem,
        backgroundColor: AppColors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}