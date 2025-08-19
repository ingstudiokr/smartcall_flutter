import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/business.dart';

class BusinessService {
  static const String _businessesKey = 'businesses';
  static const String _favoritesKey = 'favorites';

  // 가게 목록 가져오기 (로컬 저장소에서)
  static Future<List<Business>> getBusinesses() async {
    final prefs = await SharedPreferences.getInstance();
    final businessesJson = prefs.getStringList(_businessesKey) ?? [];
    
    return businessesJson
        .map((json) => Business.fromJson(jsonDecode(json)))
        .where((business) => business.isSubscribed) // 구독한 가게만 표시
        .toList();
  }

  // 가게 저장 (merchant_app에서 사용)
  static Future<void> saveBusiness(Business business) async {
    final prefs = await SharedPreferences.getInstance();
    final businesses = await getBusinesses();
    
    // 기존 가게 업데이트 또는 새 가게 추가
    final existingIndex = businesses.indexWhere((b) => b.id == business.id);
    if (existingIndex >= 0) {
      businesses[existingIndex] = business;
    } else {
      businesses.add(business);
    }
    
    final businessesJson = businesses
        .map((b) => jsonEncode(b.toJson()))
        .toList();
    
    await prefs.setStringList(_businessesKey, businessesJson);
  }

  // 즐겨찾기 목록 가져오기
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  // 즐겨찾기 추가/제거
  static Future<void> toggleFavorite(String businessId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    
    if (favorites.contains(businessId)) {
      favorites.remove(businessId);
    } else {
      favorites.add(businessId);
    }
    
    await prefs.setStringList(_favoritesKey, favorites);
  }

  // 가게 검색
  static Future<List<Business>> searchBusinesses(String query) async {
    final businesses = await getBusinesses();
    
    if (query.isEmpty) return businesses;
    
    return businesses.where((business) {
      return business.name.toLowerCase().contains(query.toLowerCase()) ||
             business.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // merchant_app에서 사용할 현재 가게 정보 가져오기
  static Future<Business?> getCurrentBusiness() async {
    final prefs = await SharedPreferences.getInstance();
    final businessName = prefs.getString('business_name');
    final businessPhone = prefs.getString('business_phone');
    final businessDescription = prefs.getString('business_description');
    
    if (businessName == null || businessPhone == null) {
      return null;
    }
    
    return Business(
      id: 'current_business', // merchant_app의 현재 가게 ID
      name: businessName,
      phone: businessPhone,
      description: businessDescription ?? '',
      isSubscribed: true, // merchant_app에서는 항상 구독 상태
    );
  }

  // merchant_app에서 사용할 현재 가게 정보 저장
  static Future<void> syncCurrentBusiness() async {
    final currentBusiness = await getCurrentBusiness();
    if (currentBusiness != null) {
      await saveBusiness(currentBusiness);
    }
  }
}

