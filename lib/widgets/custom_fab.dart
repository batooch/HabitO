import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_texts.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF123D2B),
      child: const Icon(Icons.add, color: AppColors.white),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black.withOpacity(0.9),
          isScrollControlled: true,
          isDismissible: true,
          builder: (context) {
            final screenWidth = MediaQuery.of(context).size.width;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  child: Container(
                    width: screenWidth * 0.5,
                    padding: const EdgeInsets.only(bottom: 32, right: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF173B2F),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            title: const Text(
                              AppTexts.createHabitHint,
                              style: TextStyle(color: AppColors.white),
                            ),
                            trailing: const Icon(
                              Icons.add,
                              color: AppColors.white,
                            ),
                            onTap: () {
                              context.goNamed('create');
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF173B2F),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            title: const Text(
                              AppTexts.oriAsk,
                              style: TextStyle(color: AppColors.white),
                            ),
                            trailing: const Icon(
                              Icons.lightbulb_outline,
                              color: AppColors.white,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              context.pushNamed('ori');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
