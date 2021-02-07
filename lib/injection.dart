import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:uniplan/injection.config.dart';

// Get GetIt instance
final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection(String env) {
  $initGetIt(getIt, environment: env);
}
