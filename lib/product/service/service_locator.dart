
import 'package:flutter_base_start/product/service/services/dio_service.dart';
import 'package:flutter_base_start/product/service/services/logger_service.dart';
import 'package:get_it/get_it.dart';

// GetIt paketinden bir instance (tekil örnek) oluşturuluyor.
// Bu instance, uygulama genelinde servisleri tek bir yerden yönetmeyi sağlar.
final GetIt locator = GetIt.instance;

// Bu fonksiyon, uygulama başlatılırken çağrılır ve
// servislerin kaydını (register) başlatır.
void setupLocator() {
  _registerSingletons();
}

// Bu fonksiyon içinde uygulamada tek bir kez oluşturulacak (singleton)
// servisler tanımlanır.
void _registerSingletons() {
  //  hata, uyarı, bilgi gibi log mesajlarını yazmak için kullanılır.
  locator.registerSingleton<LoggerService>(LoggerService());

  //bu kısmı ileride gerçek bir API adresin olduğunda açabilirsin.
  // ..registerSingleton<LoggerService>(LoggerService())
  // ..registerSingleton<HTTPService>(
  //   HTTPService(
  //     baseUrl: 'akillisletme',   // ❌ Geçerli bir URL değil, bu yüzden hata verir.
  //     apiKey: 'akillisletme',    // Örnek amaçlı sabit API anahtarı.
  //     dio: Dio(),                // Dio nesnesi HTTP istekleri yapmak için kullanılır.
  //   ),
  // );
}

// Şu anda boş ama ilerde "lazy singleton" tanımlamak için kullanılabilir.
// Lazy singleton: sadece ilk kez ihtiyaç duyulduğunda oluşturulan servistir.
// void _registerLazySingletons() {}

// Bu da ilerde "factory" tipi kayıtlar için kullanılabilir.
// Factory: her çağrıldığında yeni bir nesne döndürür.
// void _registerFactories() {}

// Bu extension, locator üzerinden kısa yoldan servislere erişmeyi sağlar.
// Örneğin: locator.logger veya locator.http
extension ServiceLocator on GetIt {
  LoggerService get logger => locator<LoggerService>();
  HTTPService get http => locator<HTTPService>();
}


//locator.logger.e('AppInitialize error: $error ');
