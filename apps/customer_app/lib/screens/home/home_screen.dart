import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../ui/theme.dart';
import '../../models/business.dart';
import '../../services/business_service.dart';
import '../business/business_detail_screen.dart';

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category({required this.name, required this.icon, required this.color});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Business> _businesses = [];
  List<Business> _filteredBusinesses = [];
  List<String> _favorites = [];
  bool _isLoading = true;
  
  final List<Category> _categories = [
    Category(name: '한식', icon: Icons.restaurant, color: Colors.red),
    Category(name: '중식', icon: Icons.ramen_dining, color: Colors.orange),
    Category(name: '일식', icon: Icons.set_meal, color: Colors.blue),
    Category(name: '분식', icon: Icons.fastfood, color: Colors.purple),
    Category(name: '치킨', icon: Icons.restaurant_menu, color: Colors.amber),
    Category(name: '피자', icon: Icons.local_pizza, color: Colors.green),
    Category(name: '디저트', icon: Icons.cake, color: Colors.pink),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final businesses = await BusinessService.getBusinesses();
      final favorites = await BusinessService.getFavorites();

      setState(() {
        _businesses = businesses;
        _filteredBusinesses = businesses;
        _favorites = favorites;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('데이터를 불러오는 중 오류가 발생했습니다: $e')),
        );
      }
    }
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredBusinesses = _businesses;
      } else {
        _filteredBusinesses = _businesses.where((business) {
          return business.name.toLowerCase().contains(query.toLowerCase()) ||
                 business.description.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> _toggleFavorite(String businessId) async {
    await BusinessService.toggleFavorite(businessId);
    final favorites = await BusinessService.getFavorites();
    setState(() {
      _favorites = favorites;
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanedNumber.isNotEmpty) {
      final url = Uri.parse('tel:$cleanedNumber');
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
      body: SafeArea(
        child: Column(
          children: [
            // 헤더
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                                             Container(
                         width: 40,
                         height: 40,
                         decoration: BoxDecoration(
                           color: AppColors.cream,
                           shape: BoxShape.circle,
                         ),
                         child: ClipOval(
                           child: Image.asset(
                             'assets/images/logo.png',
                             fit: BoxFit.contain,
                             errorBuilder: (_, __, ___) => const Icon(
                               Icons.restaurant,
                               color: AppColors.green,
                             ),
                           ),
                         ),
                       ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '스마트콜',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text,
                              ),
                            ),
                            Text(
                              '맛있는 음식을 간편하게 주문하세요',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _loadData,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 검색바
                  TextField(
                    controller: _searchController,
                    onChanged: _performSearch,
                    decoration: InputDecoration(
                      hintText: '가게 이름이나 음식 종류로 검색하세요',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _performSearch('');
                              },
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 카테고리
                  const Text(
                    '카테고리',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return Container(
                          width: 80,
                          margin: const EdgeInsets.only(right: 12),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: category.color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: category.color.withOpacity(0.3),
                                  ),
                                ),
                                child: Icon(
                                  category.icon,
                                  color: category.color,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // 가게 목록
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredBusinesses.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.store_outlined,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _businesses.isEmpty
                                    ? '아직 등록된 가게가 없습니다'
                                    : '검색 결과가 없습니다',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              if (_businesses.isEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  '점주 앱에서 가게를 등록하고 구독하세요',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadData,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _filteredBusinesses.length,
                            itemBuilder: (context, index) {
                              final business = _filteredBusinesses[index];
                              final isFavorite = _favorites.contains(business.id);

                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BusinessDetailScreen(business: business),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        // 가게 이미지
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: AppColors.cream,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: business.imagePath != null
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Image.asset(
                                                    business.imagePath!,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (_, __, ___) =>
                                                        const Icon(Icons.store, color: AppColors.green),
                                                  ),
                                                )
                                              : const Icon(Icons.store, color: AppColors.green),
                                        ),
                                        const SizedBox(width: 12),
                                        // 가게 정보
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      business.name,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                                                      color: isFavorite ? Colors.red : Colors.grey,
                                                    ),
                                                    onPressed: () => _toggleFavorite(business.id),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                business.description,
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                business.phone,
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // 전화 버튼
                                        FilledButton.icon(
                                          onPressed: () => _makePhoneCall(business.phone),
                                          icon: const Icon(Icons.call, size: 16),
                                          label: const Text('주문'),
                                          style: FilledButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            textStyle: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
