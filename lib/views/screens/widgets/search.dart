import 'package:flutter/material.dart';

import '../../../theme_data.dart';

TextEditingController _searchController = TextEditingController();

class Search extends StatelessWidget {
  dynamic results;
  Search({Key? key, this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
          child: TextFormField(
            controller: _searchController,
            autocorrect: true,
            enableInteractiveSelection: true,
            enableSuggestions: true,
            textInputAction: TextInputAction.search,
            showCursor: true,
            autovalidateMode: AutovalidateMode.always,
            cursorColor: amenityPrimary,
            enableIMEPersonalizedLearning: true,
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.normal,
                fontSize: 14),
            decoration: InputDecoration(
                prefixIconColor: amenityPrimary,
                prefixIcon: const Icon(
                  Icons.search,
                  color: amenityPrimary,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: amenityPrimary),
                  borderRadius: BorderRadius.circular(30),
                  gapPadding: 20,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: amenityPrimary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  gapPadding: 20,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: amenityPrimary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  gapPadding: 20,
                ),
                focusColor: amenityPrimary),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: results["count"],
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Icon(Icons.account_circle),
                    title: Text(results[index]['name']),
                    subtitle: Text(results[index]['category']),
                  );
                })),
      ],
    );
  }
}
