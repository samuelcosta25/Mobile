class AudioModel {
    // Atributos
    final String title;
    final String artist;
    final String url;

    // Constructor
    AudioModel(this.title, this.artist, this.url);

    //fromMap
    factory AudioModel.fromMap(Map<String, dynamic> map) {
        return AudioModel(
            map['title'], map['artist'], map['url']);
    }
}