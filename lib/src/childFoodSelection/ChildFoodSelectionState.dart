// ignore_for_file: file_names


import 'FoodListItem.dart';

abstract class ChildFoodSelectionState{}
class LoadingChildFoodSelectionState extends ChildFoodSelectionState{

}

class LoadedChildFoodSelectionState extends ChildFoodSelectionState{
  final String childName;
  final String childPhotoUrl;
  final List<FoodListItem> foods;

  LoadedChildFoodSelectionState({required this.childName, required this.childPhotoUrl, required this.foods});
}