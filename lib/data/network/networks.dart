import 'package:demo_navigator/constants/shared_preference_constant.dart';
import 'package:demo_navigator/constants/api_constant.dart';
import 'package:demo_navigator/share/sharepreferent/spref.dart';
import 'package:dio/dio.dart';

class BookClient {
  static BaseOptions _options = BaseOptions(
    baseUrl: APIConstant.BASE_URL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static BaseOptions _uploadOptions = BaseOptions(
    baseUrl: APIConstant.UPLOAD_FILE,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static BaseOptions _externalVipOptions = BaseOptions(
      baseUrl: APIConstant.EXTERNAL_VIP,
      connectTimeout: 5000,
      receiveTimeout: 3000);
  static Dio _dio = Dio(_options);
  static Dio _uploadDio = Dio(_uploadOptions);
  static Dio _externalVipDio = Dio(_externalVipOptions);
  static final BookClient instance = BookClient._internal();
  static final BookClient uploadInstance = BookClient._uploadInternal();

  Dio get dio => _dio;

  Dio get dioUploadFile => _uploadDio;

  Dio get externalVipDio => _externalVipDio;

  BookClient._internal() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options myOptions) async {
      var token = await SPref.instance.get(SharedPreferenceConstant.KEY_TOKEN);
      if (token != null) {
        myOptions.headers["Authorization"] = token;
        print(token);
      }
      return myOptions;
    }));
  }

  BookClient._uploadInternal() {
    _uploadDio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      var token = await SPref.instance.get(SharedPreferenceConstant.KEY_TOKEN);
      if (token != null) {
        options.headers["Authorization"] = token;
        print(token);
      }
      return options;
    }));
  }

  BookClient._externalVipInternal() {
    _externalVipDio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      var token = await SPref.instance.get(SharedPreferenceConstant.KEY_TOKEN);
      if (token != null) {
        options.headers["Authorization"] = token;
        print(token);
      }
      return options;
    }));
  }
}
