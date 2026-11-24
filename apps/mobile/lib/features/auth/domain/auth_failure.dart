/// Errores de autenticación esperados, sin detalles del proveedor.
enum AuthFailure implements Exception {
  invalidCredentials,
  emailNotConfirmed,
  emailAlreadyInUse,
  weakPassword,
  invalidEmail,
  rateLimited,
  signupDisabled,
  network,
  unexpected,
}

/// Resultado de un registro.
enum SignUpOutcome {
  /// La cuenta quedó activa y con sesión iniciada.
  signedIn,

  /// Hay que confirmar el email antes de iniciar sesión.
  confirmationRequired,
}
