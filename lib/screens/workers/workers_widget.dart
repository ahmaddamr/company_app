import 'package:flutter/material.dart';
import 'package:shop_app/screens/workers/widgets/workers_account_widget.dart';
import 'package:shop_app/utils/functions.dart';
import 'package:shop_app/utils/styles.dart';

class WorkersWidget extends StatefulWidget {
  const WorkersWidget(
      {super.key,
      required this.uid,
      required this.email,
      required this.name,
      required this.img,
      required this.position});
  final uid;
  final String name;
  final String email;
  final String img;
  final String position;

  @override
  State<WorkersWidget> createState() => _WorkersWidgetState();
}

class _WorkersWidgetState extends State<WorkersWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
          title: Text(
            widget.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Styles.listTitle,
          ),
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) {
            //     return WorkersAccountWidget(
            //       userId: widget.uid,
            //     );
            //   },
            // ));
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            );
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          leading: Container(
            padding: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(width: 1),
              ),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.img == null
                  ? 'https://cdn-icons-png.flaticon.com/128/3135/3135715.png'
                  : widget.img),
              // 'https://cdn-icons-png.flaticon.com/128/50/50037.png'
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.linear_scale,
                color: Styles.buttonColor,
              ),
              Text(
                'Position In company:${widget.position}',
                style: const TextStyle(
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              Functions.openMail(email: widget.email);
            },
            icon: const Icon(
              Icons.mail,
              size: 30,
              color: Styles.buttonColor,
            ),
          )),
    );
  }
}
