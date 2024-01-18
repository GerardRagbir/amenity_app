import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/RecModel.dart';

final recProvider = StateNotifierProvider<RecNotifier, Map<String, RecModel>>(
  (ref) {
    return RecNotifier();
  },
);

class RecNotifier extends StateNotifier<Map<String, RecModel>> {
  RecNotifier() : super({});

  void addProuctToFavorite({
    required String productName,
    required String productId,
    required List imageUrl,
    required num price,
    required List productSize,
  }) {
    state[productId] = RecModel(
      productName: productName,
      productId: productId,
      imageUrl: imageUrl,
    );

    ///notify listeners that the state has changed
    state = {...state};
  }

  void removeAllItems() {
    state.clear();

    ///notify listeners that the state has changed
    state = {...state};
  }

  void removeItem(String productId) {
    state.remove(productId);

    ///notify listeners that the state has changed
    state = {...state};
  }

  Map<String, RecModel> get getFavoriteItem => state;
}
