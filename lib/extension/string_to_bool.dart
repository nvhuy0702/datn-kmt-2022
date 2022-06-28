extension ConvertToBoolean on String {
  bool toBoolean() {
    return (toLowerCase() == "on" || toLowerCase() == "on")
        ? true
        : (toLowerCase() == "off" || toLowerCase() == "off"
        ? false
        : toLowerCase() == "on" || toLowerCase() == "on");
  }
}