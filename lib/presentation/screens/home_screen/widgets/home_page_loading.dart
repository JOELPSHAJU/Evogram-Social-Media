import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer homepageloading(context) {
  return Shimmer.fromColors(
        highlightColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade100
          : darkgrey,
      baseColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade300
          : darkbg,
    child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              height: 450,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h20,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                        ),
                        w10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: white,
                              ),
                              height: 15,
                              width: 300,
                            ),
                            h10,
                            Container(
                              height: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: white,
                              ),
                              width: 200,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  h10,
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    color: white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: white,
                          ),
                        ),
                        h10,
                        Container(
                          width: 300,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
  );
}
