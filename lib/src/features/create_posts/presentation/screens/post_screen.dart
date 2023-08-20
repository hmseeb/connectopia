import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  bool _toggleStory = false;
  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: Pellete.kBackgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(
                height: 48,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    onPressed: () {},
                    child: Text(
                      'POST',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.blue,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: _height * 35,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Pellete.kDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  onTapOutside: ((event) => FocusScope.of(context).unfocus()),
                  maxLines: 16,
                  maxLength: 520,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    hintText: 'What would you like to say?',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: _width * 80,
        padding: const EdgeInsets.only(left: 8),
        height: 40,
        decoration: BoxDecoration(
          color: Pellete.kDark.withOpacity(0.3),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                IconlyBold.image,
                color: Pellete.kWhite,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                IconlyBold.camera,
                color: Pellete.kWhite,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                IconlyBold.location,
                color: Pellete.kWhite,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.solidFaceSmile,
                color: Pellete.kWhite,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _toggleStory = !_toggleStory;
                  });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Pellete.kDark,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Text('Story'),
                      const SizedBox(width: 8),
                      Switch(
                          value: _toggleStory,
                          onChanged: (value) {
                            setState(() {
                              _toggleStory = value;
                            });
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
