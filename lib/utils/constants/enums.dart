// They cannot be created inside a class.

enum AppRole { admin, user }

enum TransactionType { buy, sell }

enum ProductType { single, variable }

enum ProductVisibility { published, hidden }

enum TextSizes { small, medium, large }

enum ImageType { asset, network, memory, file }

enum MediaCategory { folders, banners, brands, categories, products, users, arproducts }

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm 
}
