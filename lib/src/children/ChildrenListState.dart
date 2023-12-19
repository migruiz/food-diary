abstract class ChildrenListState{}
class LoadingChildrenListState extends ChildrenListState{

}

class LoadedChildrenListState extends ChildrenListState{
  final List<String> children;

  LoadedChildrenListState({required this.children});
}