import 'global_settings.dart';

const String kApiUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: kDefaultApiUrl,
);
const String kDefaultApiUrl = kIsProd ? kProdApiUrl : kDevApiUrl;
const String kProdApiUrl = '';
const String kDevApiUrl = 'http://www.randomnumberapi.com/api/v1.0/random';
