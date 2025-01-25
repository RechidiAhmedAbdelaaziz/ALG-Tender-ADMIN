import 'package:flutter/material.dart';

class PaginationBuilder<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final VoidCallback onLoadMore;
  final Axis scrollDirection;

  const PaginationBuilder(
      {super.key,
      this.scrollDirection = Axis.vertical,
      required this.items,
      required this.itemBuilder,
      required this.onLoadMore});

  @override
  State<PaginationBuilder<T>> createState() =>
      _PaginationBuilderState<T>();
}

class _PaginationBuilderState<T> extends State<PaginationBuilder<T>> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.onLoadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: widget.scrollDirection,
      itemCount: widget.items.length,
      itemBuilder: (context, index) =>
          widget.itemBuilder(widget.items[index]),
    );
  }
}
