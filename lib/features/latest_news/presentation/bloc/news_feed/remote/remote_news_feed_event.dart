abstract class RemoteNewsFeedEvent {
  final String? query;

  const RemoteNewsFeedEvent({this.query});
}

class GetNewsFeed extends RemoteNewsFeedEvent {
  const GetNewsFeed({String? query}) : super(query: query);
}
