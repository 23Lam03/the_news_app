import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ViewedLoading extends StatelessWidget {
  const ViewedLoading({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ...List.generate(3, (_) => __news()),
            const SizedBox(height: 20),
            Container(
              width: size.width / 2,
              color: Colors.blueAccent,
              child: const Text('alkjsdhasldjhla'),
            ),
            const SizedBox(height: 30),
            ...List.generate(3, (_) => __news()),
          ],
        ),
      ),
    );
  }

  Container __news() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.blueAccent,
            child: const Text('alkjsdhasldjhla'),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            color: Colors.blueAccent,
            child: const Text('alkjsdhasldjhla'),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            color: Colors.blueAccent,
            child: const Text('alkjsdhasldjhla'),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 30,
                height: 30,
                color: Colors.amber,
                child: const Text('data'),
              )
            ],
          )
        ],
      ),
    );
  }
}
