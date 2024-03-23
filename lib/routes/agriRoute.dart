class agriRoute{
  static const String serverAddress= '192.168.1.21';
  static const String baseUrl = 'http://${serverAddress}/agri_hub/';
  static const String createUserUrl = '${baseUrl}authentication.php';
  static const String agriInfoUrl = '${baseUrl}agriInfo.php';
  static const String productUrl = '${baseUrl}productDetails.php';
  static const String imageUrl = '${baseUrl}product/';
  static const String reportUrl = '${baseUrl}issueDetails.php';
  static const String cartUrl = '${baseUrl}cart.php';
  static const String purchaseUrl = '${baseUrl}purchase.php';
  static const String reviewUrl = '${baseUrl}review.php';

}