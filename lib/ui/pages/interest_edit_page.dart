import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:you_app/cubit/user_cubit.dart';import 'dart:math';

import 'package:you_app/shared/theme.dart';
import 'package:you_app/ui/components/input_chips.dart';
import 'package:you_app/ui/components/text_form_field.dart';

class ButtonData {
  final Color buttonColor;
  final String emoji;
  const ButtonData(this.buttonColor, this.emoji);
}

class InterestEditPage extends StatefulWidget {
  const InterestEditPage({super.key});

  @override
  State<InterestEditPage> createState() => _InterestEditPageState();
}

class _InterestEditPageState extends State<InterestEditPage> {
  final TextEditingController interestController = TextEditingController();
  List<String> interests = [];
  late StringTagController _stringTagController;
  late double _distanceToField;
  final random = Random();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
    context.read<UserCubit>().getProfile();
  }

  static List<String> _initialTags = [];
  
  @override
  Widget build(BuildContext context) {
    Widget navBack() {
      return Container(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icon_back_nav.svg', // Path to your SVG file
                width: 18.0, // Adjust size as needed
                height: 18.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Back',
                style:
                    whiteTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
              ),
            ],
          ),
      ));
    }

      

    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            List<String> tags = state.user.data.interests;

            setState(() {
              _initialTags = tags;
            });
          }
        },
        builder: (context, state) {
          if(state is UserSuccess) {
            return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg-gradient.png'),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 18, right: 26, top: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        navBack(),
                        GestureDetector(
                          onTap: () {
                            if (_stringTagController.getTags != null &&
                                _stringTagController.getTags!.isNotEmpty) {

                              context.read<UserCubit>().updateProfile(
                                    state.user.data.name ?? '',
                                    state.user.data.birthday ?? '',
                                    state.user.data.height.toString(),
                                    state.user.data.weight.toString(),
                                    _stringTagController.getTags!,
                                  );

                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Save',
                            style: acientGradientTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 72),
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tell everyone about yourself',
                          style: goldGradientTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'What interest you?',
                          style: whiteTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<UserCubit, UserState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is UserSuccess && state.action == 'getProfile') {
                        return Container(
                          margin: const EdgeInsets.only(top: 34),
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: TextFieldTags<String>(
                          textfieldTagsController: _stringTagController,
                          initialTags: _initialTags,
                          textSeparators: const [' ', ','],
                          letterCase: LetterCase.normal,
                          validator: (String tag) {
                            if (_stringTagController.getTags!.contains(tag)) {
                              return 'You\'ve already entered that';
                            }
                            return null;
                          },
                          inputFieldBuilder: (context, inputFieldValues) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                  onTap: () {
                                    _stringTagController.getFocusNode?.requestFocus();
                                  },
                                  controller: inputFieldValues.textEditingController,
                                  focusNode: inputFieldValues.focusNode,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 74, 137, 92),
                                        width: 3.0,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 74, 137, 92),
                                        width: 3.0,
                                      ),
                                    ),
                                    hintText: '',
                                    errorText: inputFieldValues.error,
                                    prefixIconConstraints:
                                        BoxConstraints(maxWidth: _distanceToField * 0.8),
                                    prefixIcon: inputFieldValues.tags.isNotEmpty
                                        ? SingleChildScrollView(
                                            controller: inputFieldValues.tagScrollController,
                                            scrollDirection: Axis.vertical,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 8,
                                              ),
                                              child: Wrap(
                                                  runSpacing: 4.0,
                                                  spacing: 4.0,
                                                  children: inputFieldValues.tags
                                                      .map((String tag) {
                                                    return Container(
                                                      decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(4.0),
                                                        ),
                                                        color: Color.fromRGBO(255, 255, 255, 0.06),
                                                      ),
                                                      margin: const EdgeInsets.symmetric(
                                                          horizontal: 5.0),
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 10.0, vertical: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          InkWell(
                                                            child: Text(
                                                              '${tag}',
                                                              style: whiteTextStyle.copyWith(
                                                                fontSize: 12,
                                                                fontWeight: semiBold
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              // print("${tag.tag} selected");
                                                            },
                                                          ),
                                                          const SizedBox(width: 4.0),
                                                          InkWell(
                                                            child: const Icon(
                                                              Icons.cancel,
                                                              size: 14.0,
                                                              color: Colors.white,
                                                            ),
                                                            onTap: () {
                                                              inputFieldValues
                                                                  .onTagRemoved(tag);
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }).toList()),
                                            ),
                                          )
                                        : null,
                                  ),
                                  onChanged: inputFieldValues.onTagChanged,
                                  onSubmitted: inputFieldValues.onTagSubmitted,
                                ),
                              );
                            },
                          ),
                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                ],
              ),
            ),
          );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  
  }
  
}
