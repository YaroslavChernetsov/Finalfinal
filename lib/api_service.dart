import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sock_model.dart';

class ApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Sock>> getSocks() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('socks').get();
      return snapshot.docs
          .map((doc) => Sock.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching socks: $e');
    }
  }

  Future<Sock> getSockById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('socks').doc(id).get();
      return Sock.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Error fetching sock by ID: $e');
    }
  }

  Future<void> createSock(Sock sock) async {
    try {
      await _firestore.collection('socks').add(sock.toJson());
    } catch (e) {
      throw Exception('Error creating sock: $e');
    }
  }

  Future<void> updateSock(String id, Sock sock) async {
    try {
      await _firestore.collection('socks').doc(id).update(sock.toJson());
    } catch (e) {
      throw Exception('Error updating sock: $e');
    }
  }

  Future<void> deleteSock(String id) async {
    try {
      await _firestore.collection('socks').doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting sock: $e');
    }
  }

  Stream<List<Sock>> getSocksStream() {
    return _firestore.collection('socks').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Sock.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
