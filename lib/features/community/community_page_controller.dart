import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:malf/features/community/community_model.dart';

PagingController<int, CommunityData> communityPageController =
    PagingController(firstPageKey: 1);