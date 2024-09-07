import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../theme/resorces_list.dart';
import 'coffee_details_page.dart';

class CoffeeListPage extends StatefulWidget {

  CoffeeListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CoffeeListPageState();
  }

}

class _CoffeeListPageState extends State<CoffeeListPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
     super.build(context);
     return SingleChildScrollView(child: Column(children: [
       SizedBox(height: kToolbarHeight),
       Stack(children: [
         ClipRRect(child: AspectRatio(aspectRatio: 2.34, child: Image.asset("assets/images/banner.png")), borderRadius: BorderRadius.circular(16)).paddingSymmetric(horizontal: 12),
         Positioned(child: Text("Find the best \nCoffee for you", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 24, fontWeight: FontWeight.bold)), left: 32, bottom: 34),
         Positioned(child: Container(child: Text("Promo", style: TextStyle(fontWeight: FontWeight.w600)),
             padding: EdgeInsets.symmetric(horizontal: 4),
             decoration: BoxDecoration(color: Color(0xFFED5151), borderRadius: BorderRadius.circular(4))), left: 32, top: 16),
       ]),
       MasonryGridView.count(
         physics: NeverScrollableScrollPhysics(),
         shrinkWrap: true,
         padding: EdgeInsets.all(8),
         crossAxisCount: 2,
         mainAxisSpacing: 4,
         crossAxisSpacing: 4,
         itemCount: coffees.length,
         itemBuilder: (context, index) {
           Coffee coffee = coffees[index];
           return InkWell(
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => CoffeeDetailsPage(coffee)));
             },
             child: Card(
               clipBehavior: Clip.hardEdge,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
               child: Container(
                 padding: const EdgeInsets.all(15),
                 width: 155,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     ClipRRect(
                       borderRadius: BorderRadius.circular(10),
                       child: SizedBox(
                         height: 120,
                         width: double.infinity,
                         child: Stack(
                           children: [
                             Positioned.fill(
                                 child: Image.asset(
                                   coffee.image.assetName,
                                   fit: BoxFit.cover,
                                 )),
                             Align(
                               alignment: Alignment.topRight,
                               child: Container(
                                 height: 25,
                                 width: 50,
                                 decoration: BoxDecoration(
                                   color: Colors.black
                                       .withOpacity(.7),
                                   borderRadius:
                                   const BorderRadius.only(
                                       bottomLeft:
                                       Radius.circular(
                                           10)),
                                 ),
                                 child: Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment
                                       .spaceEvenly,
                                   children: [
                                     const Icon(
                                       Icons.star,
                                       color: AppColors.caramelBrown,
                                       size: 14,
                                     ),
                                     Text(
                                       coffee.ratting.toString(),
                                       style: const TextStyle(
                                           color: Colors.white,
                                           fontWeight:
                                           FontWeight.bold),
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                     const SizedBox(
                       height: 20,
                     ),
                     Text(coffee.name,
                         style: const TextStyle(
                           color: Colors.white,
                           fontSize: 20,
                         )),
                     const SizedBox(
                       height: 5,
                     ),
                     Text(coffee.mix,
                         style: TextStyle(
                           color: Colors.white.withOpacity(.5),
                           fontSize: 15,
                         )),
                     const SizedBox(
                       height: 10,
                     ),
                     Row(
                       children: [
                         const Align(
                           alignment: Alignment.topLeft,
                           child: Text("\$ ",
                               style: TextStyle(
                                   color: AppColors.caramelBrown,
                                   fontSize: 12,
                                   fontWeight: FontWeight.bold)),
                         ),
                         Text(coffee.price.toString(),
                             style: const TextStyle(
                               color: Colors.white,
                               fontWeight: FontWeight.bold,
                               fontSize: 18,
                             )),
                       ],
                     ),
                   ],
                 ),
               ),
             ),
           );
         },
       )
     ]));
  }

}