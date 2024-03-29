import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/domain/blocs/blocs.dart';
import 'package:recipes/domain/models/response/response_notifications.dart';
import 'package:recipes/domain/services/notifications_services.dart';
import 'package:recipes/ui/helpers/helpers.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:recipes/data/env/env.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Vui lòng chờ...');
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          setState(() {});
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(
              text: 'Thông báo',
              fontWeight: FontWeight.w500,
              letterSpacing: .9,
              fontSize: 19),
          elevation: 0,
          leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black)),
        ),
        body: SafeArea(
            child: FutureBuilder<List<Notificationsdb>>(
          future: notificationServices.getNotificationsByUser(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const Column(
                    children: [
                      ShimmerCustom(),
                      SizedBox(height: 10.0),
                      ShimmerCustom(),
                      SizedBox(height: 10.0),
                      ShimmerCustom(),
                    ],
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  // backgroundColor: Colors.blue,
                                  backgroundImage: NetworkImage(
                                      Environment.baseUrl +
                                          snapshot.data![i].avatar),
                                ),
                                const SizedBox(width: 5.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                            text: snapshot.data![i].follower,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                        TextCustom(
                                            text: timeago.format(
                                                snapshot.data![i].createdAt,
                                                locale: 'vi'),
                                            fontSize: 14,
                                            color: Colors.grey),
                                      ],
                                    ),
                                    const SizedBox(width: 5.0),
                                    if (snapshot.data![i].typeNotification ==
                                        'add_fr')
                                      const TextCustom(
                                          text: 'Lời mời kết bạn',
                                          fontSize: 16),
                                    if (snapshot.data![i].typeNotification ==
                                        'join')
                                      const TextCustom(
                                          text: 'Đã theo dõi', fontSize: 16),
                                    if (snapshot.data![i].typeNotification ==
                                        'comment')
                                      const Row(
                                        children: [
                                          TextCustom(
                                              text: 'Đã thích ',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          TextCustom(
                                              text: 'bài viết của bạn',
                                              fontSize: 16),
                                        ],
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            if (snapshot.data![i].typeNotification == 'like')
                              Card(
                                color: ColorsCustom.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                elevation: 0,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(50.0),
                                    splashColor: Colors.white54,
                                    onTap: () {
                                      userBloc.add(OnAcceptFollowerRequestEvent(
                                          snapshot.data![i].followersUid,
                                          snapshot.data![i].uidNotification));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: TextCustom(
                                          text: 'Chấp nhận',
                                          fontSize: 16,
                                          color: Colors.white),
                                    )),
                              ),
                          ],
                        ),
                      );
                    },
                  );
          },
        )),
      ),
    );
  }
}
