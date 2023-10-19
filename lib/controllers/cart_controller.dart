import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _item = {};

  Map<int, CartModel> get item => _item;

  //List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_item.containsKey(product.id)) {
      _item.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _item.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _item.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar("item count,", " it can't be 0",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }

    cartRepo.addToCartList(getItems);

    update();
  }

  bool existIncart(ProductModel product) {
    if (_item.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_item.containsKey(product.id)) {
      _item.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }

    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _item.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _item.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _item.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    List<CartModel> storageItems = cartRepo.getCartList();
    for (int i = 0; i < storageItems.length; i++) {
      _item.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
    return storageItems;
  }

  /* List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _item.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  } */

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _item = {};
    update();
  }
}
