import 'package:localstore/localstore.dart';

class LocalStorage {
  final db = Localstore.instance;

  setAuthTokens(authData) {
    db.collection('auth').doc('auth-tokens').set(authData);
  }

  getAuthTokens() async {
    return await db.collection('auth').doc('auth-tokens').get();
  }

  clearAuthTokens() async {
    return await db.collection('auth').doc('auth-tokens').delete();
  }
}
