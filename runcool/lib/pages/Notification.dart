class Notification {
  String _user = 'me';

  String getUser() {
    return _user;
  }
}

class FriendRequest extends Notification {
  String _friend = 'Joshua Tan';
}

class EventInvite extends Notification {
  String _event = 'Some Event';
  int _nMessages = 1;
  int _nUpdates = 1;
}
