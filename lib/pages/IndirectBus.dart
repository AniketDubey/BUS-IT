// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:minoragain/models/DUMMYDATA.dart';
import "dart:io";

import 'dart:collection';

class IndirectBus extends StatelessWidget {
  //const IndirectBus({Key? key}) : super(key: key);

  Map<String, String> detailInfo;

  IndirectBus(this.detailInfo);

  void find_paths(
      List<List<int>> paths, List<int> path, List<List<int>> parent, int u) {
    if (u == -1) {
      paths.add(path);
      return;
    }

    for (int par in parent[u]) {
      path.add(u);

      find_paths(paths, path, parent, par);

      path.removeLast();
    }
  }

  void bfs(Map<int, List<int>> adj, List<List<int>> parent, int start) {
    List<int> dist = List.filled(50, 2147483647);

    Queue<int> q = Queue<int>();

    q.add(start);
    parent[start] = List.filled(50, -1);
    dist[start] = 0;

    while (!q.isEmpty) {
      int u = q.first;
      q.removeLast();
      adj[u]!.forEach((v) {
        if (dist[v] > dist[u] + 1) {
          dist[v] = dist[u] + 1;
          q.add(v);
          parent[v].clear();
          parent[v].add(u);
        } else if (dist[v] == dist[u] + 1) {
          parent[v].add(u);
        }
      });
    }
  }

  void print_paths(Map<int, List<int>> adj, int start, int end) {
    List<List<int>> paths = [];
    List<int> path = [];
    List<List<int>> parent = List.filled(50, []);

    //print(parent);

    bfs(adj, parent, start);

    find_paths(paths, path, parent, end);

    for (var v in paths) {
      v.reversed;

      for (int u in v) {
        stdout.write(u);
      }
      print("");
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(detailInfo);

    String? src = detailInfo["Source"];
    String? dst = detailInfo["Destination"];
    //print(vec[24]);

    print_paths(vec, 2, 10);

    return Scaffold(
      appBar: AppBar(
        title: Text("Indirect Bus List"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Card(),
      ),
    );
  }
}
