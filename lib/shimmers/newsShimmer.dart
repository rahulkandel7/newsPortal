import 'package:flutter/material.dart';

class NewsShimmer extends StatelessWidget {
  const NewsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      height: size.height * 0.34,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 12,
          ),
        ],
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            height: size.height * 0.2,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(3),
                height: 20,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(3),
                height: 20,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(
                100,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: 20,
            width: size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(
                100,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: 20,
            width: size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(
                100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
