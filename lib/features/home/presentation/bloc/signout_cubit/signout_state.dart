class SignoutState {
  const SignoutState();
}

class InitialState extends SignoutState {}

class SignoutErrorState extends SignoutState {}

class SignoutLoadingState extends SignoutState {}

class SignoutSuccessState extends SignoutState {}
