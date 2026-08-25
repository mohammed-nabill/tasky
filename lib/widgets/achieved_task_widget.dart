import 'dart:math';

import 'package:flutter/material.dart';

class AchievedTasks extends StatelessWidget {
  const AchievedTasks({
    super.key,
    required this.totalDoneTasks,
    required this.totalTasks,
    required this.percentage,
  });

  final int totalDoneTasks;

  final int totalTasks;

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Achieved Tasks",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "$totalDoneTasks Out of $totalTasks Done",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Stack(
              alignment: AlignmentGeometry.center,
              children: [
                SizedBox(
                  height: 48,
                  width: 48,
                  child: Transform.rotate(
                    angle: -pi / 2,
                    child: CircularProgressIndicator(
                      value: percentage,
                      backgroundColor: Color(0xFF6D6D6D),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF15B86C),
                      ),
                    ),
                  ),
                ),
                Text(
                  "${(percentage * 100).toInt()}%",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
