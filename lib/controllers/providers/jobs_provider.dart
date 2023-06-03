// ignore_for_file: type_annotate_public_apis, always_declare_return_types

import 'package:flutter/foundation.dart';

import '../../models/response/jobs/get_job.dart';
import '../../models/response/jobs/jobs_response.dart';
import '../../services/helpers/jobs_helper.dart';

// import 'package:jobhub/models/response/jobs/get_job.dart';
// import 'package:jobhub/models/response/jobs/jobs_response.dart';
// import 'package:jobhub/services/helpers/jobs_helper.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobList;
  late Future<JobsResponse> recent;
  late Future<GetJobRes> job;

  getJobs() {
    jobList = JobsHelper.getJobs();
  }

  getRecent() {
    recent = JobsHelper.getRecent();
  }

  getJob(String jobId) {
    job = JobsHelper.getJob(jobId);
  }
}
