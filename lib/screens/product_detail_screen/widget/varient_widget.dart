import 'package:flutter/material.dart';
import 'package:miraki_app/components/label_text.dart';
import 'package:miraki_app/constants/dimensions.dart';
import 'package:miraki_app/constants/style.dart';
import 'package:miraki_app/models/varient_detail_model.dart';
import 'package:miraki_app/models/varient_model.dart';

class VarientWidget extends StatelessWidget {
  final List<Varient> varientList;
  final Function(List<VarientDetail>) onSelectVarient;
  final List<VarientDetail> selectedVarientList;
  const VarientWidget(
      {Key? key,
      required this.varientList,
      required this.onSelectVarient,
      required this.selectedVarientList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...varientList
            .asMap()
            .map((index, varient) {
              return MapEntry(
                  index,
                  VarientList(
                    varient: varient,
                    selectedVarients: selectedVarientList,
                    onSelected: (varientDetail) {
                      selectedVarientList[index] = varientDetail;

                      onSelectVarient(selectedVarientList);
                    },
                  ));
            })
            .values
            .toList()
      ],
    );
  }
}

class VarientList extends StatefulWidget {
  final Varient varient;
  final List<VarientDetail> selectedVarients;
  final Function(VarientDetail) onSelected;
  const VarientList(
      {Key? key,
      required this.varient,
      required this.onSelected,
      required this.selectedVarients})
      : super(key: key);

  @override
  _VarientListState createState() => _VarientListState();
}

class _VarientListState extends State<VarientList> {
  int _selectedVarientIndex = 0;
  List<VarientDetail> _varientDetailList = [];

  @override
  void initState() {
    _varientDetailList = widget.varient.varientList;
    if (widget.selectedVarients.isNotEmpty) {
      for (int i = 0; i < _varientDetailList.length; i++) {
        final query = widget.selectedVarients.where(
            (element) => element.valueName == _varientDetailList[i].valueName);
        if (query.isNotEmpty) {
          _selectedVarientIndex = i;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _thinDivider,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            LabelText(
                label: widget.varient.name,
                value: _varientDetailList[_selectedVarientIndex].valueName),
            spaceOf10,
            SizedBox(
              height: 40.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _varientDetailList.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: VarientCard(
                        varientDetail: _varientDetailList[index],
                        isSelected: _selectedVarientIndex == index,
                        onTap: () {
                          widget.onSelected(_varientDetailList[index]);
                          setState(() => _selectedVarientIndex = index);
                        },
                      ),
                    );
                  }),
            )
          ]),
        ),
      ],
    );
  }

  Widget get _thinDivider => Divider(
        height: 35.0,
        color: AppColor.lightGrey.withOpacity(.2),
        thickness: 2.0,
      );
}

class VarientCard extends StatelessWidget {
  final VarientDetail varientDetail;
  final bool isSelected;
  final Function() onTap;
  const VarientCard(
      {Key? key,
      required this.varientDetail,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.only(right: 16.0),
          decoration: BoxDecoration(
              color: isSelected
                  ? AppColor.primaryColor.withOpacity(.06)
                  : AppColor.lightGrey.withOpacity(.06),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                  color:
                      isSelected ? AppColor.primaryColor : AppColor.lightGrey)),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Text(varientDetail.valueName,
              style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: AppColor.darkColor))),
    );

    // return GestureDetector(
    //   onTap: () {
    //     onTap();
    //   },
    //   child: Container(
    //     margin: const EdgeInsets.only(right: 16.0),
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(8.0),
    //         border: Border.all(
    //             color:
    //                 isSelected ? AppColor.primaryColor : AppColor.lightGrey)),
    //     child: Column(
    //       children: [
    //         Container(
    //             color: isSelected
    //                 ? AppColor.primaryColor.withOpacity(.06)
    //                 : AppColor.lightGrey.withOpacity(.06),
    //             padding: const EdgeInsets.all(8.0),
    //             child: Text(varientDetail.valueName,
    //                 style: const TextStyle(
    //                     fontSize: 15.0,
    //                     fontWeight: FontWeight.w600,
    //                     color: AppColor.darkColor))),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text('${varientDetail.priceChange}',
    //               style: const TextStyle(
    //                   fontSize: 20.0,
    //                   fontWeight: FontWeight.w400,
    //                   color: AppColor.darkColor)),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
