abstract class UserEvent {}

class LoadUserData extends UserEvent {
  final String uid;
  LoadUserData(this.uid);
}
