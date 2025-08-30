
import 'package:dashboard/models/year_model.dart';
import 'package:dashboard/services/year_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class YearController extends GetxController {
  final _service = YearService();

  final years = <YearModel>[].obs;
  final isLoading = false.obs;
  final isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchYears();
  }

  Future<void> fetchYears() async {
    try {
      isLoading.value = true;
      final list = await _service.fetchYears();
      years.assignAll(list);
    } catch (e) {
      Get.snackbar('erro', 'Falid to load data $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addYear({
    required String name,
    required String startDate,
    required String endDate,
  }) async {
    try {
      isSubmitting.value = true;

     
      final created = await _service.createYear(
        YearModel(name: name, startDate: startDate, endDate: endDate),
      );

      
      years.insert(0, created);

      Get.snackbar('ok', 'A year has been added successfully.(ID: ${created.id ?? "-"})');
    } catch (e) {
      Get.snackbar('error', '  Falid to add the  year: $e');
    } finally {
      isSubmitting.value = false;
    }
  }
}