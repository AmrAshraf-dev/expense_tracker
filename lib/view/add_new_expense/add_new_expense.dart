import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_tracker/controller/database_helper.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/utils/colors.dart';
import 'package:expense_tracker/view/add_new_expense/bloc/bloc.dart';
import 'package:expense_tracker/view/add_new_expense/bloc/event.dart';
import 'package:expense_tracker/view/add_new_expense/bloc/state.dart';
import 'package:expense_tracker/view/add_new_expense/widgets/categories_view.dart';
import 'package:expense_tracker/widgets/entry_field.dart';
import 'package:expense_tracker/widgets/my_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense({super.key});

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  TextEditingController datePickerController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String? selectedCurrency;
  double? convertedValue;

  @override
  void initState() {
    super.initState();
    context.read<CurrencyBloc>().add(FetchCurrencies());
  }

  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }

// Function to handle form for upload Image and file
  File? _selectedImage;
  File? _selectedFile;
  String? _fileName;
  Future<void> _showUploadOptions() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Upload Image'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file),
                title: const Text('Upload File'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _selectedFile = null;
        _fileName = pickedFile.name;
      });
      // Here you would typically upload the image to your server
      _showUploadSuccess('Image selected: ${pickedFile.name}');
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _selectedImage = null;
        _fileName = result.files.single.name;
      });
      // Here you would typically upload the file to your server
      _showUploadSuccess('File selected: ${result.files.single.name}');
    }
  }

  void _showUploadSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Groceries',
      'Entertainment',
      'Transportation',
      'Rent',
      'Gas',
      'Shopping',
      'News paper',
    ];
    String? selectedValue;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          title: 'Add  Expense',
          fontWeight: FontWeight.bold,
          size: 20,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            MyText(title: 'Categories', fontWeight: FontWeight.bold, size: 16),
            //Dropdown
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: InputBorder.none,
                fillColor: Colors.grey[200],
                filled: true,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.grey[200] ?? Colors.transparent,
                    width: 1.0,
                  ),
                ),
              ),
              hint: const Text(
                'Select category',
                style: TextStyle(fontSize: 14),
              ),
              items: categories
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select category.';
                }
                return null;
              },
              onChanged: (value) {
                //Do something when selected item is changed.
                selectedValue = value.toString();
              },
              onSaved: (value) {
                selectedValue = value.toString();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.black45,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 30),

            MyText(title: 'Amount', fontWeight: FontWeight.bold, size: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<CurrencyBloc, CurrencyState>(
                  builder: (context, state) {
                    if (state is CurrencyLoading) {
                      return CircularProgressIndicator();
                    } else if (state is CurrencyLoaded) {
                      return DropdownButton<String>(
                        //  dropdownColor: MyColors.grey,
                        hint: Text("Select currency"),
                        value: selectedCurrency,
                        onChanged: (value) {
                          setState(() {
                            selectedCurrency = value;
                            if (value != null &&
                                amountController.text.isNotEmpty) {
                              final double amount =
                                  double.tryParse(amountController.text) ?? 0;
                              convertedValue =
                                  amount / (state.rates[value] ?? 1.0);
                            }
                          });
                        },
                        items: state.currencies
                            .map((currency) => DropdownMenuItem(
                                  value: currency,
                                  child: Text(currency),
                                ))
                            .toList(),
                      );
                    } else if (state is CurrencyError) {
                      return Text("Error: ${state.message}");
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: EntryField(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    fieldTextEditingController: amountController,
                    isPassword: false,
                    labelText: 'Enter amount',
                    onChange: (value) {
                      if (selectedCurrency != null &&
                          context.read<CurrencyBloc>().state
                              is CurrencyLoaded) {
                        final state = context.read<CurrencyBloc>().state
                            as CurrencyLoaded;
                        final double amount =
                            double.tryParse(amountController.text) ?? 0;
                        setState(() {
                          convertedValue =
                              amount / (state.rates[selectedCurrency] ?? 1.0);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                    hintText: '50,000',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            if (convertedValue != null)
              MyText(
                  title: 'USD Value: ${convertedValue?.toStringAsFixed(2)}',
                  fontWeight: FontWeight.bold,
                  size: 16),
            SizedBox(height: 16.0),
            MyText(title: 'Date', fontWeight: FontWeight.bold, size: 16),

            TextFormField(
              controller: datePickerController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Click here to select date",
                suffixIcon: Icon(Icons.calendar_today_outlined),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              onTap: () => onTapFunction(context: context),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a date';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            //Attach image or file
            MyText(
                title: 'Attach Receipt', fontWeight: FontWeight.bold, size: 16),
            _selectedImage == null && _selectedFile == null
                ? Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _showUploadOptions,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                      title: 'Upload image',
                                      size: 14,
                                      color: Colors.black26),
                                  Icon(Icons.fit_screen_outlined,
                                      color: Colors.black),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : _selectedImage != null
                    ? Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('$_fileName'),
                            IconButton(
                              icon: Icon(Icons.refresh_outlined, size: 25),
                              onPressed: () {
                                setState(() {
                                  _selectedImage = null;
                                  _selectedFile = null;
                                  _fileName = null;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    : Container(),
            _selectedFile != null
                ? Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Icon(Icons.insert_drive_file, size: 25),
                        Text('$_fileName'),
                        IconButton(
                          icon: Icon(Icons.refresh_outlined, size: 25),
                          onPressed: () {
                            setState(() {
                              _selectedImage = null;
                              _selectedFile = null;
                              _fileName = null;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(height: 16.0),
            MyText(title: 'Categories', fontWeight: FontWeight.bold, size: 16),
            SizedBox(height: 16.0),

            ///
            ///
            ///
            CategoriesView(),
            SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    final newExpense = ExpenseModel(
                      category: selectedValue ?? 'Uncategorized',
                      amount: double.parse(convertedValue?.toString() ?? '0'),
                      date: datePickerController.text,
                      imagePath: _selectedImage?.path,
                      filePath: _selectedFile?.path,
                    );

                    await DatabaseHelper().insertExpense(newExpense);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Expense added successfully!'),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: MyText(
                    title: 'Save',
                    color: MyColors.white,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
