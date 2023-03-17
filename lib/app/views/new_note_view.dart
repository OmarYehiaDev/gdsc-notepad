import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewNoteView extends StatelessWidget {
  const NewNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.yellow, //change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Note',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.share),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('Share as image'),
                ),
                const PopupMenuItem(
                  child: Text('Share as Text'),
                ),
              ];
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.menu),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('Delete'),
                ),
                const PopupMenuItem(
                  child: Text('Save'),
                ),
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 5),
                  child: Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ),
                Text(
                  DateFormat.jm().format(DateTime.now()),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          //title
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              maxLines: null, //or null
              decoration: InputDecoration.collapsed(
                hintText: "Title",
                hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                ),
              ),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //body
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: TextField(
              maxLines: null, //or null
              decoration: InputDecoration.collapsed(hintText: "Note something down"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 174, 174, 166),
        fixedColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            label: "Album",
            icon: Icon(
              Icons.add_a_photo,
            ),
          ),
          BottomNavigationBarItem(
            label: "To do list",
            icon: Icon(
              Icons.list_alt,
            ),
          ),
          BottomNavigationBarItem(
            label: "Remoinder",
            icon: Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
    );
  }
}
