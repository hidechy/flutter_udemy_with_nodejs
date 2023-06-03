// ignore_for_file: depend_on_referenced_packages, avoid_classes_with_only_static_members

import 'package:http/http.dart' as https;

import '../../models/response/jobs/get_job.dart';
import '../../models/response/jobs/jobs_response.dart';
import '../config.dart';

class JobsHelper {
  static https.Client client = https.Client();

  static Future<List<JobsResponse>> getJobs() async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.https(Config.apiUrl, Config.jobs);
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception('Failed to get the jobs');
    }
  }

// get job
  static Future<GetJobRes> getJob(String jobId) async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.https(Config.apiUrl, '${Config.jobs}/$jobId');
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final job = getJobResFromJson(response.body);
      return job;
    } else {
      throw Exception('Failed to get a job');
    }
  }

  static Future<JobsResponse> getRecent() async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.https(Config.apiUrl, Config.jobs);
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final jobsList = jobsResponseFromJson(response.body);

      final recent = jobsList.first;
      return recent;
    } else {
      throw Exception('Failed to get the jobs');
    }
  }

//SEARCH
  static Future<List<JobsResponse>> searchJobs(String searchQeury) async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
    };

    final url = Uri.https(Config.apiUrl, '${Config.search}/$searchQeury');
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final jobsList = jobsResponseFromJson(response.body);
      return jobsList;
    } else {
      throw Exception('Failed to get the jobs');
    }
  }
}
