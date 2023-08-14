import 'package:expenses_app/models/features_model.dart';

class CategoryList {
  var catList = [
    FeaturesModel(
        category: 'Gasolina',
        color: '#087802',
        icon: 'local_gas_station_outlined'),
    FeaturesModel(
        category: 'SuperMercado',
        color: '#3F9BFC',
        icon: 'shopping_cart_outlined'),
    FeaturesModel(
        category: 'Restaurante',
        color: '#FF8605',
        icon: 'local_dining_outlined'),
    FeaturesModel(
      category: 'Hogar',
      color: '#853AFC',
      icon: 'home',
    ),
  ];
}
