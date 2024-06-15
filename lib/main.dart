import "package:flutter/material.dart";
import "dart:convert";
import "dart:io";
import "package:http/http.dart" as http;

void main() {
  runApp(MaterialApp(
    title: "FlutterApi",
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List data = [];
  Future<void> fetchdata() async {
    final res = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));

    print("API METHIOS");
    print(res.body.toString());

    setState(() {
      data = json.decode(res.body)['data'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  data += [
                    {
                      "id": data.length + 1,
                      "email": "pugazh@.gmail.com",
                      "first_name": "pugazh s",
                      "avatar":
                          "http://www.indiawords.com/wp-content/uploads/2017/11/cute-and-side-look-image-of-nani.jpg",
                    }
                  ];
                });
              },
              icon: Icon(Icons.add_outlined)),
        ],
        title: Text("Flutter+API"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data[index]['avatar']),
              radius: 30,
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  data.removeWhere((entry) => entry["id"] == data[index]['id']);
                });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            title: Text(
              data[index]['first_name'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              data[index]['email'],
              style: TextStyle(
                fontSize: 17,
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        },
      ),
    );
  }
}
