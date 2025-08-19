import 'package:flutter/material.dart';
import '../../ui/theme.dart';

class Order {
  final String id;
  final String businessName;
  final String orderDate;
  final String status;
  final int totalAmount;
  final List<String> items;

  Order({
    required this.id,
    required this.businessName,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
    required this.items,
  });
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // 데모 주문 데이터
  final List<Order> _orders = [
    Order(
      id: 'ORD001',
      businessName: '맛있는 치킨집',
      orderDate: '2024-01-15 18:30',
      status: '완료',
      totalAmount: 25000,
      items: ['후라이드 치킨', '양념 치킨', '치킨무'],
    ),
    Order(
      id: 'ORD002',
      businessName: '한식당',
      orderDate: '2024-01-14 12:15',
      status: '완료',
      totalAmount: 18000,
      items: ['김치찌개', '공기밥 2개'],
    ),
    Order(
      id: 'ORD003',
      businessName: '피자헛',
      orderDate: '2024-01-13 20:45',
      status: '완료',
      totalAmount: 32000,
      items: ['페퍼로니 피자', '콜라'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('주문내역'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // 필터 기능 (향후 구현)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('필터 기능은 추후 업데이트 예정입니다')),
              );
            },
          ),
        ],
      ),
      body: _orders.isEmpty
          ? _buildEmptyState()
          : _buildOrdersList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            '주문내역이 없습니다',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '첫 주문을 해보세요!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            title: Text(
              order.businessName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  order.orderDate,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        order.status,
                        style: TextStyle(
                          color: _getStatusColor(order.status),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${order.totalAmount}원',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '주문 상세',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...order.items.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 16,
                            color: AppColors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(item),
                        ],
                      ),
                    )),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // 재주문 기능 (향후 구현)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('재주문 기능은 추후 업데이트 예정입니다')),
                              );
                            },
                            icon: const Icon(Icons.replay),
                            label: const Text('재주문'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              // 주문 상세 보기 (향후 구현)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('주문 상세 보기는 추후 업데이트 예정입니다')),
                              );
                            },
                            icon: const Icon(Icons.visibility),
                            label: const Text('상세보기'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case '완료':
        return AppColors.green;
      case '진행중':
        return AppColors.orange;
      case '취소':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
