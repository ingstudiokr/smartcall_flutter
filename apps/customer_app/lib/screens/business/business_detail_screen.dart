import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ui/theme.dart';
import '../../models/business.dart';
import '../../services/business_service.dart';

class BusinessDetailScreen extends StatefulWidget {
  final Business business;

  const BusinessDetailScreen({
    super.key,
    required this.business,
  });

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final favorites = await BusinessService.getFavorites();
    setState(() {
      _isFavorite = favorites.contains(widget.business.id);
    });
  }

  Future<void> _toggleFavorite() async {
    await BusinessService.toggleFavorite(widget.business.id);
    setState(() {
      _isFavorite = !_isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite ? '즐겨찾기에 추가되었습니다' : '즐겨찾기에서 제거되었습니다'),
      ),
    );
  }

  Future<void> _makePhoneCall() async {
    final phoneNumber = widget.business.phone.replaceAll(RegExp(r'[^\d]'), '');
    if (phoneNumber.isNotEmpty) {
      final url = Uri.parse('tel:$phoneNumber');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('전화를 연결할 수 없습니다.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: CustomScrollView(
        slivers: [
          // 상단 이미지 및 기본 정보
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.green,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.green,
                      AppColors.green.withOpacity(0.8),
                    ],
                  ),
                ),
                                 child: widget.business.imagePath != null
                     ? Image.asset(
                         widget.business.imagePath!,
                         fit: BoxFit.cover,
                         errorBuilder: (_, __, ___) => Center(
                           child: Image.asset(
                             'assets/images/logo.png',
                             width: 64,
                             height: 64,
                             fit: BoxFit.contain,
                             errorBuilder: (_, __, ___) => const Icon(
                               Icons.store,
                               size: 64,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       )
                     : Center(
                         child: Container(
                           width: 64,
                           height: 64,
                           decoration: const BoxDecoration(
                             shape: BoxShape.circle,
                           ),
                           child: ClipOval(
                             child: Image.asset(
                               'assets/images/logo.png',
                               fit: BoxFit.contain,
                               errorBuilder: (_, __, ___) => const Icon(
                                 Icons.store,
                                 size: 64,
                                 color: Colors.white,
                               ),
                             ),
                           ),
                         ),
                       ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
          ),
          // 가게 정보
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.business.name,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.text,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      widget.business.description,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.phone, color: AppColors.green, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                widget.business.phone,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: _makePhoneCall,
                              icon: const Icon(Icons.call),
                              label: const Text('전화 주문하기'),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 메뉴 섹션
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.restaurant_menu, color: AppColors.green),
                              const SizedBox(width: 8),
                              const Text(
                                '메뉴',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          widget.business.menuItems.isEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.menu_book_outlined,
                                        size: 48,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        '아직 등록된 메뉴가 없습니다',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '전화로 메뉴를 문의해 주세요',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.business.menuItems.length,
                                  separatorBuilder: (context, index) => const Divider(),
                                  itemBuilder: (context, index) {
                                    final menuItem = widget.business.menuItems[index];
                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: AppColors.cream,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: menuItem.imagePath != null
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.file(
                                                  File(menuItem.imagePath!),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) =>
                                                      const Icon(Icons.restaurant, color: AppColors.green),
                                                ),
                                              )
                                            : const Icon(Icons.restaurant, color: AppColors.green),
                                      ),
                                      title: Text(
                                        menuItem.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      trailing: Text(
                                        '${menuItem.price.toStringAsFixed(0)}원',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: AppColors.green,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 주문 안내
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.info_outline, color: AppColors.orange),
                              const SizedBox(width: 8),
                              const Text(
                                '주문 안내',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            '• 전화 주문만 가능합니다\n'
                            '• 주문 시 원하는 메뉴와 수량을 말씀해 주세요\n'
                            '• 배달비와 최소 주문 금액은 가게에 문의해 주세요\n'
                            '• 결제는 현금 또는 카드 모두 가능합니다',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
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
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: _makePhoneCall,
            icon: const Icon(Icons.call, size: 20),
            label: Text('${widget.business.name}에 전화주문'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
