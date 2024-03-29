import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:event_scheduler_project/models/dogReportModel.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ApiMethods {
  Future<List<DogReport>> fetchDogReports() async {
    Dio dio = Dio();
    final response = await dio.get('http://192.168.0.11:8080/api/dog-reports');

    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.data;
      List<DogReport> dogReports =
          jsonList.map((json) => DogReport.fromJson(json)).toList();
      return dogReports;
    } else {
      throw Exception('Failed to load dog reports');
    }
  }

  Future<String> uploadDogReport(
      String title,
      String description,
      Uint8List file,
      String username,
      GeoPoint location,
      DateTime eventDate,
      TimeOfDay eventTime) async {
    String dogReportid = const Uuid().v1();
    String imgUrl = await uploadImage(file);
    DateTime combinedDateTime = DateTime(
      eventDate.year,
      eventDate.month,
      eventDate.day,
      eventTime.hour,
      eventTime.minute,
    );

    DogReport dogReport = DogReport(
        id: dogReportid,
        isLost: true,
        userId: username,
        title: title,
        description: description,
        imgUrl: imgUrl,
        dateTime: combinedDateTime,
        latitude: location.latitude,
        longitude: location.longitude);

    Dio dio = Dio();
    try {
      final response = await dio.post(
        'http://192.168.0.11:8080/api/dog-reports/create',
        data: dogReport.toJson(),
      );

      if (response.statusCode == 200) {
        return "success";
      } else {
        return "failure";
      }
    } catch (e) {
      return "failure";
    }
  }

  Future<String> uploadImage(Uint8List img) async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        'http://192.168.0.11:8080/api/images/upload',
        data: img,
        options: Options(
          headers: {
            Headers.contentLengthHeader: img.length, // set content-length
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data.id;
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      return "Failed to upload image";
    }
  }
}
