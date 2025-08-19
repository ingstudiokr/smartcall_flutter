import 'package:flutter/material.dart';
import '../../ui/theme.dart';
import '../../services/business_service.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      _isSubscribed ? Icons.verified : Icons.verified_outlined,
                      size: 64,
                      color: _isSubscribed ? AppColors.green : Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _isSubscribed ? '구독 활성' : '구독 비활성',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isSubscribed
                          ? '월 구독료 납부 완료'
                          : '구독을 시작하여 고객에게 노출되세요',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          setState(() {
                            _isSubscribed = !_isSubscribed;
                          });
                          
                          // 구독 상태 동기화
                          await BusinessService.updateSubscriptionStatus(_isSubscribed);
                          
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_isSubscribed
                                    ? '구독이 활성화되었습니다. 고객 앱에서 검색 가능합니다.'
                                    : '구독이 비활성화되었습니다. 고객 앱에서 숨겨집니다.'),
                              ),
                            );
                          }
                        },
                        child: Text(_isSubscribed ? '구독 해지' : '구독 시작'),
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
                      '구독 혜택',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildBenefitItem(Icons.visibility, '고객 앱에 가게 노출'),
                    _buildBenefitItem(Icons.phone, '전화 주문 서비스'),
                    _buildBenefitItem(Icons.analytics, '주문 통계 제공'),
                    _buildBenefitItem(Icons.support_agent, '고객 지원'),
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
                      '구독 요금',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('월 구독료', style: TextStyle(fontSize: 16)),
                        Text(
                          '49,500원',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '※ 부가세 포함 가격입니다',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: AppColors.green, size: 20),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}