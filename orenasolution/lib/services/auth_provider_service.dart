import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProviderService{
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthProviderService._();

  static AuthProviderService instance = AuthProviderService._();
  Future<void> SignIn() async{
  GoogleSignInAccount signInAccount = await GoogleSignIn().signIn();
  GoogleSignInAuthentication authentication = await signInAccount.authentication;
  AuthCredential credential = GoogleAuthProvider.credential(
    idToken: authentication.idToken,
    accessToken: authentication.accessToken,
  );
  await _auth.signInWithCredential(credential);
  }
  Future<void> SignOut() async{
    if(user!=null){
    await _auth.signOut();
    }
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
    //await _auth.signOut();
  }
  User get user => _auth.currentUser;
}