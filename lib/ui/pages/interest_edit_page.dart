import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:you_app/cubit/user_cubit.dart';

import 'package:you_app/shared/theme.dart';
import 'package:you_app/ui/components/input_chips.dart';
import 'package:you_app/ui/components/text_form_field.dart';

class InterestEditPage extends StatefulWidget {
  const InterestEditPage({super.key});

  @override
  State<InterestEditPage> createState() => _InterestEditPageState();
}

class _InterestEditPageState extends State<InterestEditPage> {
  final TextEditingController interestController = TextEditingController();
  List<String> interests = [];

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
          // TODO: implement listener
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
                            context.read<UserCubit>().updateProfile(state.user.data.name ?? '', state.user.data.birthday ?? '', state.user.data.height.toString(), state.user.data.weight.toString(), interests);
                            Navigator.pushNamed(context, '/home');
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
                      if (state is UserSuccess) {
                        return Container(
                          margin: EdgeInsets.only(top: 34),
                          padding: EdgeInsets.symmetric(horizontal: 26),
                          child: EditableChipField<String>(
                            values: state.user.data.interests,
                            hintText: 'Search for toppings',
                            suggestionCallback: (String query) async {
                              return state.user.data.interests
                                  .where((String topping) =>
                                      topping.toLowerCase().contains(query.toLowerCase()))
                                  .toList();
                            },
                            onValuesChanged: (List<String> values) {
                              print(values);
                              setState(() {
                                interests = values;
                              });
                            },
                            chipBuilder: (BuildContext context, String topping) {
                              return InputChip(
                                label:   Text(topping),
                                backgroundColor: Colors.white.withOpacity(0.1),
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
