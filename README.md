# My Casey - Camp Casey & Hovey Bus App

[🇰🇷 한국어](README.md) | [🇺🇸 English](README_EN.md)

![My Casey App](https://img.notionusercontent.com/s3/prod-files-secure%2F0ec83f0d-0bf0-4877-bb09-68a1391c59b3%2Fbb7e39a6-7fb1-4abc-9986-511f86ad0151%2Funnamed.webp/size/w=2000?exp=1753033565&sig=Isf2D_XYYDhXagDE94Mca29Na4BjglrBtFeSQji57tA&id=1cc1b47a-3bd0-806e-9dd6-fd6bd0211181&table=block)

**[📱 앱 소개 보기](https://kbwportfolio.notion.site/My-Casey-1cc1b47a3bd0806e9dd6fd6bd0211181)**

Camp Casey & Hovey 기지의 버스 시간표와 시설 운영시간을 제공하는 Flutter 모바일 애플리케이션입니다.

## 🚌 주요 기능

### 버스 시간표
- **3개 버스 노선**: H221, HOVEY, TMC
- **실시간 정보**: 현재 시간 기준 다음/이전 버스 시간 표시
- **평일/휴일 구분**: 자동으로 적절한 스케줄 적용
- **시간표 버전**: 최신/구버전 시간표 토글 가능
- **상세 정보**: 각 버스별 전체 시간표 확인

### 📅 일정 관리
- **메모 기능**: 날짜별 메모 작성/수정/삭제
- **시간 설정**: 메모에 알림 시간 설정 가능
- **로컬 저장**: 앱 재시작 후에도 데이터 유지
- **정렬**: 시간순으로 메모 자동 정렬

### 🏢 운영 시간
- **다양한 시설**: DFAC, KATUSA PX, CAC, USO, Barber Shop
- **실시간 상태**: 현재 운영 상태 표시
- **평일/휴일 구분**: 자동으로 적절한 운영시간 적용
- **상세 정보**: 각 시설별 상세 운영시간 확인

## 🎨 UI/UX 특징

- **모던한 디자인**: Material 3 디자인 시스템 적용
- **직관적인 인터페이스**: 카드 기반 레이아웃
- **색상 코딩**: 상태별 색상 구분으로 빠른 인식
- **다국어 지원**: 한국어/영어 지원
- **실시간 업데이트**: 1초마다 시간 정보 갱신

## 🛠️ 기술 스택

- **프레임워크**: Flutter
- **언어**: Dart
- **상태 관리**: StatefulWidget + Stream
- **로컬 저장**: SharedPreferences
- **다국어**: easy_localization
- **캘린더**: table_calendar
- **폰트**: Google Fonts (Inter)

## 📱 주요 페이지

### 메인 화면
- 버스 시간표 탭
- 실시간 버스 정보
- 평일/휴일 자동 감지

### 캘린더 화면
- 날짜별 메모 관리
- 시간 설정 기능
- 직관적인 UI

### 운영시간 화면
- 시설별 운영 상태
- 실시간 정보 표시
- 상세 정보 제공

## 📁 프로젝트 구조

```
lib/
├── component/          # 재사용 가능한 UI 컴포넌트
│   ├── bus_time_card.dart
│   ├── opening_hours_card.dart
│   └── ...
├── const/             # 상수 데이터
│   ├── bus_time.dart      # 버스 시간표 데이터
│   ├── colors.dart        # 색상 상수
│   └── weekend_list.dart  # 휴일 목록
├── function/          # 비즈니스 로직
│   ├── checkNearestBusTimes.dart
│   ├── isTodayWeekend.dart
│   └── ...
├── screen/            # 화면별 UI
│   ├── home_screen.dart
│   ├── bus_schedule_screen.dart
│   ├── calendar_screen.dart
│   └── opening_hours_screen.dart
├── theme/             # 앱 테마
│   └── app_theme.dart
└── main.dart          # 앱 진입점
```

## 🔧 주요 의존성

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  intl: ^0.20.2
  table_calendar: ^3.0.9
  shared_preferences: ^2.2.1
  easy_localization: ^3.0.3
  google_fonts: ^6.1.0
```

## 🌟 주요 기능 상세

### 버스 시간 계산 알고리즘
- 현재 시간 기준으로 가장 가까운 버스 시간 자동 계산
- 평일/휴일 자동 감지 및 적절한 시간표 적용
- 실시간으로 남은 시간 표시

### 메모 시스템
- JSON 기반 로컬 저장
- 시간 설정 가능한 메모
- 날짜별 메모 관리
- 직관적인 편집/삭제 기능

### 운영시간 관리
- 시설별 운영시간 데이터 관리
- 실시간 운영 상태 표시
- 평일/휴일 구분 자동 적용

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

## 📞 문의

프로젝트에 대한 문의사항이나 버그 리포트는 이슈를 통해 제출해주세요.

---

**My Casey** - Camp Casey & Hovey 기지의 필수 앱 🚌✨
