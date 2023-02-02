import 'package:fake_store/helper/item_data.dart';
import 'package:fake_store/helper/item_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);
  Total(providerItem) {
    double sum = 0;
    for (var i = 0; i < providerItem.basketItem.length; i++) {
      var num = providerItem.basketItem[i].price;
      sum += num;
    }
    return sum.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemList>(builder: (context, providerItem, child) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: providerItem.basketItem.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image(
                                  image: NetworkImage(
                                    providerItem.basketItem[index].image!,
                                  ),
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${index}${providerItem.basketItem[index].title}"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "\$ ${providerItem.basketItem[index].price.toString()}"),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              providerItem.deleteItem(index);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("Remove From Cart"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 30,
                ),
                providerItem.basketItem.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Total Price ${Total(providerItem)}"),
                                )),
                          )
                        ],
                      )
                    : Text("Cart is empty"),
              ],
            ),
          ),
        ),
      );
    });
  }
}
