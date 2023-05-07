import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ssis/widgets/gradient_button.dart';
import 'package:ssis/widgets/window_button.dart';

class ParentContainer extends StatefulWidget {
  const ParentContainer({Key? key}) : super(key: key);

  @override
  State<ParentContainer> createState() => _ParentContainerState();
}

class _ParentContainerState extends State<ParentContainer> {
  String dropdownvalue = 'Item 1';
  var items = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child:
        Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 1260,
                    height: 30,
                    color: const Color(0xFF221C49),
                  ),
                  WindowTitleBarBox(
                    child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                                width: 20,
                                child: MoveWindow()
                            ),
                          ),
                          const SizedBox(
                              width: 100,
                              height: 30,
                              child: WindowButtons()
                          )
                        ]
                    ),
                  ),
                ],
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    const Material(
                      elevation: 30,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        side: BorderSide(color: Color(0xFF2F1176), width: 0.5),
                      ),
                      child: SizedBox(
                        height: 400,
                        width: 1090,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Material(
                      elevation: 8,
                      color: const Color(0xFF2F1176),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: SizedBox(
                        height: 50,
                        width: 1090,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 100,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'I.D Number',
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(50.0),
                                        gapPadding: 0,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  height: 35,
                                  width: 130,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'First Name',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(10), bottomLeft: Radius.circular(50), bottomRight: Radius.circular(10)),
                                          gapPadding: 0
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  width: 52,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'M.I.',
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(4.0),
                                        gapPadding: 0,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  width: 160,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Last Name',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(50), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(50)),
                                          gapPadding: 0
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  height: 35,
                                  width: 80,
                                  child: DropdownButtonFormField2(
                                    hint: const Padding(
                                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                                      child: Text(
                                        'Age',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(50.0),
                                          gapPadding: 0
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    items: List<int>.generate(100, (i) => i + 1).toList()
                                        .map((item) => DropdownMenuItem<String>(
                                      value: item.toString(),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                        child: Text(
                                          item.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),

                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Age';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      dropdownvalue = value.toString();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 200,
                                      padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 30,
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  height: 35,
                                  width: 100,
                                  child: DropdownButtonFormField2(
                                    hint: const Padding(
                                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                                      child: Text(
                                        'Sex',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(50.0),
                                          gapPadding: 0
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    items: ['Male','Female','Intersex']
                                        .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),

                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Sex';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      dropdownvalue = value.toString();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 200,
                                      padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  height: 35,
                                  width: 150,
                                  child: DropdownButtonFormField2(
                                    hint: const Padding(
                                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                                      child: Text(
                                        'Courses',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(50.0),
                                          gapPadding: 0
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    items: items
                                        .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),

                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Course';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      dropdownvalue = value.toString();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 200,
                                      padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  height: 35,
                                  width: 110,
                                  child: DropdownButtonFormField2(
                                    hint: const Padding(
                                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                                      child: Text(
                                        'Year Level',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(50.0),
                                          gapPadding: 0
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    items: ['1st','2nd','3rd','4th','5th']
                                        .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),

                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Year Level';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      dropdownvalue = value.toString();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 200,
                                      padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GradientButton(
                                  onPressed: (){},
                                  height: 35,
                                  width: 120,
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(20),
                                  colors: const [ Color(0xff6433e8), Color(0xff6325e8) ],
                                  child: const Center(
                                    child: Text(
                                      'ADD STUDENT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Material(
                      elevation: 8,
                      color: const Color(0xFF2F1176),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: SizedBox(
                        height: 50,
                        width: 1090,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Bachelor of',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  width: 130,
                                  child: DropdownButtonFormField2(
                                    hint: const Padding(
                                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                                      child: Text(
                                        'Bachelor Type',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(50.0),
                                          gapPadding: 0
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    items: ['Arts','Science']
                                        .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    )).toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Bachelor Type';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      dropdownvalue = value.toString();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 200,
                                      padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'in',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  width: 500,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Course',
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(50.0),
                                        gapPadding: 0,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  height: 35,
                                  width: 150,
                                  child: DropdownButtonFormField2(
                                    hint: const Padding(
                                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                                      child: Text(
                                        'College',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(50.0),
                                          gapPadding: 0
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    items: ['CASS', 'CEBA', 'CED', 'CCS', 'CHS', 'COE', 'CSM']
                                        .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),

                                        ),
                                      ),
                                    )).toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'College';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      dropdownvalue = value.toString();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 200,
                                      padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GradientButton(
                                  onPressed: (){},
                                  height: 35,
                                  width: 120,
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(20),
                                  colors: const [ Color(0xff6433e8), Color(0xff6325e8) ],
                                  child: const Center(
                                    child: Text(
                                      'ADD COURSE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]
        )
    );
  }
}