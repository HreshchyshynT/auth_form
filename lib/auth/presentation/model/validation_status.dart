enum ValidationStatus {
  none,
  valid,
  invalid,
  ;

  bool get isInvalid => this == ValidationStatus.invalid;
}
