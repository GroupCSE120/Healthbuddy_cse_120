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
          title: const Text('Create/Update Lists'),
          backgroundColor: AppColors.darkBlue,
        ),
        body: controller.foodLists.isEmpty
            ? Container(
          color: Colors.grey.shade900,
              child: const Center(
                        child: Text(
              "No Lists Created Yet",
              style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
            )
            : Container(
          color: AppColors.cardColor,
              child: ListView.builder(
                        itemCount: controller.foodLists.length,
                        itemBuilder: (context, index) {
              final foodList = controller.foodLists[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding:EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightBlue, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),

                  ),
                  child: ListTile(
                    title: Text("${index + 1}: ${controller.listTitles[index]}", style: TextStyle(color: Colors.white, fontSize: 18),),
                    subtitle: Text("Items: ${foodList.length}", style: TextStyle(color: Colors.white70),),
                    onTap: () {
                      // Show details of the list
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,  // Allow the bottom sheet to expand based on content
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min, // Ensure it takes only as much space as needed
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Displaying the list title
                                Text(
                                  controller.listTitles[index],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Use SingleChildScrollView to prevent overflow in case of large lists
                                SizedBox(
                                  height: 300, // Set a fixed height to ensure scrollable content
                                  child: SingleChildScrollView(
                                    child: ListView.builder(
                                      shrinkWrap: true,  // Ensures ListView doesn't try to take all available space
                                      physics: NeverScrollableScrollPhysics(), // Disable ListView scroll since we have a parent scroll
                                      itemCount: foodList.length,
                                      itemBuilder: (context, foodIndex) {
                                        final food = foodList[foodIndex];
                                        return ListTile(
                                          title: Text(food.foodName),
                                          subtitle: Text("Calories: ${food.calories}"),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );


                    },
                  ),
                ),
              );
                        },
                      ),
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showCreateListModal(context, controller),
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  void _showCreateListModal(BuildContext context, FoodListController controller) {
    final TextEditingController titleController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,  // Ensure the modal expands to fit its content
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensure it takes only as much space as needed
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create New List",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "List Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Use SingleChildScrollView to prevent layout issues in case the list is too long
              SizedBox(
                height: 300, // Set a height to ensure content is scrollable
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true, // Ensure ListView doesn't try to take all available space
                    physics: NeverScrollableScrollPhysics(), // Disable ListView scroll since we have a parent scroll
                    itemCount: controller.foodList.length,
                    itemBuilder: (context, index) {
                      final food = controller.foodList[index];
                      return CheckboxListTile(
                        title: Text(food.foodName),
                        subtitle: Text("Calories: ${food.calories}"),
                        value: controller.selectedItems[index],
                        onChanged: (bool? isSelected) {
                          controller.selectedItems[index] = isSelected ?? false;
                          controller.update();
                        },
                      );
                    },
                  ),
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
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String title = titleController.text.trim();
                      if (title.isNotEmpty) {
                        controller.createFoodList(title);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Create"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


}
