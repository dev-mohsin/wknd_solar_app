import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wknd_app/core/constant/app_key.dart';
import 'package:wknd_app/feature/auth/data/models/user.dart';
import 'package:wknd_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:wknd_app/feature/refer/data/models/refer_model.dart';

part 'refer_event.dart';

part 'refer_state.dart';

class ReferBloc extends Bloc<ReferEvent, ReferState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  ReferBloc() : super(ReferInitial()) {
    on<OnRefer>(_onRefer);
    on<FetchRefer>(_onFetchRefer);
  }

  Future<void> _onRefer(OnRefer event, Emitter<ReferState> emit) async {
    try {
      emit(ReferLoading());
      await _firestore.collection(AppKey.refers).add(event.refer.toJson());
      emit(ReferCreatedSuccess('Refer added successfully'));
    } catch (e, s) {
      debugPrint('ReferBloc._onRefer: error: $e, stack: $s');
      emit(ReferFailure('Failed to load refers'));
    }
  }

  Future<void> _onFetchRefer(FetchRefer event, Emitter<ReferState> emit) async {
    try {
      emit(ReferLoading());
      // create a query to fetch all refer
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection(AppKey.refers).where('userId',isEqualTo: event.userId,).get();
      final List<ReferModel> refers = querySnapshot.docs.map((e) => ReferModel.fromJson(e.data())).toList();

      emit(ReferLoadedSuccess(refers));
    } catch (e, s) {
      debugPrint('ReferBloc._onFetchRefer: error: $e, stack: $s');
      emit(ReferFailure('Failed to load refers'));
    }
  }
}



  

