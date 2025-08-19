import 'package:flutter/material.dart';
import '../../ui/theme.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String _selectedPeriod = '일간';
  final List<String> _periods = ['일간', '주간', '월간'];

  // 데모 데이터
  final Map<String, Map<String, int>> _demoData = {
    '일간': {
      '전화 주문': 12,
      '총 주문': 12,
      '평균 주문액': 25000,
    },
    '주간': {
      '전화 주문': 89,
      '총 주문': 89,
      '평균 주문액': 28000,
    },
    '월간': {
      '전화 주문': 342,
      '총 주문': 342,
      '평균 주문액': 32000,
    },
  };

  @override
  Widget build(BuildContext context) {
    final data = _demoData[_selectedPeriod]!;
    
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 기간 선택
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '통계 기간',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: _periods.map((period) {
                        final isSelected = _selectedPeriod == period;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  _selectedPeriod = period;
                                });
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: isSelected 
                                    ? AppColors.green 
                                    : Colors.grey.shade200,
                                foregroundColor: isSelected 
                                    ? Colors.white 
                                    : AppColors.text,
                              ),
                              child: Text(period),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 주요 지표
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.analytics, color: AppColors.green),
                        const SizedBox(width: 8),
                        Text(
                          '$_selectedPeriod 주문 통계',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildStatCard(
                      '전화 주문',
                      '${data['전화 주문']}건',
                      Icons.phone,
                      AppColors.green,
                    ),
                    const SizedBox(height: 12),
                    _buildStatCard(
                      '총 주문',
                      '${data['총 주문']}건',
                      Icons.shopping_cart,
                      AppColors.orange,
                    ),
                    const SizedBox(height: 12),
                    _buildStatCard(
                      '평균 주문액',
                      '${data['평균 주문액']}원',
                      Icons.payments,
                      Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 차트 영역 (향후 실제 차트 라이브러리 연동 예정)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.show_chart, color: AppColors.green),
                        const SizedBox(width: 8),
                        const Text(
                          '주문 추이',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bar_chart,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '차트 기능은 추후 업데이트 예정',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
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
            const SizedBox(height: 16),
            
            // 주문 상세 내역
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.receipt_long, color: AppColors.green),
                        const SizedBox(width: 8),
                        const Text(
                          '주문 상세',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildOrderDetailItem('후라이드 치킨', 8, 120000),
                    _buildOrderDetailItem('양념 치킨', 5, 80000),
                    _buildOrderDetailItem('간장 치킨', 3, 48000),
                    _buildOrderDetailItem('치킨무', 12, 12000),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailItem(String menuName, int count, int totalPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${count}건 주문',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${totalPrice}원',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.green,
            ),
          ),
        ],
      ),
    );
  }
}

