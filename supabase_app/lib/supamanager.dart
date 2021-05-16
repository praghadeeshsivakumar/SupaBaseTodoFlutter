import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class SupaBaseManager {
  String supaBaseURL = "https://qvrpqqxnsjczomrvwjai.supabase.co";
  String supaBasePass =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyMTE1NjQzMCwiZXhwIjoxOTM2NzMyNDMwfQ._0PU264XssXmnuM6XnaSaF_3yal2G9VQejOT0m4OyPY";

  final client = SupabaseClient("https://qvrpqqxnsjczomrvwjai.supabase.co",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyMTE1NjQzMCwiZXhwIjoxOTM2NzMyNDMwfQ._0PU264XssXmnuM6XnaSaF_3yal2G9VQejOT0m4OyPY");

  readData() async {
    var response = await client
        .from("testtable")
        .select()
        .order('name', ascending: true)
        .execute();
    if (response.error == null) {
      print('response.data: ${response.data}');
    }
    print(response.data);
    final dataList = response.data as List;
    print(dataList);
    print(dataList.runtimeType);

    return dataList;
  }

  addData(String someValue, bool statusValue) async {
    var response = client
        .from("testtable")
        .insert({'name': someValue, 'status': false}).execute();
    print(response);
  }

  updateData(bool updateValue, int oldvalue) async {
    var response = client
        .from("testtable")
        .update({'status': updateValue})
        .eq('id', oldvalue)
        .execute();
    print(response);
  }

  deleteData(String deleteValue) async {
    var response =
        client.from("testtable").delete().eq('name', deleteValue).execute();
    print(response);
  }
}
