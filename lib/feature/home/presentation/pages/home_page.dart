import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wknd_app/core/extensions/e_context_extensions.dart';
import 'package:wknd_app/feature/refer/presentation/bloc/refer_bloc.dart';

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
    context.read<ReferBloc>().add(FetchRefer());
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
    return BlocBuilder<ReferBloc, ReferState>(
      builder: (context, state) {
        if (state is ReferLoading) return const Center(child: CircularProgressIndicator());
        if (state is ReferFailure) return Center(child: Text(state.message));
        if (state is ReferLoadedSuccess && state.refers.isEmpty) return const Center(child: Text('No refers found'));
        if (state is ReferLoadedSuccess) {
          final refers = state.refers.where((refer) => refer.status == 'In Progress').toList();
          if (refers.isEmpty) return const Center(child: Text('No In Progress refers found'));
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemCount: refers.length,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            itemBuilder: (context, index) {
              final refer = refers[index];
              return Container(
                decoration: BoxDecoration(
                  color: context.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  title: Text(refer.theirName),
                  subtitle: Text(refer.referralId),
                  trailing: Card(
                    color: context.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        refer.status,
                        style: context.titleLarge?.copyWith(fontSize: 12.0, color: context.onPrimary),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _CompleteTab extends StatelessWidget {
  const _CompleteTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferBloc, ReferState>(
      builder: (context, state) {
        if (state is ReferLoading) return const Center(child: CircularProgressIndicator());
        if (state is ReferFailure) return Center(child: Text(state.message));
        if (state is ReferLoadedSuccess && state.refers.isEmpty) return const Center(child: Text('No refers found'));
        if (state is ReferLoadedSuccess) {
          final refers = state.refers.where((refer) => refer.status == 'Completed').toList();
          if (refers.isEmpty) return const Center(child: Text('No Completed refers found'));
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemCount: refers.length,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            itemBuilder: (context, index) {
              final refer = refers[index];
              return Container(
                decoration: BoxDecoration(
                  color: context.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  title: Text(refer.theirName, style: context.titleLarge?.copyWith(fontSize: 16.0)),
                  subtitle: Text('Refer Id: ${refer.referralId}'),
                  trailing: Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        refer.status,
                        style: context.titleLarge?.copyWith(fontSize: 12.0, color: context.onPrimary),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
