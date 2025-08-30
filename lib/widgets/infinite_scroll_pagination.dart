import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

typedef ItemFetcher<T> = Future<List<T>> Function(int offset, int limit);
typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item, int index);
typedef WidgetBuilderWithError = Widget Function(BuildContext context, Object? error);
typedef WidgetBuilderSimple = Widget Function(BuildContext context);

class InfiniteScrollPagination<T> extends StatefulWidget {
  final List<T>? staticItems;
  final ItemFetcher<T>? fetchItems;
  final ItemWidgetBuilder<T> itemBuilder;

  final int pageSize;
  final EdgeInsetsGeometry padding;
  final WidgetBuilderSimple? loadingBuilder;
  final WidgetBuilderSimple? noMoreItemsBuilder;
  final WidgetBuilderWithError? errorBuilder;
  final ScrollController? externalScrollController;

  const InfiniteScrollPagination({
    super.key,
    this.staticItems,
    this.fetchItems,
    required this.itemBuilder,
    this.pageSize = 10,
    this.padding = const EdgeInsets.all(8),
    this.loadingBuilder,
    this.noMoreItemsBuilder,
    this.errorBuilder,
    this.externalScrollController,
  }) : assert(
          staticItems != null || fetchItems != null,
          'Forneça staticItems ou fetchItems.',
        );

  @override
  State<InfiniteScrollPagination<T>> createState() => _InfiniteScrollPaginationState<T>();
}

class _InfiniteScrollPaginationState<T> extends State<InfiniteScrollPagination<T>> {
  late final ScrollController _scrollController;
  final List<T> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.externalScrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
    _loadMore();

    // Se a altura total for menor que a tela, carrega mais
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfNeedsMore();
    });
  }

  void _checkIfNeedsMore() {
    if (!_isLoading &&
        _hasMore &&
        _scrollController.hasClients &&
        _scrollController.position.maxScrollExtent <=
            _scrollController.position.viewportDimension) {
      _loadMore();
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading) return;
    _isLoading = true;
    _error = null;

    try {
      final offset = _items.length;
      final nextItems = widget.staticItems != null
          ? await Future.delayed(const Duration(milliseconds: 100), () {
              final end = min(offset + widget.pageSize, widget.staticItems!.length);
              return widget.staticItems!.sublist(offset, end);
            })
          : await widget.fetchItems!(offset, widget.pageSize);
      if (!mounted) return;
      setState(() {
        _items.addAll(nextItems);
        _hasMore = nextItems.length == widget.pageSize;
      });

      // Verifica novamente após inserir novos itens
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkIfNeedsMore();
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
    } finally {
      _isLoading = false;
    }
  }

  @override
  void dispose() {
    if (widget.externalScrollController == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: widget.padding,
      itemCount: _items.length + 1,
      itemBuilder: (context, index) {
        if (index < _items.length) {
          return widget.itemBuilder(context, _items[index], index);
        } else if (_error != null) {
          return widget.errorBuilder?.call(context, _error) ??
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: Text('Erro ao carregar itens')),
              );
        } else if (_hasMore) {
          return widget.loadingBuilder?.call(context) ??
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
        } else {
          return widget.noMoreItemsBuilder?.call(context) ??
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Icon(Icons.horizontal_rule_rounded, size: 30),
                ),
              );
        }
      },
    );
  }
}
