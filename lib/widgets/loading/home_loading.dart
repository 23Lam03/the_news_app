import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});
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
            Container(
              width: size.width / 2,
              color: Colors.blueAccent,
              child: const Text('alkjsdhasldjhla'),
            ),
            const SizedBox(height: 30),
            ...List.generate(4, (_) => __news()),
            const SizedBox(height: 20),
            Container(
              width: size.width / 2,
              color: Colors.blueAccent,
              child: const Text('alkjsdhasldjhla'),
            ),
            const SizedBox(height: 30),
            ...List.generate(4, (_) => __news()),
          ],
        ),
      ),
    );
  }

  Container __news() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.amber,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  color: Colors.blueAccent,
                  child: const Text('alkjsdhasldjhla'),
                ),
                Container(
                  width: 200,
                  color: Colors.blueAccent,
                  child: const Text('alkjsdhasldjhla'),
                ),
                Container(
                  width: 200,
                  color: Colors.blueAccent,
                  child: const Text('alkjsdhasldjhla'),
                ),
                Container(
                  width: 200,
                  color: Colors.blueAccent,
                  child: const Text('alkjsdhasldjhla'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
