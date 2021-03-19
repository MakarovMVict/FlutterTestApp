

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondScreenClass extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: double.infinity,
        height: double.infinity,
      child:HomeSecondScreen()
    );

   // throw UnimplementedError();
  }

}

class HomeSecondScreen extends StatelessWidget{
  // @override
  // Widget build(BuildContext context) {
     // return Scaffold(
     //   appBar: AppBar(bottom:TabBar(
     //     tabs: [
     //       Tab(text: "На устройстве",),
     //       Tab(text:"Все доступные"),
     //     ],
     //   ),),
     //   body: TabBarView(
     //     children: [
     //       Icon(Icons.directions_car),
     //       Icon(Icons.directions_transit),
     //       Icon(Icons.directions_bike),
     //     ],
     //   ),
     //
     //   );

    //throw UnimplementedError();
  // }
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            bottom: TabBar(


              tabs: [
                Tab(text:"на устройстве"),
                Tab(text:"Все доступные"),

              ],
            ),
            title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Expanded(child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white38,
                 child:ListChildElement(),
                // ListView.builder(
                //     itemCount: 10,
                //     itemBuilder: (BuildContext context, int index) {
                //       return ListChildElement();
                //     }
                // ),
              )),
              DataToSecondContainer()


            ],
          ),
        ),
      );

  }

}




class ListChildElement extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height:200,

      child:FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
      // Row(
      //
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //
      //   children: [
      //
      //   Text("userid: $userId"),
      //   Text("id: $id"),
      //   Text("title: $title")
      // ],
      // ),
    );

    //throw UnimplementedError();
  }

}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
  await client.get('https://jsonplaceholder.typicode.com/photos');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
class PhotosList extends StatelessWidget {//возвращает виджет сразу с данными из сети
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}

///******* as POJO

Future<Album> futureAlbum;

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

Future<Album> fetchAlbum() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
//**my classes
class DataToSecondContainer extends StatefulWidget {
  DataToSecondContainer({Key key}) : super(key: key);

  @override
  _DataToSecondContainerState createState() => _DataToSecondContainerState();
}

class _DataToSecondContainerState extends State<DataToSecondContainer> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(); //чтоб грузить всё при первом вызове только
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(child: Container(
      width: double.infinity,
      height: double.infinity,
      child:ListView(
        children: [
          FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SecondPageListElement(snapshot.data.title,snapshot.data.userId,snapshot.data.id);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

// By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ],
      ) //данные из сети в виджете сразу
    ));
    throw UnimplementedError();
  }
}

class SecondPageListElement extends StatelessWidget{
  final int userId;
  final int id;
  final String title;

  SecondPageListElement(this.title,this.userId, this.id);
  @override
  Widget build(BuildContext context) {
    return
       SizedBox(
      //
      //   //: Colors.blue[100],
       child: Container(
        color: Colors.blue[100],
          child: Column(
      children: [
        Text("Title : $title"),
        Text("user id : $userId"),
        Text("id : $id")

      ],
    )
      )
    );
    //throw UnimplementedError();
  }

}









