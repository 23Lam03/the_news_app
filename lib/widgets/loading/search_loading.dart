import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({super.key});
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
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ...List.generate(2, (_) => __news()),
            const SizedBox(height: 20),
            ...List.generate(1, (_) => __news()),
            const SizedBox(height: 20),
            ...List.generate(1, (_) => __news()),
            const SizedBox(height: 20),
            ...List.generate(1, (_) => __news()),
            const SizedBox(height: 20),
            ...List.generate(1, (_) => __news()),
            const SizedBox(height: 20),
            ...List.generate(1, (_) => __news()),
          ],
        ),
      ),
    );
  }

  Container __news() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
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
