import 'package:flutter/material.dart';
import 'package:wknd_app/core/extensions/e_context_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16.0),
          Text('Track your referral', style: context.titleLarge?.copyWith(fontSize: 24.0)),
          const SizedBox(height: 16.0),
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'In Progress'),
              Tab(text: 'Completed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _ProgressCard(),
                _CompleteTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: context.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
            title: const Text('John Doe'),
            subtitle: const Text('Welcome to WKND'),
            trailing: Card(
              color: context.primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'In Progress',
                  style: context.titleLarge?.copyWith(fontSize: 12.0, color: context.onPrimary),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CompleteTab extends StatelessWidget {
  const _CompleteTab();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 8.0),
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: context.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
            title: const Text('John Doe'),
            subtitle: const Text('Welcome to WKND'),
            trailing: Card(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Completed',
                  style: context.titleLarge?.copyWith(fontSize: 12.0, color: context.onPrimary),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
