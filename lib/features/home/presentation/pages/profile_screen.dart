import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone_app/core/util/show_message.dart';
import 'package:instagram_clone_app/features/auth/presentation/pages/signin_page.dart';
import 'package:instagram_clone_app/features/home/presentation/bloc/signout_cubit/signout_cubit.dart';
import 'package:instagram_clone_app/features/home/presentation/bloc/signout_cubit/signout_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kerimkulov_b'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/instagram_add_new_post_icon.svg',
              height: 24,
              width: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/three-horizontal-lines-icon.svg',
              height: 20,
              width: 20,
            ),
          ),
        ],
      ),
      body: BlocConsumer<SignoutCubit, SignoutState>(
        listener: (context, state) {
          if (state is SignoutSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginPage()),
            );
          } else if (state is SignoutErrorState) {
            showMessage(
              context,
              message: 'Something went wrong. Try one more time',
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ProfileScreen'),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignoutCubit>().signOut();
                  },
                  child: state is SignoutLoadingState
                      ? CircularProgressIndicator()
                      : Text('Sign out'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
