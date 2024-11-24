import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/Controllers/foodList_controller.dart';
import 'package:health_buddy/constants/app_color.dart';

class Foodlist extends StatelessWidget {
  const Foodlist({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodListController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Create / Update Lists'),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          backgroundColor: Colors.blue.shade900,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: controller.userFoodLists.isEmpty
            ? Container(
                color: AppColors.bgColor,
                child: const Center(
                  child: Text(
                    "No Lists Created Yet",
                    style: TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                ),
              )
            : Container(
                color: AppColors.bgColor,
                child: ListView.builder(
                  itemCount: controller.userFoodLists.length,
                  itemBuilder: (context, index) {
                    final foodList = controller.userFoodLists[index];
                    return Card(
                      elevation: 20,
                      color: AppColors.cardColor,
                      child: ListTile(
                        title: Text(
                          "${index + 1}. ${controller.listTitles[index]}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          "Items: ${foodList.length}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          // Show details of the list
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: AppColors.cardColor,
                            // Allow the bottom sheet to expand based on content
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  // Ensure it takes only as much space as needed
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Displaying the list title
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        "List Name: ${controller.listTitles[index]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    SizedBox(
                                      height: 300,
                                      // Set a fixed height to ensure scrollable content
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: foodList.length,
                                        itemBuilder: (context, foodIndex) {
                                          final food = foodList[foodIndex];
                                          return ListTile(
                                            title: Text(
                                              food.foodName,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            subtitle: Text(
                                              "Calories: ${food.calories}",
                                              style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showCreateListModal(context, controller);
          },
          backgroundColor: Colors.blue.shade900,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }

  void _showCreateListModal(
      BuildContext context, FoodListController controller) {
    final TextEditingController titleController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Ensure the modal expands to fit its content
      backgroundColor: AppColors.cardColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Create New List",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "List Title",
                      labelStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: controller.foodList.length,
                      itemBuilder: (context, index) {
                        final food = controller.foodList[index];
                        return CheckboxListTile(
                          title: Text(
                            food.foodName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "Calories: ${food.calories}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          value: controller.selectedItems[index],
                          onChanged: (bool? isSelected) {
                            controller.selectedItems[index] =
                                isSelected ?? false;
                            setState(() {});
                          },
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: const BorderSide(color: Colors.white),
                          ),
                          activeColor: Colors.lightBlue,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: AppColors.lightBlue,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          String title = titleController.text.trim();
                          if (title.isNotEmpty) {
                            controller.createFoodList(title);
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.lightBlue),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            )),
                        child: const Text(
                          "Create",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
