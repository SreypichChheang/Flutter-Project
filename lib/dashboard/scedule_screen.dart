import 'package:flutter/material.dart';

class RoutineAddButton extends StatelessWidget {
  final VoidCallback onTap;

  const RoutineAddButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.add),
      label: const Text('Add'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final List<Map<String, String>> routines = [
    {'title': 'Alarm', 'time': '7:00 AM'},
    {'title': 'Turn off AC', 'time': '6:00 AM'},
  ];

  void _addRoutine(String title, String time) {
    setState(() {
      routines.add({'title': title, 'time': time});
    });
  }

  void _editRoutine(int index, String title, String time) {
    setState(() {
      routines[index] = {'title': title, 'time': time};
    });
  }

  void _deleteRoutine(int index) {
    setState(() {
      routines.removeAt(index);
    });
  }

  void _showAddRoutineModal(BuildContext context) {
    final titleController = TextEditingController();
    final timeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Wrap(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Routine Title'),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(labelText: 'Time (e.g., 8:00 AM)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      timeController.text.isNotEmpty) {
                    _addRoutine(titleController.text, timeController.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Save'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditRoutineModal(BuildContext context, int index) {
    final titleController = TextEditingController(text: routines[index]['title']);
    final timeController = TextEditingController(text: routines[index]['time']);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Wrap(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Routine Title'),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(labelText: 'Time (e.g., 8:00 AM)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      timeController.text.isNotEmpty) {
                    _editRoutine(index, titleController.text, timeController.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoutineCard(int index, String title, String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyLarge),
              Text(time, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert,
                color: Theme.of(context).iconTheme.color),
            onSelected: (value) {
              if (value == 'edit') {
                _showEditRoutineModal(context, index);
              } else if (value == 'delete') {
                _deleteRoutine(index);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          // child: Container(
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).colorScheme.primary,
          //     shape: BoxShape.circle,
          //   ),
          //   // child: IconButton(
          //   //   icon: const Icon(Icons.arrow_back, size: 20),
          //   //   color: Theme.of(context).colorScheme.onPrimary,
          //   //   onPressed: () => Navigator.pop(context),
          //   // ),
          // ),
        ),
        title: Text(
          'Schedule',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create routine to automate your life',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 50.0),
                        Text(
                          'Let\'s Add Routine',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/boy.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 8),
                      RoutineAddButton(onTap: () => _showAddRoutineModal(context)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
              'Active Routines',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 15.0),
            ...routines.asMap().entries.map((entry) {
              int index = entry.key;
              var r = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: _buildRoutineCard(index, r['title']!, r['time']!),
              );
            }),
          ],
        ),
      ),
    );
  }
}
