import 'package:flutter/material.dart';
import 'package:shop_app/screens/check/check_screen.dart';
import 'package:shop_app/screens/tasks/add_task_screen.dart';
import 'package:shop_app/screens/tasks/tasks_screen.dart';
import 'package:shop_app/screens/tasks/widgets/custom_list_tile.dart';
import 'package:shop_app/screens/tasks/widgets/logout_alert_dialoge.dart';
import 'package:shop_app/screens/workers/worker_account_screen.dart';
import 'package:shop_app/screens/workers/workers_screen.dart';
import 'package:shop_app/services/location_service.dart';
import 'package:shop_app/services/user_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  
  List<IconData> icons = [
    Icons.task,
    Icons.check,
    Icons.person,
    Icons.workspace_premium,
    Icons.add_task,
    Icons.logout
  ];
  @override
  void initState() {
    super.initState();
    startLocationService();
  }
void startLocationService() async {
  LocationService locationService = LocationService();
  await locationService.initialize();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          const TasksScreen(),
          const CheckScreen(),
          const WorkerAccountScreen(),
          WorkersScreen(),
          const AddTaskScreen(),
          Center(
            child: CustomListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return LogoutAlertDialoge();
                  },
                );
              },
              text: 'Logout',
              leading: const Icon(Icons.logout_outlined),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < icons.length; i++) ...<Expanded>{
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(
                      () {
                        currentIndex = i;
                      },
                    );
                  },
                  child: Icon(
                    icons[i],
                    color: i == currentIndex
                        ? const Color(0xffAC1457)
                        : Colors.black,
                    size: i == currentIndex ? 32 : 28,
                  ),
                ),
              )
            }
          ],
        ),
      ),
    );
  }
}
