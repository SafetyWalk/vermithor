// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_UserStore.isLoading'))
      .value;

  late final _$successAtom = Atom(name: '_UserStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$firebaseUserAtom =
      Atom(name: '_UserStore.firebaseUser', context: context);

  @override
  FirebaseAuth? get firebaseUser {
    _$firebaseUserAtom.reportRead();
    return super.firebaseUser;
  }

  @override
  set firebaseUser(FirebaseAuth? value) {
    _$firebaseUserAtom.reportWrite(value, super.firebaseUser, () {
      super.firebaseUser = value;
    });
  }

  late final _$loginFutureAtom =
      Atom(name: '_UserStore.loginFuture', context: context);

  @override
  ObservableFuture<bool> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<bool> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_UserStore.login', context: context);

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$signInWithGoogleAsyncAction =
      AsyncAction('_UserStore.signInWithGoogle', context: context);

  @override
  Future<void> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  late final _$registerManualAsyncAction =
      AsyncAction('_UserStore.registerManual', context: context);

  @override
  Future<dynamic> registerManual(
      String username,
      String email,
      String password,
      String first_name,
      String last_name,
      String mobile_number,
      String photo_url) {
    return _$registerManualAsyncAction.run(() => super.registerManual(username,
        email, password, first_name, last_name, mobile_number, photo_url));
  }

  late final _$registerGoogleAsyncAction =
      AsyncAction('_UserStore.registerGoogle', context: context);

  @override
  Future<dynamic> registerGoogle(String google_uid, String email, String name,
      String mobile_number, String photo_url) {
    return _$registerGoogleAsyncAction.run(() => super
        .registerGoogle(google_uid, email, name, mobile_number, photo_url));
  }

  late final _$signInWithFacebookAsyncAction =
      AsyncAction('_UserStore.signInWithFacebook', context: context);

  @override
  Future<void> signInWithFacebook() {
    return _$signInWithFacebookAsyncAction
        .run(() => super.signInWithFacebook());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_UserStore.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
success: ${success},
firebaseUser: ${firebaseUser},
loginFuture: ${loginFuture},
isLoading: ${isLoading}
    ''';
  }
}
