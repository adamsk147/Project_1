import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DictionaryChinese extends StatefulWidget {
  @override
  _DictionaryChineseState createState() => _DictionaryChineseState();
}

class _DictionaryChineseState extends State<DictionaryChinese> {
  get http => null;

  @override
  Widget build(BuildContext context) {
    //   return Container();
    // }
    String url = "https://owlbot.info/api/v4/dictionary/";
    String token = "dbfa63eca18611f26f4fa9f439bc1e61f7a79d44";

    TextEditingController textEditingController = TextEditingController();

    // Stream for loading the text as soon as it is typed
    StreamController streamController;
    Stream _stream;

    Timer _debounce;

    // search function
    searchText() async {
      if (textEditingController.text == null ||
          textEditingController.text.length == 0) {
        streamController.add(null);
        return;
      }
      streamController.add("waiting");
      Response response =
          await http.get(url + textEditingController.text.trim(),
              // do provide spacing after Token
              headers: {"Authorization": "Token " + token});
      streamController.add(json.decode(response.body));
    }

    @override
    void initState() {
      super.initState();
      streamController = StreamController();
      _stream = streamController.stream;
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Dictionary",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(45),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 12, bottom: 11.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: Colors.white),
                    child: TextFormField(
                      onChanged: (String text) {
                        if (_debounce?.isActive ?? false) _debounce.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 1000), () {
                          searchText();
                        });
                      },
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: "Search for a word",
                        contentPadding: const EdgeInsets.only(left: 24.0),

                        // removing the input border
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    searchText();
                  },
                )
              ],
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: StreamBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text("Enter a search word"),
                );
              }
              if (snapshot.data == "waiting") {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // output
              return ListView.builder(
                itemCount: snapshot.data["definitions"].length,
                itemBuilder: (BuildContext context, int index) {
                  return ListBody(
                    children: [
                      Container(
                        color: Colors.grey[300],
                        child: ListTile(
                          leading: snapshot.data["definitions"][index]
                                      ["image_url"] ==
                                  null
                              ? null
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data["definitions"][index]["image_url"]),
                                ),
                          title: Text(textEditingController.text.trim() +
                              "(" +
                              snapshot.data["definitions"][index]["type"] +
                              ")"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            snapshot.data["definitions"][index]["definition"]),
                      )
                    ],
                  );
                },
              );
            },
            stream: _stream,
          ),
        ),
      );
    }
  }
}
