// ignore_for_file: file_names

import 'ChildInfoListItem.dart';

abstract class ChildrenListState{}
class LoadingChildrenListState extends ChildrenListState{

}

class LoadedChildrenListState extends ChildrenListState{
  final List<ChildInfoListItem> children;

  LoadedChildrenListState({required this.children});
}