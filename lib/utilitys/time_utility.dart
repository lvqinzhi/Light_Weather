class TimeUtil {
  static String getWeatherDate(String date) {
    date = date.replaceAll("-", "/");
    return date.substring(date.indexOf("/") + 1);
  }
}
