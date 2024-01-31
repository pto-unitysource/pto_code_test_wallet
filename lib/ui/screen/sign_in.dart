import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:pto_code_test_wallet/bloc/auth/auth_bloc.dart';
import 'package:pto_code_test_wallet/ui/screen/home_page.dart';
import 'package:pto_code_test_wallet/util/file_path.dart';

import 'drawer_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static DateTime now = DateTime.now();
  String formattedTime = DateFormat.jm().format(now);
  String formattedDate = DateFormat('MMM d, yyyy | EEEE').format(now);


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(mainBanner),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _topContent(),
                    _centerContent(),
                    _bottomContent(),
                    const SizedBox(height: 50,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        Row(
          children: <Widget>[
            Text(
              formattedTime,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              width: 30,
            ),
            SvgPicture.asset(cloud),
            const SizedBox(
              width: 8,
            ),
            Text(
              '34° C',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    );
  }

  Widget _centerContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SvgPicture.asset(logo),
          const SizedBox(
            height: 18,
          ),
          Text(
            'PTO Wallet',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            'Open An Account For Digital  E-Wallet Solutions.\nInstant Payouts. \n\nJoin For Free.',
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }

  Widget _bottomContent() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      shadowColor: Color(0xffFFAC30),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state){
          if(state is Authenticated){
            Get.to(() => DrawerPage());
          }

          if(state is AuthError){
            print("auth error");
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state){
            if(state is AuthLoading){
              return MaterialButton(
                elevation: 0,
                color: const Color(0xFFFFFFFF),
                height: 60,
                minWidth: 200,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onPressed: () {

                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoActivityIndicator(
                      color: Color(0xffFFAC30),
                    ),
                  ],
                ),
              );
            }

            if(state is UnAuthenticated){
              return MaterialButton(
                elevation: 0,
                color: const Color(0xFFFFFFFF),
                height: 60,
                // minWidth: 200,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  _authenticateWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Brand(Brands.google),
                    const SizedBox(width: 10,),
                    Text(
                      'Sign in with Google',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ],
                ),
              );
            }

            return MaterialButton(
              elevation: 0,
              color: const Color(0xFFFFFFFF),
              height: 60,
              // minWidth: 200,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                _authenticateWithGoogle(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Brand(Brands.google),
                  const SizedBox(width: 10,),
                  Text(
                    'Sign in with Google',
                    style: Theme.of(context).textTheme.button,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
