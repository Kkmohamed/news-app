import 'package:flutter/material.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, HomeController controller, child) {
          return Scaffold(
            body:
                (controller.errorMessage?.isNotEmpty ?? false)
                    ? Center(child: Text(controller.errorMessage!))
                    : controller.everythingLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            controller.newsEverythingList[index].title ??
                                'No Title',
                          ),
                        );
                      },
                      itemCount: controller.newsEverythingList.length,
                    ),
          );
        },
      ),
    );
  }
}
