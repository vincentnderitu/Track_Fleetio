import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_flotilla/api/api_uri.dart';
import 'package:track_flotilla/model/command_model.dart';
import 'package:track_flotilla/model/geoFenceModel.dart';
import 'package:track_flotilla/providers/loading_provider.dart';
import 'package:track_flotilla/shared_pref/shared_pref.dart';
import 'package:http/http.dart' as http;

class MaintenanceHander {
  
  // __________________________Get All Vehicle Details
  static Future fetchAllMaintenance(BuildContext context) async {
    Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
    try {
      var username = await SharedPref.getUserEmail();
      var password = await SharedPref.getUserPassword();

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final response = await http.get(
        Uri.parse(ApiUri.getAllMaintenance),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'authorization': basicAuth
        },
      );
      log('response: ${response.statusCode}');
      log('response: ${response.body}');
      if (response.statusCode == 200) {
        List maintenance = jsonDecode(response.body);
        // List commandModel = response.body as List;
        // commandsModelFromJson(response.body) as List<CommandsModel>;
        // print('commandModel: $commandModel');
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

        return maintenance;
      } else {
        Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
        throw Exception('Unexpected error occurred!');
      }
    } catch (e) {
      log('e: $e');
      Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
    }
  }

  static Future deleteMaintenaince(BuildContext context, id) async {
    Provider.of<LoadingProvider>(context, listen: false).setLoading(true);
    try {
      var username = await SharedPref.getUserEmail();
      var password = await SharedPref.getUserPassword();

      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final response = await http.delete(
        Uri.parse(ApiUri.deleteMaintenance(id)),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'authorization': basicAuth
        },
      );
      log('response: ${response.statusCode}');
      log('response: ${response.body}');
      if (response.statusCode == 204) {
        // List commandModel = response.body as List;
        // commandsModelFromJson(response.body) as List<CommandsModel>;
        // print('commandModel: $commandModel');
        Provider.of<LoadingProvider>(
          context,
        ).setLoading(false);
      } else {
        Provider.of<LoadingProvider>(context).setLoading(false);
        throw Exception('Unexpected error occurred!');
      }
      Provider.of<LoadingProvider>(context).setLoading(false);
    } catch (e) {
      Provider.of<LoadingProvider>(context).setLoading(false);

      log('e: $e');
    }
  }
}
