import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/business.dart';

class BusinessService {
  static const String _businessesKey = 'businesses';


  // 현재 merchant_app의 가게 정보를 customer_app에서 볼 수 있도록 동기화
  static Future<void> syncCurrentBusiness() async {
    final prefs = await SharedPreferences.getInstance();
    
    // SharedPreferences에서 현재 가게 정보 읽기
    final businessName = prefs.getString('business_name');
    final businessPhone = prefs.getString('business_phone');
    final businessDescription = prefs.getString('business_description');
    final isSubscribed = prefs.getBool('subscription_active') ?? false;
    
    if (businessName == null || businessPhone == null) {
      return; // 가게 정보가 없으면 동기화하지 않음
    }

    // 메뉴 정보 읽기
    final menuJson = prefs.getStringList('menu_items') ?? [];
    final menuItems = menuJson
        .map((json) => MenuItem.fromJson(jsonDecode(json)))
        .toList();

    // Business 객체 생성
    final business = Business(
      id: 'current_business',
      name: businessName,
      phone: businessPhone,
      description: businessDescription ?? '',
      isSubscribed: isSubscribed,
      menuItems: menuItems,
    );

    // 전체 가게 목록에서 현재 가게 업데이트
    await _updateBusinessInList(business);
  }

  // 가게 목록에서 특정 가게 업데이트
  static Future<void> _updateBusinessInList(Business business) async {
    final prefs = await SharedPreferences.getInstance();
    final businessesJson = prefs.getStringList(_businessesKey) ?? [];
    
    final businesses = businessesJson
        .map((json) => Business.fromJson(jsonDecode(json)))
        .toList();

    // 기존 가게 찾아서 업데이트, 없으면 추가
    final existingIndex = businesses.indexWhere((b) => b.id == business.id);
    if (existingIndex >= 0) {
      businesses[existingIndex] = business;
    } else {
      businesses.add(business);
    }

    // 다시 저장
    final updatedJson = businesses
        .map((b) => jsonEncode(b.toJson()))
        .toList();
    
    await prefs.setStringList(_businessesKey, updatedJson);
  }

  // 메뉴 아이템 저장 (merchant_app에서 사용)
  static Future<void> saveMenuItems(List<MenuItem> menuItems) async {
    final prefs = await SharedPreferences.getInstance();
    final menuJson = menuItems
        .map((item) => jsonEncode(item.toJson()))
        .toList();
    
    await prefs.setStringList('menu_items', menuJson);
    
    // 가게 정보 동기화
    await syncCurrentBusiness();
  }

  // 구독 상태 업데이트 (merchant_app에서 사용)
  static Future<void> updateSubscriptionStatus(bool isSubscribed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('subscription_active', isSubscribed);
    
    // 가게 정보 동기화
    await syncCurrentBusiness();
  }

  // customer_app에서 사용할 가게 목록 가져오기
  static Future<List<Business>> getBusinesses() async {
    final prefs = await SharedPreferences.getInstance();
    final businessesJson = prefs.getStringList(_businessesKey) ?? [];
    
    return businessesJson
        .map((json) => Business.fromJson(jsonDecode(json)))
        .where((business) => business.isSubscribed) // 구독한 가게만 반환
        .toList();
  }
}
