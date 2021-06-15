import 'package:global_configuration/global_configuration.dart';

import '../models/platform.dart';
import '../models/donation_store.dart';

class Search {
  Platform platform;
  String image;
  DonationStore donationStore;

  Search();

  Search.fromJSON(Map<String, dynamic> jsonMap) {
    platform = Platform.fromJSON(jsonMap['platform']);
    image = '${GlobalConfiguration().getString('api_base_url')}${jsonMap['image']}';
    donationStore = DonationStore.fromJSON(jsonMap['donation']);
  }
}