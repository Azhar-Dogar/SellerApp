import '../Helper/ApiBaseHelper.dart';
import '../Widget/api.dart';

class HomeRepository {
  //This method is used to fetch System policies {e.g. Privacy Policy, T&C etc..}
  static Future<String> fetchSalesReport({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var grandFinalTotal =
          await ApiBaseHelper().postAPICall(getSalesListApi, parameter);
      String temp = grandFinalTotal["grand_final_total"];
      print("Result");
      print(temp);
      return temp;
    } on Exception {
      throw ApiException('Something went wrong');
    }
  }

  static Future<Map<String, dynamic>> fetchGetStatics({
    required Map<String, dynamic> parameter,
  }) async {
    try {
      var policy =
          await ApiBaseHelper().postAPICall(getStatisticsApi, parameter);
      print("Policy");
      print(policy);
       return policy;
    } on Exception {
      throw ApiException('Something went wrong');
    }
  }
}
