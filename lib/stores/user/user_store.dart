import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:safewalk/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:safewalk/utils/dio/dio_error_util.dart';

import '../../data/repository.dart';
import '../form/form_store.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // bool to check if current user is logged in
  bool isLoggedIn = false;
  bool isGoogleLoggedIn = false;
  bool isManualLoggedIn = false;

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : this._repository = repository {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    repository.isLoggedIn.then((value) {
      this.isLoggedIn = value;
    });
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<bool> emptyLoginResponse =
      ObservableFuture.value(false);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  FirebaseAuth? firebaseUser = FirebaseAuth.instance;

  @observable
  ObservableFuture<bool> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future login(String email, String password) async {
    final future = _repository.login(email, password);
    loginFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value) {
        _repository.saveIsLoggedIn(true);
        this.isLoggedIn = true;
        this.isManualLoggedIn = true;
        this.success = true;
      } else {
        print('failed to login');
      }
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await _auth.signInWithCredential(credential);

        // final User user = authResult.user!;

        User user = await FirebaseAuth.instance.currentUser!;

        // check if the user is a first-time user
        DateTime? creationTime = user.metadata.creationTime;
        DateTime? lastSignInTime = user.metadata.lastSignInTime;
        if (lastSignInTime!.difference(creationTime!) < Duration(minutes: 1)) {
          print('first time user');
          registerGoogle(
            firebaseUser!.currentUser!.uid,
            firebaseUser!.currentUser!.email!,
            firebaseUser!.currentUser!.displayName!,
            'not set',
            firebaseUser!.currentUser!.photoURL!,
          );
        } else {
          print('returning user');
          print(user.metadata.creationTime);
          print(user.metadata.lastSignInTime);
        }
      }

      _repository.saveIsLoggedIn(true);
      this.isLoggedIn = true;
      this.isGoogleLoggedIn = true;
      this.success = true;
      this.firebaseUser = _auth;
    } catch (e) {
      print('Error signing in with Google: $e');
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    }
  }

  @action
  Future registerManual(
      String username,
      String email,
      String password,
      String first_name,
      String last_name,
      String mobile_number,
      String photo_url) async {
    final future = _repository.registerManual(
      username,
      email,
      password,
      first_name,
      last_name,
      mobile_number,
      photo_url,
    );

    future.then((value) async {
      print(value);
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.isManualLoggedIn = false;
      this.success = false;
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }

  @action
  Future registerGoogle(
    String google_uid,
    String email,
    String name,
    String mobile_number,
    String photo_url,
  ) async {
    final future = _repository.registerGoogle(
      google_uid,
      email,
      name,
      mobile_number,
      photo_url,
    );
    // loginFuture = ObservableFuture();

    future.then((value) async {
      print(value);
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.isGoogleLoggedIn = false;
      this.success = false;
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }

  @action
  Future<void> signInWithFacebook() async {
    // TODO - implement facebook login
  }

  @action
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    this.isLoggedIn = false;
    this.isGoogleLoggedIn = false;
    this.isManualLoggedIn = false;
    _repository.saveIsLoggedIn(false);
    this.firebaseUser = null;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
