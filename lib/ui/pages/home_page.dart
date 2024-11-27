import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:you_app/cubit/auth_cubit.dart';
import 'package:you_app/cubit/user_cubit.dart';
import 'package:you_app/shared/theme.dart';

import '../components/select_option.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  var editSection = '';
  String? _selectedGender;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getProfile();
  }

  void _setEdit(String val) {
    setState(() {
      editSection = val;
    });
  }

  void _handleValueChanged(String? newValue) {
    setState(() {
      _selectedGender = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget navBack() {
      return Container(
          child: TextButton(
        onPressed: () {
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

    Widget aboutForm() {
      return Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/add_image.png')),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                'Add image',
                style:
                    whiteTextStyle.copyWith(fontSize: 12, fontWeight: medium),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  'Display name:',
                  style:
                      grayTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  flex: 4,
                  child: SizedBox(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: 'Enter Name',
                          hintStyle: grayTextStyle.copyWith(
                              fontSize: 13, fontWeight: medium),
                          fillColor: Color.fromRGBO(217, 217, 217, 0.06),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 0.22)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          alignLabelWithHint: true),
                      textAlign: TextAlign.right,
                      style: whiteTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  'Gender:',
                  style:
                      grayTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(flex: 4, 
                child: SizedBox(
                  child: SelectOption(
                    onValueChanged: _handleValueChanged
                  )
                )
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  'Birthday:',
                  style:
                      grayTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(flex: 4, 
                child: SizedBox(
                  child: TextFormField(
                    controller: _birthDateController,
                    onTap: () {
                      print('hai');
                      BottomPicker.date(
                        pickerTitle: Text(
                              'Set your Birthday',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: kWhiteColor,
                              ),
                            ),
                            dateOrder: DatePickerDateOrder.dmy,
                            initialDateTime: DateTime(1996, 10, 22),
                            maxDateTime: DateTime(2017),
                            minDateTime: DateTime(1980),
                            pickerTextStyle: TextStyle(
                              color: kWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            onChange: (index) {
                            },
                            onSubmit: (index) {
                              final DateFormat formatter = DateFormat('dd MM yyyy');
                              _birthDateController.text = formatter.format(index);
                            },
                            bottomPickerTheme: BottomPickerTheme.plumPlate,
                            backgroundColor: kBlackColor,
                      ).show(context);
                    },
                    decoration: InputDecoration(
                        hintText: 'DD MM YYYY',
                        hintStyle: grayTextStyle.copyWith(
                            fontSize: 13, fontWeight: medium),
                        fillColor: Color.fromRGBO(217, 217, 217, 0.06),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 0.22)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        alignLabelWithHint: true
                      ),
                    textAlign: TextAlign.right,
                    style: whiteTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: medium,
                    ),
                    readOnly: true,
                    ),
                )
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  'Horoscope:',
                  style:
                      grayTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  flex: 4,
                  child: SizedBox(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: '--',
                          hintStyle: grayTextStyle.copyWith(
                              fontSize: 13, fontWeight: medium),
                          fillColor: Color.fromRGBO(217, 217, 217, 0.06),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 0.22)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          alignLabelWithHint: true),
                      textAlign: TextAlign.right,
                      style: whiteTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  'Zodiac:',
                  style:
                      grayTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  flex: 4,
                  child: SizedBox(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: '--',
                          hintStyle: grayTextStyle.copyWith(
                              fontSize: 13, fontWeight: medium),
                          fillColor: Color.fromRGBO(217, 217, 217, 0.06),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 0.22)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          alignLabelWithHint: true),
                      textAlign: TextAlign.right,
                      style: whiteTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  'Height:',
                  style:
                      grayTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  flex: 4,
                  child: SizedBox(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: InputDecoration(
                          hintText: 'Add height',
                          hintStyle: grayTextStyle.copyWith(
                              fontSize: 13, fontWeight: medium),
                          fillColor: Color.fromRGBO(217, 217, 217, 0.06),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 0.22)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          alignLabelWithHint: true),
                      textAlign: TextAlign.right,
                      style: whiteTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  'Weight:',
                  style:
                      grayTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  flex: 4,
                  child: SizedBox(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(
                          hintText: 'Add weight',
                          hintStyle: grayTextStyle.copyWith(
                              fontSize: 13, fontWeight: medium),
                          fillColor: Color.fromRGBO(217, 217, 217, 0.06),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 0.22)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          alignLabelWithHint: true),
                      textAlign: TextAlign.right,
                      style: whiteTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: medium,
                      ),
                    ),
                  ))
            ],
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xff09141A),
      body: SafeArea(
        child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserFailed && state.action == 'getProfile') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.error),
              ),
            );
            context.read<AuthCubit>().logout();
            Navigator.pushNamed(context, '/login');
          }
          if (state is UserSuccess && state.action == 'getProfile') {
            _nameController.text = state.user.data.name!;
            _heightController.text = state.user.data.height.toString();
            _weightController.text = state.user.data.weight.toString();
            _birthDateController.text = state.user.data.birthday!;
          }
          if (state is UserSuccess && state.action == 'updateProfile') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(state.user.message),
              ),
            );
            setState(() {
              editSection = '';
            });
          }
          if (state is UserFailed && state.action == 'updateProfile') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UserSuccess && (state.action == 'getProfile' || state.action == 'updateProfile')) {
            return ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 36.0),
                  padding: EdgeInsets.symmetric(horizontal: navMargin),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          navBack(),
                          Text("@${state.user.data.username}",
                              style: whiteTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold)),
                          TextButton(
                            onPressed: () {},
                            child: SvgPicture.asset(
                              'assets/dots-nav.svg',
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 190,
                        margin: const EdgeInsets.only(top: 28),
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/default_profile_img.png'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 18, right: 14, left: 14, bottom: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: SvgPicture.asset('assets/edit_icon.svg'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("@${state.user.data.username}",
                                      style: whiteTextStyle.copyWith(
                                          fontSize: 14, fontWeight: semiBold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        // height: 120,
                        margin: const EdgeInsets.only(top: 24),
                        decoration: BoxDecoration(
                            color: const Color(0xff0E191F),
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 18, right: 14, left: 14, bottom: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'About',
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 14, fontWeight: bold),
                                  ),
                                  if (editSection == 'about') GestureDetector(
                                        onTap: () {
                                          print(state.user.data.interests.runtimeType);
                                          context.read<UserCubit>().updateProfile(
                                            _nameController.text,
                                            _birthDateController.text,
                                            _heightController.text,
                                            _weightController.text,
                                            state.user.data.interests
                                          );
                                        },
                                        child: state is UserLoading && state.action == 'updateProfile' ? 
                                          Text(
                                              'Loading',
                                              style: goldGradientTextStyle.copyWith(
                                                  fontSize: 12, fontWeight: bold),
                                          )
                                          :
                                          Text(
                                              'Save & Update',
                                              style: goldGradientTextStyle.copyWith(
                                                  fontSize: 12, fontWeight: bold),
                                          ),
                                      ) else TextButton(
                                          onPressed: () {
                                            _setEdit('about');
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size.zero,
                                            tapTargetSize:
                                                MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          child: SvgPicture.asset(
                                              'assets/edit_icon.svg'),
                                        ),
                                ],
                              ),
                              const SizedBox(height: 34),
                              editSection == 'about'
                                  ? aboutForm()
                                  : state.user.data.name != null && state.user.data.name!.isNotEmpty ? 
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text('Birthday: ', 
                                              style: grayTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: medium
                                              ),
                                            ),
                                            Text(state.user.data.birthday ?? '', 
                                              style: whiteTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: medium
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Horoscope: ', 
                                              style: grayTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: medium
                                              ),
                                            ),
                                            Text(state.user.data.horoscope ?? '', 
                                              style: whiteTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: medium
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Zodiac: ', 
                                              style: grayTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: medium
                                              ),
                                            ),
                                            Text(state.user.data.zodiac ?? '-', 
                                              style: whiteTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: medium
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Height: ', 
                                              style: grayTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: medium
                                              ),
                                            ),
                                            Text("${state.user.data.height.toString()} cm", 
                                              style: whiteTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: medium
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Text('Weight: ', 
                                              style: grayTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: medium
                                              ),
                                            ),
                                            Text("${state.user.data.weight.toString()} kg", 
                                              style: whiteTextStyle.copyWith(
                                                fontSize: 13,
                                                fontWeight: medium
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                    :
                                    Text(
                                      'Add in your your to help others know you better',
                                      style: whiteTextStyle.copyWith(
                                          fontSize: 14, fontWeight: medium),
                                    )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        // height: 120,
                        margin: const EdgeInsets.only(top: 24),
                        decoration: BoxDecoration(
                            color: const Color(0xff0E191F),
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 18, right: 14, left: 14, bottom: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Interest',
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 14, fontWeight: bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/interest');
                                    },
                                    child: SvgPicture.asset('assets/edit_icon.svg'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 28),
                              state.user.data.interests.isNotEmpty
                                  ? Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: state.user.data.interests
                                      .map<Widget>((interest) => Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.06), // Semi-transparent white
                                          borderRadius: BorderRadius.circular(16), // Match Chip shape
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                          child: Text(
                                            interest,
                                            style: whiteTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: semiBold
                                            ), // Set text color
                                          ),
                                        ),
                                      ),
                                    ).toList(),
                                  )
                                  : Text(
                                      'Add in your interest to find a better match',
                                      style: whiteTextStyle.copyWith(
                                          fontSize: 14, fontWeight: medium),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
