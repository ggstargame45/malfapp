import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:malf/features/chat/chat_list/chatting_list_data_model.dart';

final PagingController<int, ChattingListModel> pagingChatController =
      PagingController(firstPageKey: 1);