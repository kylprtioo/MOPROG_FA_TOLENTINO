class Profile {
  const Profile(this.text, this.info);

  final String text;
  final List<String> info;
  
  List<String> getShuffledList() {
  final shuffledList = List<String>.from(info);
  shuffledList.shuffle();

  return shuffledList;
}
}