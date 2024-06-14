import '../Model/audio_model.dart'

class AudioController {
    List<AudioModel> _list =[] ;
    List<AudioModel> get list => _list;

    final FirebaseFirestore _firestore = new FirebaseFirestore;

    //fetchFrom Firestore
    Future<void> fetchFromFireStore() async{
    QuerySnapshot querySnapshot = await _firestore.collection('audio').get();
    List<dynamic> results = querySnapshot.docs as List;
    _list = results.map((doc) => AudioModel.fromMap(doc.data())).toList();
    
    }

}