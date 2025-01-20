
sealed class ImageEvent {}

class GetImageEvent extends ImageEvent {
  final String url;

  GetImageEvent({required this.url});
}