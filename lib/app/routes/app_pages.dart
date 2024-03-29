import 'package:cdc/app/modules/fasilitas/bindings/tracer_study_binding.dart';
import 'package:cdc/app/modules/fasilitas/views/menu_quisioner.dart';
import 'package:cdc/app/modules/home/views/home2_view.dart';
import 'package:cdc/app/modules/quisioner/bindings/paket_quesioner_binding.dart';
import 'package:cdc/app/modules/quisioner/views/paket_questioner_view.dart';
import 'package:get/get.dart';

import '../modules/aktifasi/bindings/aktifasi_binding.dart';
import '../modules/aktifasi/views/aktifasi_view.dart';
import '../modules/all_berita/bindings/all_berita_binding.dart';
import '../modules/all_berita/views/all_berita_view.dart';
import '../modules/alumni/bindings/alumni_binding.dart';
import '../modules/alumni/views/alumni_view.dart';
import '../modules/detail_alumni/bindings/detail_alumni_binding.dart';
import '../modules/detail_alumni/views/detail_alumni_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/fasilitas/bindings/fasilitas_binding.dart';
import '../modules/fasilitas/views/fasilitas_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/ikapj/bindings/ikapj_binding.dart';
import '../modules/ikapj/views/ikapj_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/posting/bindings/posting_binding.dart';
import '../modules/posting/views/posting_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/quisioner/bindings/quisioner_binding.dart';
import '../modules/quisioner/views/quisioner_view.dart';
import '../modules/recovery_password/bindings/recovery_password_binding.dart';
import '../modules/recovery_password/views/recovery_password_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tab_followers/bindings/tab_followers_binding.dart';
import '../modules/tab_followers/views/tab_followers_view.dart';
import '../modules/tab_followers_user/bindings/tab_followers_user_binding.dart';
import '../modules/tab_followers_user/views/tab_followers_user_view.dart';
import '../modules/update_post/bindings/update_post_binding.dart';
import '../modules/update_post/views/update_post_view.dart';
import '../modules/verifikasi/bindings/verifikasi_binding.dart';
import '../modules/verifikasi/views/verifikasi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView2(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.RECOVERY_PASSWORD,
      page: () => RecoveryPasswordView(),
      binding: RecoveryPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFIKASI,
      page: () => VerifikasiView(),
      binding: VerifikasiBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.AKTIFASI,
      page: () => AktifasiView(),
      binding: AktifasiBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.ALUMNI,
      page: () => AlumniView(),
      binding: AlumniBinding(),
    ),
    GetPage(
      name: _Paths.POSTING,
      page: () => PostingView(),
      binding: PostingBinding(),
    ),
    GetPage(
      name: _Paths.IKAPJ,
      page: () => IkapjView(),
      binding: IkapjBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FASILITAS,
      page: () => FasilitasView(),
      binding: FasilitasBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ALUMNI,
      page: () => DetailAlumniView(),
      binding: DetailAlumniBinding(),
    ),
    GetPage(
      name: _Paths.TAB_FOLLOWERS,
      page: () => TabFollowersView(),
      binding: TabFollowersBinding(),
    ),
    GetPage(
      name: _Paths.QUISIONER,
      page: () => QuisionerView(),
      binding: QuisionerBinding(),
    ),
    GetPage(
      name: _Paths.TAB_FOLLOWERS_USER,
      page: () => const TabFollowersUserView(),
      binding: TabFollowersUserBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_POST,
      page: () => UpdatePostView(),
      binding: UpdatePostBinding(),
    ),
    GetPage(
      name: _Paths.ALL_BERITA,
      page: () => AllBeritaView(),
      binding: AllBeritaBinding(),
    ),
    GetPage(
      name: _Paths.MENU_QUISIONER,
      page: () => const MenuQuisioner(),
      binding: TracerStudyBinding(),
    ),
    GetPage(
      name: _Paths.PAKET_QUISIONER,
      page: () => const PaketQuesionerView(),
      binding: PaketQuesionerBinding(),
    ),
  ];
}
