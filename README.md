## 📱 APK 다운로드

### 고객용 앱
- [SmartCall_고객용.apk] (https://drive.google.com/drive/folders/19HP6i7xSsLWNeS6n9F-8ONVHlj6nOo3W?usp=drive_link) (48.0MB)

### 업주용 앱  
- [SmartCall_업주용.apk] (https://drive.google.com/drive/folders/19HP6i7xSsLWNeS6n9F-8ONVHlj6nOo3W?usp=drive_link) (53.4MB)

### 설치 방법
1. APK 파일 다운로드
2. 안드로이드 기기에서 "알 수 없는 소스" 설치 허용
3. APK 파일 실행하여 설치


# 🍽️ SmartCall - 스마트폰 음식 주문 플랫폼

## 📱 프로젝트 개요

SmartCall은 음식점과 고객을 연결하는 스마트폰 주문 플랫폼입니다. 두 개의 독립적인 앱으로 구성되어 있습니다:

- **고객용 앱**: 음식점 검색, 주문, 즐겨찾기 기능
- **업주용 앱**: 가게 정보 관리, 메뉴 관리, 통계 확인 기능

## 🎯 주요 기능

### 고객용 앱 기능
- 🔐 **로그인/회원가입**: 이메일 기반 인증 시스템
- 🏠 **홈 화면**: 음식점 목록 및 검색 기능
- 🍕 **음식 카테고리**: 한식, 중식, 일식, 분식, 치킨, 피자, 디저트
- ❤️ **즐겨찾기**: 선호하는 음식점 저장
- 📋 **주문내역**: 과거 주문 기록 확인
- 👤 **마이페이지**: 사용자 정보 및 설정 관리
- 📞 **전화 주문**: 원클릭 전화 연결 기능

### 업주용 앱 기능
- 🏪 **가게 정보 관리**: 상호명, 주소, 연락처, 영업시간 설정
- 📸 **로고 업로드**: 가게 로고 이미지 등록
- 🍽️ **메뉴 관리**: 메뉴 추가/수정/삭제 기능
- 💰 **구독 관리**: 월 49,500원 구독료 관리 (부가세 포함)
- 📊 **통계 확인**: 일간/주간/월간 주문 통계
- 📱 **반응형 UI**: 다양한 화면 크기 지원

## 🛠️ 기술 스택

- **프레임워크**: Flutter 3.x
- **언어**: Dart 3.x
- **상태 관리**: Local State Management
- **로컬 저장소**: SharedPreferences
- **UI 라이브러리**: Material Design 3
- **폰트**: Google Fonts (Noto Sans KR)
- **아이콘**: Flutter Launcher Icons

## 📦 설치 및 실행

### 1. APK 파일 설치
```bash
# 안드로이드 기기에서
adb install SmartCall_고객용.apk
adb install SmartCall_업주용.apk
```

### 2. 개발 환경에서 실행
```bash
# 고객용 앱
cd apps/customer_app
flutter pub get
flutter run

# 업주용 앱
cd apps/merchant_app
flutter pub get
flutter run
```

## 🏗️ 프로젝트 구조

```
smartcall_flutter/
├── apps/
│   ├── customer_app/          # 고객용 앱
│   │   ├── lib/
│   │   │   ├── main.dart
│   │   │   ├── ui/
│   │   │   ├── screens/
│   │   │   ├── models/
│   │   │   └── services/
│   │   └── pubspec.yaml
│   └── merchant_app/          # 업주용 앱
│       ├── lib/
│       │   ├── main.dart
│       │   ├── ui/
│       │   ├── screens/
│       │   ├── models/
│       │   └── services/
│       └── pubspec.yaml
└── README.md
```

## 🎨 UI/UX 특징

- **Material Design 3**: 최신 Material Design 가이드라인 적용
- **반응형 디자인**: 다양한 화면 크기 지원
- **한국어 최적화**: Noto Sans KR 폰트 사용
- **직관적 네비게이션**: 하단 네비게이션 바
- **일관된 색상 체계**: 브랜드 컬러 적용

## 🔧 개발 환경 설정

### 필수 요구사항
- Flutter SDK 3.x 이상
- Dart SDK 3.x 이상
- Android Studio / VS Code
- Android SDK (API 21 이상)

### 설치 명령어
```bash
# Flutter 설치 확인
flutter doctor

# 의존성 설치
flutter pub get

# 앱 실행
flutter run

# APK 빌드
flutter build apk --release
```

## 📱 앱 권한

### 고객용 앱
- 인터넷 연결
- 전화 걸기
- 저장소 접근 (이미지 저장)

### 업주용 앱
- 인터넷 연결
- 카메라 접근
- 저장소 접근 (이미지 업로드)

## 🚀 배포 정보

- **최소 Android 버전**: API 21 (Android 5.0)
- **타겟 Android 버전**: API 34 (Android 14)
- **고객용 앱 크기**: 48.0MB
- **업주용 앱 크기**: 53.4MB

## 🔄 업데이트 내역

### v1.0.0 (2024-01-19)
- ✅ 기본 로그인/회원가입 기능
- ✅ 음식점 검색 및 상세 정보
- ✅ 즐겨찾기 기능
- ✅ 주문내역 관리
- ✅ 가게 정보 및 메뉴 관리
- ✅ 통계 기능
- ✅ 구독 관리 시스템

## 📞 지원 및 문의

개발 관련 문의사항이나 버그 리포트는 언제든 연락주세요!

---

**SmartCall** - 더 스마트한 음식 주문 경험을 제공합니다! 🍽️📱

