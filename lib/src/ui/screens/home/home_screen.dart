import 'package:covidapp/src/blocs/authentication/authentication_base.dart';
import 'package:covidapp/src/models/user.dart';
import 'package:covidapp/src/resources/authentication/authentication_repository.dart';
import 'package:covidapp/src/resources/db/db_repository.dart';
import 'package:covidapp/src/ui/screens/home/widgets/case_mini_card_widget.dart';
import 'package:covidapp/src/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final User _user;
  final AuthenticationRepository _authenticationRepository;
  final DbRepository _dbRepository;

  HomeScreen(
      {Key key,
      @required AuthenticationRepository authenticationRepository,
      @required User user,
      @required DbRepository dbRepository})
      : assert(authenticationRepository != null),
        assert(user != null),
        assert(dbRepository != null),
        _authenticationRepository = authenticationRepository,
        _user = user,
        _dbRepository = dbRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          preferredSize: Size.fromHeight(70.0),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              padding: EdgeInsets.symmetric(vertical: 40.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/wallpaper-home.jpg'),
                  fit: BoxFit.cover,
                )
              ),
              height: 400,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text('México',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CaseMiniCardWidget(
                                iconColor: Colors.red,
                                svgPath: 'assets/images/infected.svg',
                                text: 'Confirmados',
                                value: '600',
                              ),
                              CaseMiniCardWidget(
                                iconColor: Colors.yellow,
                                svgPath: 'assets/images/person.svg',
                                text: 'Bajo Riesgo',
                                value: '3900',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CaseMiniCardWidget(
                                iconColor: Colors.orange[700],
                                svgPath: 'assets/images/person.svg',
                                text: 'Alto Riesgo',
                                value: '300',
                              ),
                              CaseMiniCardWidget(
                                iconColor: Colors.blue,
                                svgPath: 'assets/images/person.svg',
                                text: 'Sin Riesgo',
                                value: '4900',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CaseMiniCardWidget(
                                iconColor: Colors.yellow[700],
                                svgPath: 'assets/images/person.svg',
                                text: 'En Riesgo',
                                value: '1500',
                              ),
                              CaseMiniCardWidget(
                                iconColor: Colors.green,
                                svgPath: 'assets/images/person.svg',
                                text: 'Recuperados',
                                value: '10',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      child: Text('Sign Out'),
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthenticationEvent.AuthenticationLoggedOut,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
