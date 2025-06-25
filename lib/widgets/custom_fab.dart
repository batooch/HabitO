import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF123D2B),
      child: const Icon(Icons.add, color: Colors.white),
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
                              'Gewohnheit erstellen',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: const Icon(
                              Icons.add,
                              color: Colors.white,
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
                              'Ori fragen',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: const Icon(
                              Icons.lightbulb_outline,
                              color: Colors.white,
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
