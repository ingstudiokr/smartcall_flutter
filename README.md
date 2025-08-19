# 스마트콜 (SmartCall) - 전화 주문 플랫폼

음식점 점주와 고객을 연결하는 간편한 전화 주문 플랫폼입니다.

## 📱 앱 구성

### 🏪 Merchant App (점주용 앱)
점주가 가게 정보를 관리하고 구독을 통해 고객에게 노출시키는 앱

**주요 기능:**
- ✅ 회원가입/로그인 시스템
- ✅ 가게 정보 관리 (상호명, 전화번호, 소개)
- ✅ 메뉴 관리 (메뉴 추가/삭제, 이미지 업로드)
- ✅ 구독 관리 (월 구독을 통한 고객 앱 노출)
- ✅ 실시간 미리보기 (고객 앱에서 보이는 모습)
- ✅ 데이터 영구 저장 (SharedPreferences)

### 🛍️ Customer App (고객용 앱)
가게를 검색하고 전화로 주문할 수 있는 앱

**주요 기능:**
- ✅ 가게 리스트 및 검색
- ✅ 가게 상세 정보 보기
- ✅ 메뉴 보기
- ✅ 원터치 전화 주문
- ✅ 즐겨찾기 기능
- ✅ 실시간 데이터 동기화

## 🛠️ 기술 스택

- **Framework:** Flutter 3.24.x
- **언어:** Dart
- **상태 관리:** StatefulWidget
- **로컬 저장소:** SharedPreferences
- **UI/UX:** Material Design 3
- **폰트:** Google Fonts (Noto Sans Korean)
- **이미지 처리:** Image Picker
- **전화 연동:** URL Launcher

## 📂 프로젝트 구조

```
smartcall_flutter/
├── apps/
│   ├── merchant_app/           # 점주용 앱
│   │   ├── lib/
│   │   │   ├── main.dart
│   │   │   ├── ui/theme.dart
│   │   │   ├── models/business.dart
│   │   │   ├── services/business_service.dart
│   │   │   └── screens/
│   │   │       ├── auth/        # 로그인/회원가입
│   │   │       ├── dashboard/   # 메인 대시보드
│   │   │       ├── business/    # 가게 정보 관리
│   │   │       ├── menu/        # 메뉴 관리
│   │   │       └── subscription/ # 구독 관리
│   │   └── assets/images/
│   └── customer_app/           # 고객용 앱
│       ├── lib/
│       │   ├── main.dart
│       │   ├── ui/theme.dart
│       │   ├── models/business.dart
│       │   ├── services/business_service.dart
│       │   └── screens/
│       │       ├── home/        # 홈 화면
│       │       └── business/    # 가게 상세
│       └── assets/images/
└── README.md
```

## 🚀 시작하기

### 필요 사항
- Flutter SDK 3.24.x 이상
- Dart SDK 3.5.x 이상
- Android Studio / VS Code
- Android 디바이스 또는 에뮬레이터

### 설치 및 실행

1. **프로젝트 클론**
```bash
git clone [repository-url]
cd smartcall_flutter
```

2. **Merchant App 실행**
```bash
cd apps/merchant_app
flutter pub get
flutter run
```

3. **Customer App 실행**
```bash
cd apps/customer_app
flutter pub get
flutter run
```

### 빌드
```bash
# Debug APK 생성
flutter build apk --debug

# Release APK 생성  
flutter build apk --release
```

## 📋 사용 방법

### 점주 (Merchant App)
1. **회원가입/로그인** - 점주 계정 생성
2. **가게 정보 입력** - 상호명, 전화번호, 소개 작성
3. **메뉴 등록** - 메뉴 이름, 가격, 사진 등록
4. **구독 활성화** - 월 구독을 통해 고객 앱에 노출
5. **전화 주문 대기** - 고객의 전화 주문 접수

### 고객 (Customer App)
1. **가게 검색** - 이름이나 음식 종류로 검색
2. **가게 선택** - 원하는 가게 상세 정보 확인
3. **메뉴 확인** - 가격과 메뉴 사진 확인
4. **전화 주문** - 원터치로 가게에 전화 연결
5. **즐겨찾기** - 자주 주문하는 가게 저장

## 🔄 데이터 동기화

두 앱 간의 데이터는 SharedPreferences를 통해 실시간으로 동기화됩니다:

- 점주가 가게 정보를 수정하면 고객 앱에 즉시 반영
- 메뉴 추가/삭제 시 고객 앱에서 바로 확인 가능
- 구독 상태에 따라 고객 앱 노출 여부 제어

## 💳 구독 시스템

- **월 구독료:** 29,900원
- **구독 혜택:**
  - 고객 앱에 가게 노출
  - 전화 주문 서비스
  - 주문 통계 제공 (향후 기능)
  - 고객 지원

## 🎨 디자인 시스템

### 컬러 팔레트
- **Primary Green:** `#1F402D` - 메인 브랜드 컬러
- **Secondary Orange:** `#F2994A` - 포인트 컬러
- **Background Cream:** `#FFF6E6` - 배경색
- **Text:** `#0F2A1E` - 텍스트 컬러

### 특징
- 한국어 최적화 (Noto Sans Korean)
- Material Design 3 기반
- 직관적이고 깔끔한 UI
- 접근성 고려한 대비율

## 🔮 향후 계획

### Phase 2 (중기)
- [ ] 실제 결제 시스템 연동 (Stripe/PortOne)
- [ ] 푸시 알림 시스템
- [ ] 주문 내역 관리
- [ ] 평점 및 리뷰 시스템

### Phase 3 (장기)
- [ ] 백엔드 시스템 구축 (Firebase/Supabase)
- [ ] 실시간 주문 추적
- [ ] 배달 시스템 연동
- [ ] 마케팅 도구 제공

## 🐛 알려진 이슈

- 현재 로컬 저장소만 지원 (디바이스 간 동기화 불가)
- 이미지는 로컬에만 저장됨
- 오프라인 상태에서는 동기화 불가

## 🤝 기여하기

1. Fork 프로젝트
2. Feature 브랜치 생성 (`git checkout -b feature/AmazingFeature`)
3. 변경사항 커밋 (`git commit -m 'Add some AmazingFeature'`)
4. 브랜치에 Push (`git push origin feature/AmazingFeature`)
5. Pull Request 생성

## 📝 라이선스

이 프로젝트는 MIT 라이선스 하에 있습니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

## 📞 지원

문제가 있거나 제안사항이 있으시면 이슈를 생성해주세요.

---

**Made with ❤️ using Flutter**

