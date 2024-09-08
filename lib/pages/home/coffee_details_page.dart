import 'dart:async';

import 'package:HexagonWarrior/pages/account/account_controller.dart';
import 'package:HexagonWarrior/pages/home/share_coffee_bottom_sheet.dart';
import 'package:HexagonWarrior/theme/app_colors.dart';
import 'package:HexagonWarrior/utils/ui/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/resorces_list.dart';

class CoffeeDetailsPage extends StatefulWidget {

  final Coffee coffee;

  const CoffeeDetailsPage(this.coffee, {super.key});

  @override
  State<CoffeeDetailsPage> createState() => _CoffeeDetailsPageState();
}

class _CoffeeDetailsPageState extends State<CoffeeDetailsPage> {

  var s = true;
  var m = false;
  var l = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            child: SizedBox(
              height: context.height * .65,
              width: context.width,
              child: Stack(
                children: [
                  Positioned.fill(child: Image(image: widget.coffee.image, fit: BoxFit.cover)),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin:
                      const EdgeInsets.only(top: 50, left: 20, right: 20),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.white.withOpacity(.6),
                            ),
                          ), onTap: (){
                            Get.back();
                          }),
                          InkWell(child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                  Icons.save_alt,
                                  color: Colors.orange
                              )
                          ), onTap: () {
                            Get.bottomSheet(ShareCoffeeBottomSheet(coffee: widget.coffee, size: s ? "S" : m ? "M" : "L"), isScrollControlled: true);
                          })
                        ],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 30, right: 30, left: 30),
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.6),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.coffee.name,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.none),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(widget.coffee.mix, style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white.withOpacity(.5),
                                            decoration: TextDecoration.none)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(s ? widget.coffee.ratting.toString() : m ? widget.coffee.mediumRating.toString() : widget.coffee.largeRating.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          s ? widget.coffee.prefix : m
                                              ? widget.coffee.prefixMedium
                                              : widget.coffee.prefixLarge,
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(.5),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.coffee,
                                              color: Colors.orange,
                                            ),
                                            Text(
                                              "Coffee",
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(.5),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.water_drop_rounded,
                                              color: Colors.orange,
                                            ),
                                            Text(
                                              "Milk",
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(.5),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 40,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      s
                                          ? "Small Roasted"
                                          : m
                                          ? "Medium Roasted"
                                          : "Large Roasted",
                                      style: TextStyle(
                                          color: Colors.white
                                              .withOpacity(.5),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "Description",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "A cappuccino is the perfect balance of espresso, steamed milk. This coffee is all about the structure.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Size",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        s = true;
                        m = false;
                        l = false;
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                            color: s ? Colors.black : Theme.of(context).colorScheme.onSurface.withOpacity(.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: s ? Colors.orange : Colors.transparent)
                        ),
                        child: Center(
                          child: Text(
                            "S",
                            style: TextStyle(
                                color: s
                                    ? Colors.orange
                                    : Colors.white
                                    .withOpacity(.8),
                                fontSize: 20,
                                fontWeight:
                                FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        s = false;
                        m = true;
                        l = false;
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                            color: m ? Colors.black : Theme.of(context).colorScheme.onSurface.withOpacity(.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all( color: m ? Colors.orange : Colors.transparent)),
                        child: Center(
                          child: Text(
                            "M",
                            style: TextStyle(
                                color: m
                                    ? Colors.orange
                                    : Colors.white
                                    .withOpacity(.8),
                                fontSize: 20,
                                fontWeight:
                                FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        s = false;
                        m = false;
                        l = true;
                        setState(() {});
                      },
                      child: Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                            color: l ? Colors.black : Theme.of(context).colorScheme.onSurface.withOpacity(.2),
                            borderRadius:
                            BorderRadius.circular(10),
                            border: Border.all(color: l ? Colors.orange : Colors.transparent)),
                        child: Center(
                          child: Text(
                            "L",
                            style: TextStyle(
                                color: l
                                    ? Colors.orange
                                    : Colors.white
                                    .withOpacity(.8),
                                fontSize: 20,
                                fontWeight:
                                FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 18),
        ],
      )),
      bottomNavigationBar: Container(padding: EdgeInsets.symmetric(horizontal: 12), color: Theme.of(context).colorScheme.surface, child: SafeArea(child: SizedBox(height: 60, child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Price",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Row(
                children: [
                  const Text(
                    "\$ ",
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Text(
                    s ? widget.coffee.price.toString()
                        : m ? widget.coffee.mediumPrice.toString()
                        : widget.coffee.largePrice.toString(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.caramelBrown
                    ),
                  ),
                ],
              )
            ],
          ),
          CupertinoButton.filled(onPressed: () {
            final balance = num.parse('${Get.find<AccountController>().state?.usdtBalance ?? 0}');
            if(widget.coffee.price > balance) {
              showSnackMessage("insufficientBalance".tr);
              return;
            }
            showBiometricDialog(context, (index) {
              if(index == 1) {
                runZonedGuarded((){
                  showLoading();
                  Get.find<AccountController>().sendUsdt(amount: widget.coffee.price).then((res){
                    closeLoading();
                    if(res != null) {
                      showSnackMessage("Successfully!");
                    }
                  });
                }, (e, s){
                   closeLoading();
                   if(!e.toString().contains("filter"))showSnackMessage(e.toString());
                });
              }
            });
          }, child: Text("buyNow".tr)),
        ],
      )))),
    );
  }

}
