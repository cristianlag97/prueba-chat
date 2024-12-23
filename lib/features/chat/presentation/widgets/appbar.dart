import 'package:flutter/material.dart';

class AppBarChat extends StatelessWidget implements PreferredSizeWidget {
  const AppBarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[100],
            maxRadius: 14,
            child: const Text('Cr', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(height: 5),
          const Text('Cristian',
              style: TextStyle(color: Colors.black87, fontSize: 12))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
