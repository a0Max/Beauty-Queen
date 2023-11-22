// ignore_for_file: file_names, invalid_use_of_protected_member

import 'package:get/get.dart';

class FilterController extends GetxController {
  final selected = <String>{}.obs;
  // void toggleChip(String label) {
  //   if (selected.contains(label)) {
  //     selected.remove(label);
  //   } else {
  //     selected.add(label);
  //   }
  // }

  // bool isChipSelected(String label) {
  //   return selected.contains(label);
  // }

  //////////////////filter ///////////////////////
  RxList<Map<String, dynamic>> chipData = [
    {
      'label': 'الوجه',
    },
    {
      'label': 'الحواجب',
    },
    {
      'label': 'العيون',
    },
    {
      'label': 'الشفاه',
    },
    {
      'label': 'برايمر',
    },
    {
      'label': 'كريم أساس',
    },
    {
      'label': 'خافي عيوب',
    },

    // Add more chip data as needed
  ].obs;

  RxString selectedFilter = ''.obs;
  RxBool isAscending = true.obs;

  void filterData(String filter) {
    selectedFilter.value = filter;
  }

  void sortData() {
    isAscending.value = !isAscending.value;
    chipData.value.sort((a, b) => isAscending.value
        ? a['label'].compareTo(b['label'])
        : b['label'].compareTo(a['label']));
  }

  ///////////////
  RxList<Map<String, dynamic>> chipData2 = [
    {
      'label': 'التصنيف حسب',
    },
    {
      'label': 'المضاف حديثاً',
    },
    {
      'label': 'الأكثر مبيعاً',
    },
    {
      'label': 'السعر من أقل الي الأعلي',
    },
    {
      'label': 'السعر من الأعلي أقل الي',
    },

    // Add more chip data as needed
  ].obs;
  RxString selectedFilter2 = ''.obs;
  RxBool isAscending2 = true.obs;

  void filterData2(String filter) {
    selectedFilter.value = filter;
  }

  final selected2 = <String>{}.obs;
  void toggleChip2(String label) {
    if (selected2.contains(label)) {
      selected2.remove(label);
    } else {
      selected.add(label);
    }
  }

  bool isChipSelected2(String label) {
    return selected2.contains(label);
  }

  /////////////////////////////////////////////////
  final RxSet<String> selectedFilters = <String>{}.obs;
  final RxMap subCategories = {}.obs;

  void toggleChip(String label) {
    if (selectedFilters.contains(label)) {
      selectedFilters.remove(label);
    } else {
      selectedFilters.add(label);
    }
  }

  bool isChipSelected(String label) {
    return selectedFilters.contains(label);
  }

  void addSubCategories(String filter, List<String> categories) {
    subCategories[filter] = categories;
  }

  void clearSubCategories() {
    subCategories.clear();
  }

  void selectSubCategory(String filter, String subCategory) {
    final List<String> currentSubCategories = subCategories[filter] ?? [];
    if (currentSubCategories.contains(subCategory)) {
      currentSubCategories.remove(subCategory);
    } else {
      currentSubCategories.clear();
      currentSubCategories.add(subCategory);
    }
    subCategories[filter] = currentSubCategories;
  }

  bool isSubCategorySelected(String filter, String subCategory) {
    final List<String> currentSubCategories = subCategories[filter] ?? [];
    return currentSubCategories.contains(subCategory);
  }

  //////////////////////////
  final selectedLabel = "المكياج".obs;

  void updateSelectedLabel(String label) {
    selectedLabel.value = label;
  }

  //////////////////////////method for change state of sub catergories/////////////
  RxInt selectedIndex = RxInt(-1); // -1 means no selection
  RxList<String> subcategories = <String>[].obs;

  void updateSubcategories(int index) {
    switch (index) {
      case 0:
        subcategories.assignAll(['برايمر', 'كريم أساس', 'خافي عيوب', 'الشفاه']);
        break;
      case 1:
        subcategories.assignAll(['برايمر', 'كريم أساس', 'خافي عيوب', 'الشفاه']);
        break;
      case 2:
        subcategories.assignAll(['برايمر', 'كريم أساس', 'خافي عيوب', 'الشفاه']);
        break;
      case 3:
        subcategories.assignAll(['برايمر', 'كريم أساس', 'خافي عيوب', 'الشفاه']);
        break;
      case 4:
        subcategories.assignAll(['برايمر', 'كريم أساس', 'خافي عيوب', 'الشفاه']);
        break;
      default:
        subcategories.assignAll([]);
    }
  }
}
