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
    _tabController = TabController(length: 4, vsync: this);
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
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Contacted'),
              Tab(text: 'Appointment Set'),
              Tab(text: 'Completed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ReferTab(status: "In Progress"),
                ReferTab(status: "Contacted"),
                ReferTab(status: "Appointment Set"),
                ReferTab(status: "Completed"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




class ReferTab extends StatelessWidget {
  final String status;
  const ReferTab({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferBloc, ReferState>(
      builder: (context, state) {
        if (state is ReferLoading) return const Center(child: CircularProgressIndicator());
        if (state is ReferFailure) return Center(child: Text(state.message));
        if (state is ReferLoadedSuccess && state.refers.isEmpty) return const Center(child: Text('No refers found'));
        if (state is ReferLoadedSuccess) {
          final refers = state.refers.where((refer) => refer.status == status).toList();
          if (refers.isEmpty) return Center(child: Text('No $status refers found'));
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemCount: refers.length,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            itemBuilder: (context, index) {
              final refer = refers[index];
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  title: Text(refer.theirName),
                  subtitle: Text(refer.referralId),
                  trailing: Card(
                    color: _getCardColor(status, context),
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

  Color _getCardColor(String status, BuildContext context) {
    switch (status) {
      case 'In Progress':
        return Theme.of(context).primaryColor;
      case 'Contacted':
        return context.tertiary;
      case 'Appointment Set':
        return Colors.green;
      case 'Completed':
        return Colors.green;
      default:
        return Theme.of(context).primaryColor;
    }
  }
}
