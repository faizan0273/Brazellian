import 'package:brazeellian_community/Models/jobModel.dart';
import 'package:brazeellian_community/Utils/utils.dart';
import 'package:brazeellian_community/ViewModel/user_preference/userPrefrenceViewModel.dart';
import 'package:brazeellian_community/constant/routes/routes_name.dart';
import 'package:brazeellian_community/data/response/status.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Models/signUpModel.dart';
import '../../repository/JobsListingRepository.dart';
import '../DefaultViewModel/DefaultViewModel.dart';

class JobsViewModel extends GetxController {
  DefaultViewModel defaultViewModel = Get.put(DefaultViewModel());
  final _api = JobsRepository();
  UserPreference userPreference = UserPreference();
  final categoryController = TextEditingController().obs ;
  final subcategoryController = TextEditingController().obs ;
  final advertiserNameController = TextEditingController().obs ;
  final approximateValueController = TextEditingController().obs ;
  final userIdFocusNode = FocusNode().obs;
  final titleFocusNode = FocusNode().obs;
  final descriptionFocusNode = FocusNode().obs;
  final postalCodeFocusNode = FocusNode().obs;
  final whatsappFocusNode = FocusNode().obs;
  final keywordsFocusNode = FocusNode().obs;
  final categoryFocusNode = FocusNode().obs;
  final subcategoryFocusNode = FocusNode().obs;
  final advertiserNameFocusNode = FocusNode().obs;
  final approximateValueFocusNode = FocusNode().obs;
  RxBool loading = false.obs;
  Future<void> addJobs() async {
    loading.value = true;
    UserLoginResponse user = await  userPreference.getUser();
    Map data = {
      "userId": user.id,
      "title": defaultViewModel.titleController.value.text.toString(),
      "description":defaultViewModel. descriptionController.value.text.toString(),
      "local":defaultViewModel. localController.value.text.toString(),
      "postalCode": defaultViewModel. postalCodeController.value.text.toString(),
      "whatsapp":defaultViewModel. whatsappController.value.text.toString(),
      "keywords":defaultViewModel.tags.value,
      "category": categoryController.value.text.toString(),
      "subcategory": subcategoryController.value.text.toString(),
      "advertiserName": advertiserNameController.value.text.toString(),
      "approximateValue": approximateValueController.value.text.toString(),
      "keywords":defaultViewModel.tags.value,
    };
    _api.addApi(data ,defaultViewModel.image , defaultViewModel.images).then((value) {
      if(value['message']=="success"){
        Get.delete<JobsViewModel>();
        Get.delete<DefaultViewModel>();
        Get.toNamed(RouteName.homeView)!.then((value){});
        Utils.snackBar('Note', 'Data uploaded successfully');
      }
      else{
        Utils.snackBar('Error', value["error"]);
      }
    });

  }
  final rxRequestStatus = Status.LOADING.obs ;
  final worksList =WorksResponse().obs ;
  RxString error = ''.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value ;
  void setEventList(WorksResponse _value) => worksList.value = _value ;
  void setError(String _value) => error.value = _value ;
  void getJobs(){
    _api.getApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      setEventList(WorksResponse.fromJson(value));
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);

    });
  }
  void refreshApi(){
    setRxRequestStatus(Status.LOADING);
    _api.getApi().then((value){
      setRxRequestStatus(Status.COMPLETED);
      setEventList(WorksResponse.fromJson(value));
    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);

    });
  }

}