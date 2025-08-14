import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  final String label = 'Search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => showSearch(
            context: context,
            delegate: CustomSearchDelegate(label),
          ),
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: label,
              fillColor: Colors.grey[200],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 6),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
          ),
          itemCount: 100,
          itemBuilder: (context, index) {
            return Container(
              color: index % 2 == 0 ? Colors.red[300] : Colors.yellow[300],
              child: Center(child: Text('Element $index')),
            );
          },
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final String label;
  CustomSearchDelegate(this.label) : super(searchFieldLabel: label);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(20.0),
        //   borderSide: BorderSide.none,
        // ),
        contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        hintStyle: const TextStyle(fontSize: 18.0, color: Colors.grey),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text('Suggestion №$index'));
      },
    );
  }
}
