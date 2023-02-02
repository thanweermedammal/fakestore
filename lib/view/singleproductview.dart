import 'package:fake_store/controller/fetch_singleproduct.dart';
import 'package:fake_store/helper/item_data.dart';
import 'package:fake_store/helper/item_list.dart';
import 'package:fake_store/model/singleproduct_model.dart';
import 'package:fake_store/view/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SingleProductView extends StatefulWidget {
  var id;

  SingleProductView({Key? key, required this.id}) : super(key: key);

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  Future<SingleProduct>? fetchSingleProducts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSingleProducts = FetchSingleProduct().fetchProject(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemList>(builder: (context, providerItem, child) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 3),
                        child: Text(
                          'Cart',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            )
          ],
        ),
        body: FutureBuilder<SingleProduct>(
          future: fetchSingleProducts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: NetworkImage(snapshot.data!.image),
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(snapshot.data!.title),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: snapshot.data!.rating.rate,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("${snapshot.data!.rating.rate} ratings"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\$ ${snapshot.data!.price}",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data!.description,
                          style: TextStyle(wordSpacing: 1),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              providerItem.addItem(ItemData(
                                  title: snapshot.data!.title,
                                  price: snapshot.data!.price,
                                  image: snapshot.data!.image));
                              Fluttertoast.showToast(
                                  msg: "Added to cart",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8),
                                child: Text(
                                  "Add To Cart",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    });
  }
}
