import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_to_release_project/view_model/states.dart';

class BlocViewModel extends Cubit<BlocStates>{
  BlocViewModel():super(InitialLoadingState());

  requestToReleaseButton ()=>emit(RequestToReleaseState());



}