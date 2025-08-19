import 'package:flutter/material.dart';
import '../../ui/theme.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 데모 사용자 데이터
  final Map<String, String> _userInfo = {
    'name': '홍길동',
    'email': 'hong@example.com',
    'phone': '010-1234-5678',
    'address': '서울시 강남구 테헤란로 123',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('마이페이지'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('설정 기능은 추후 업데이트 예정입니다')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 프로필 카드
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.green.withOpacity(0.1),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _userInfo['name']!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _userInfo['email']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // 사용자 정보
            Card(
              child: Column(
                children: [
                  _buildInfoTile(
                    '이름',
                    _userInfo['name']!,
                    Icons.person,
                  ),
                  _buildDivider(),
                  _buildInfoTile(
                    '이메일',
                    _userInfo['email']!,
                    Icons.email,
                  ),
                  _buildDivider(),
                  _buildInfoTile(
                    '전화번호',
                    _userInfo['phone']!,
                    Icons.phone,
                  ),
                  _buildDivider(),
                  _buildInfoTile(
                    '주소',
                    _userInfo['address']!,
                    Icons.location_on,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // 메뉴 목록
            Card(
              child: Column(
                children: [
                  _buildMenuTile(
                    '개인정보 수정',
                    Icons.edit,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('개인정보 수정 기능은 추후 업데이트 예정입니다')),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    '배송지 관리',
                    Icons.location_on,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('배송지 관리 기능은 추후 업데이트 예정입니다')),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    '결제 수단 관리',
                    Icons.payment,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('결제 수단 관리 기능은 추후 업데이트 예정입니다')),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    '알림 설정',
                    Icons.notifications,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('알림 설정 기능은 추후 업데이트 예정입니다')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // 고객 지원
            Card(
              child: Column(
                children: [
                  _buildMenuTile(
                    '고객센터',
                    Icons.support_agent,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('고객센터 기능은 추후 업데이트 예정입니다')),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    '자주 묻는 질문',
                    Icons.help,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('자주 묻는 질문 기능은 추후 업데이트 예정입니다')),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    '이용약관',
                    Icons.description,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('이용약관 기능은 추후 업데이트 예정입니다')),
                      );
                    },
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    '개인정보 처리방침',
                    Icons.privacy_tip,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('개인정보 처리방침 기능은 추후 업데이트 예정입니다')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // 로그아웃 버튼
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('로그아웃'),
                      content: const Text('정말 로그아웃하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('취소'),
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text('로그아웃'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('로그아웃'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.green),
      title: Text(title),
      subtitle: Text(value),
      trailing: IconButton(
        icon: const Icon(Icons.edit, size: 20),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('수정 기능은 추후 업데이트 예정입니다')),
          );
        },
      ),
    );
  }

  Widget _buildMenuTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.green),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, indent: 56);
  }
}
