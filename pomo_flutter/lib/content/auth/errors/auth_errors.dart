class AuthErrors implements Exception {
  final String message;

  const AuthErrors([this.message = "autherror_unknown"]);

  factory AuthErrors.fromCode(String code) {
    switch (code) {
      case "email-already-in-use":
        return const AuthErrors("autherror_email-already-in-use");
      case "invalid-email":
        return const AuthErrors("autherror_invalid-email");
      case "operation-not-allowed":
        return const AuthErrors("autherror_operation-not-allowed");
      case "weak-password":
        return const AuthErrors("autherror_weak-password");
      case "user-disabled":
        return const AuthErrors("autherror_user-disabled");
      case "user-not-found":
        return const AuthErrors("autherror_user-not-found");
      case "wrong-password":
        return const AuthErrors("autherror_wrong-password");
      case "too-many-requests":
        return const AuthErrors("autherror_too-many-requests");
      case "invalid-login-credentials":
        return const AuthErrors("autherror_invalid-login-credentials");
      default:
        return const AuthErrors();
    }
  }
}
