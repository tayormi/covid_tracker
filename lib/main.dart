import 'package:covid_tracker/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'home.dart';
import 'simple_bloc_delegate.dart';
import 'utils/storageutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  
  final ApiRepository apiRepository = ApiRepository(apiClient: ApiClient());
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CaseBloc>(
      create: (context) => CaseBloc(apiRepository: apiRepository),
    ),
    BlocProvider<NewsBloc>(
      create: (context) => NewsBloc(apiRepository: apiRepository),
    ),
  ], child: MyApp(apiRepository: apiRepository,)));
}

class MyApp extends StatelessWidget {
  final ApiRepository apiRepository;

  const MyApp({Key key, @required this.apiRepository}) : assert(apiRepository != null), super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaseBloc, CaseState>(
      builder: (BuildContext context, CaseState state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocProvider(
            create: (context) => CaseBloc(apiRepository: apiRepository),
            child: Home(),
          ),
        );
      },
    );
  }
}
