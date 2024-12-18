import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repo_github/views/detail_repo_view.dart';
import '../viewmodels/repo_viewmodel.dart';

class RepoView extends StatelessWidget {
  final RepoViewModel viewModel = Get.put(RepoViewModel());

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repositories'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'GitHub Username',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text.trim();
                if (username.isNotEmpty) {
                  viewModel.fetchRepositories(username);
                } else {
                  // Get.snackbar(
                  //   "Error", 
                  //   "Please enter a GitHub username.",
                  //   snackPosition: SnackPosition.BOTTOM
                  // );
                  Get.bottomSheet(
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Please enter a GitHub username.',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back(); // Dismiss the bottom sheet
                            },
                            child: const Text('Dismiss'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
              child: const Text('Search Repositories'),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (viewModel.isLoading.value) {
                return const CircularProgressIndicator();
              }

              if (viewModel.repo.isEmpty) {
                return const Text('No repositories found.');
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: viewModel.repo.length,
                  itemBuilder: (context, index) {
                    final repo = viewModel.repo[index];
                    return InkWell(
                      onTap: () {
                        Get.to(() => DetailRepoView(url: repo.url,));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(repo.name, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.blue),),
                          Text(repo.description, style: const TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),),
                          repo.language.isNotEmpty
                            ? Row(
                                children: [
                                  const Icon(Icons.code),
                                  Text(repo.language, style: const TextStyle(color: Colors.black87),),
                                ],
                              )
                            : const SizedBox.shrink(),
                          const SizedBox(height: 10.0,)
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}