import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'custom_button.dart';
import 'custom_edittext.dart';

class FilterHeader extends StatefulWidget {
  FilterHeader(
      {Key? key,
      this.onFilterTap,
      this.onSearchChanged,
      this.isLoading = false})
      : super(key: key);

  Function(String, String)? onFilterTap;
  Function(String)? onSearchChanged;
  bool isLoading;

  @override
  State<FilterHeader> createState() => _FilterHeaderState();
}

class _FilterHeaderState extends State<FilterHeader> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  TextEditingController fromDateController = TextEditingController();

  TextEditingController toDateController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  String showFormat = "dd-MM-yyyy";
  String sendFormat = "MM/dd/yyyy";

  @override
  void initState() {
    fromDate = DateTime(fromDate.year, fromDate.month, 1);
    fromDateController.text = DateFormat(showFormat).format(fromDate);
    toDateController.text = DateFormat(showFormat).format(toDate);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("From",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomEditText(
                    width: Get.width * .32,
                    readOnly: true,
                    showCursor: false,
                    controller: fromDateController,
                    hintText: "",
                    fontSize: 13,
                    onTab: () async {
                      var selectedDate = await showDatePicker(
                        initialDate: fromDate,
                        lastDate: toDate,
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        context: context,
                      );

                      if (selectedDate != null) {
                        fromDate = selectedDate;
                        fromDateController.text =
                            DateFormat(showFormat).format(selectedDate);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("To",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomEditText(
                    width: Get.width * 0.32,
                    readOnly: true,
                    showCursor: false,
                    controller: toDateController,
                    hintText: "",
                    fontSize: 13,
                    onTab: () async {
                      var selectedDate = (await showDatePicker(
                        initialDate: toDate,
                        lastDate: DateTime.now(),
                        firstDate: fromDate,
                        context: Get.context!,
                      ));

                      if (selectedDate != null) {
                        toDate = selectedDate;
                        toDateController.text =
                            DateFormat(showFormat).format(selectedDate);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: CustomButton(
                    text: "Filter",
                    isLoading: widget.isLoading,
                    onTap: () async {
                      widget.onFilterTap!(
                          DateFormat(sendFormat).format(fromDate),
                          DateFormat(sendFormat).format(toDate));
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          CustomEditText(
            controller: searchController,
            hintText: "Search",
            maxLines: 1,
            onChanged: (val) {
              widget.onSearchChanged!(searchController.text);
            },
            suffixIcon: GestureDetector(
                onTap: () {
                  searchController.clear();
                  widget.onSearchChanged!('');
                },
                child: const Icon(
                  Icons.clear,
                  size: 20,
                )),
          )
        ],
      ),
    );
  }
}
