import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:wknd_app/core/constant/app_key.dart';
import 'package:wknd_app/feature/auth/data/models/user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthInitial()) {
    on<SignUp>(_onSignup);
    on<SignIn>(_onSignIn);
  }

  FutureOr<void> _onSignup(SignUp event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.user.email,
        password: event.password,
      );
      final UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: event.user.email,
        firstName: event.user.firstName,
        lastName: event.user.lastName,
        phoneNumber: event.user.phoneNumber,
        serviceType: event.user.serviceType,
        howMuch: event.user.howMuch,
        refFirstName: event.user.refFirstName,
        refLastName: event.user.refLastName,
        message: event.user.message,
      );
      if (userCredential.user != null) {
        await _firestore.collection(AppKey.users).doc(userCredential.user!.uid).set(user.toJson());
      }
      emit(SignUpSuccess(user));
    } catch (e, s) {
      debugPrint('AuthBloc._onSignup: error: $e stack: ${s}');
      emit(SignUpFailure(e.toString()));
    }
  }

  FutureOr<void> _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore.collection(AppKey.users).doc(userCredential.user!.uid).get();
      final UserModel user = UserModel.fromJson(userDoc.data()!);
      emit(SignInSuccess(user));
    } catch (e, s) {
      debugPrint('AuthBloc._onSignIn: error: $e stack: ${s}');
      emit(SignInFailure(e.toString()));
    }
  }
}
