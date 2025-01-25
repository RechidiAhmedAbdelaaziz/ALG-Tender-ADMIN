import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/themes/colors.dart';

class KSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  const KSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  State<KSearchBar> createState() => _KSearchBarState();
}

class _KSearchBarState extends State<KSearchBar> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () => widget.onSearch(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: KColors.grey),
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          widthSpace(8),
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: _onSearchChanged, // Use debounced onChanged
              decoration: const InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
