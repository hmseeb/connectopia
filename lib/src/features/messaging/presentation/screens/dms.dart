import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/messaging/dms_bloc/dms_bloc.dart';
import 'package:connectopia/src/features/messaging/domain/models/expanded_message.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DmsView extends StatefulWidget {
  const DmsView({super.key});

  @override
  State<DmsView> createState() => _DmsViewState();
}

class _DmsViewState extends State<DmsView> {
  late List<Message> messages;
  @override
  void initState() {
    super.initState();
    messages = context.read<DmsBloc>().dms;
    if (messages.isEmpty) {
      context.read<DmsBloc>().add(LoadDms());
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocConsumer<DmsBloc, DmsState>(
        listener: (context, state) {
          if (state is LoadedDms) {
            messages = context.read<DmsBloc>().dms;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: _height * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: _width * ScreenSize.kSpaceXL,
                      fontWeight: FontWeight.bold,
                      color: Pellet.kWhite,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      IconlyLight.add_user,
                      color: Pellet.kWhite,
                    ),
                  )
                ],
              ),
              SizedBox(height: _height * 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: _height * 5,
                decoration: BoxDecoration(
                    color: Pellet.kDark,
                    borderRadius: BorderRadius.circular(32)),
                child: TextField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Search for a person or message',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: _height * 2),
              CustomRefreshIndicator(
                builder: MaterialIndicatorDelegate(
                  builder: (context, controller) {
                    return Lottie.asset(Assets.progressIndicator);
                  },
                ),
                onRefresh: () async {
                  context.read<DmsBloc>().add(LoadDms());
                },
                child: Skeletonizer(
                  enabled: state is LoadingDms,
                  child: SizedBox(
                    child: state is LoadedDms
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              String time = messages[index]
                                  .updated
                                  .toString()
                                  .substring(11, 16);
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      MemoryImage(ProfileRepo.decodeBase64(
                                    messages[index].expand.sender.avatar,
                                  )),
                                ),
                                title: Text(
                                  messages[index].expand.sender.name,
                                ),
                                subtitle: Text(
                                  messages[index].content,
                                ),
                                trailing: Text(
                                  time,
                                ),
                              );
                            })
                        : FakeListView(),
                    height: _height * 80,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FakeListView extends StatelessWidget {
  const FakeListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            Assets.avatarPlaceholder,
          ),
        ),
        title: Text('John Doe'),
        subtitle: Text('Message content goes here'),
        trailing: Text('12:00'),
      ),
    );
  }
}
