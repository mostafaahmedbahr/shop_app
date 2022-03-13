import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_final/dio/dio_helper/dio_helper.dart';
import 'package:shop_app_final/dio/dio_helper/end_points.dart';
import 'package:shop_app_final/models/search_model.dart';
import 'package:shop_app_final/modules/search/bloc/states.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit(): super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? searchModel;

  void search({
  required String text,
})
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: TOKEN,
        data: {
         "text" : text,
        },
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
     emit(SearchSuccessState());
    }).catchError((error)
    {
      print("error in search data ${error.toString()}");
      emit(SearchErrorState());
    });
  }
}