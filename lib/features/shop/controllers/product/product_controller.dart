import 'package:aura_kart_admin_panel/data/abstract/base_data_table_controlle.dart';
import 'package:aura_kart_admin_panel/features/shop/models/product_model.dart';
import 'package:aura_kart_admin_panel/features/shop/models/product_repositroy.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:get/get.dart';

class ProductController extends ABaseController<ProductModel> {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  @override
  Future<List<ProductModel>> fetchItems() async {
    return await _productRepository.getAllProducts();
  }

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.brand!.name.toLowerCase().contains(query.toLowerCase()) ||
        item.stock.toString().contains(query) ||
        item.price.toString().contains(query);
  }

  @override
  Future<void> deleteItem(ProductModel item) async {
    await _productRepository.deleteProduct(item);
  }

  // sorting related code
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (ProductModel product) => product.title.toLowerCase());
  }

  void sortByPrice(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (ProductModel product) => product.price);
  }

  void sortByStock(int sortColmunIndex, bool ascending) {
    sortByProperty(
        sortColmunIndex, ascending, (ProductModel product) => product.stock);
  }

  void sortBySoldItems(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,(ProductModel product) => product.soldQuantity);
  }

  /// Get the product price or price range for variation
  String getProductPrice(ProductModel product) {
    // if no variations exist,return the simple price or sale price
    if (product.productType == ProductType.single.toString() ||
        product.productVariations!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      double smallestPrice = double.infinity;
      double largestPrice = 0.0;
      // Calculate the Smallest and Largest price among variations
      for (var variation in product.productVariations!) {
        // Determine The Price to Consider (sale price if available,otherwise regular price)
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;
        // Update smallest and Largest Prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // If smallest and largest prices are the same,return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        // Otherwise,return a price range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  /// Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // calculate product stock
  String getProductStockTotal(ProductModel product) {
    return product.productType == ProductType.single.toString()
    ? product.soldQuantity.toString()
    : product.productVariations!.fold<int>(0, (previousValue, element) => previousValue + element.stock).toString();
  }

  // calculate products sold quantity
  String getProductSoldQuantity(ProductModel product) {
    return product.productType == ProductType.single.toString()
    ? product.soldQuantity.toString()
    : product.productVariations!.fold<int>(0, (previousValue, element) => previousValue + element.soldQuantity).toString();
  }

  /// Check Product Stock status
  String getProductStockStatus(ProductModel product) {
    return product.stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
