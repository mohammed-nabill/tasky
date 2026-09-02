import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/home/home_controller.dart';

class AchievedTasks extends StatelessWidget {
  const AchievedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
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
                      "${controller.totalDoneTasks} Out of ${controller.totalTasks} Done",
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
                          value: controller.percentage,
                          backgroundColor: Color(0xFF6D6D6D),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF15B86C),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "${(controller.percentage * 100).toInt()}%",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
