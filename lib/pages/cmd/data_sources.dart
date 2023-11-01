// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


/// Keeps track of selected rows, feed the data into DesertsDataSource
class RestorableDessertSelections extends RestorableProperty<Set<int>> {
  Set<int> _dessertSelections = {};

  /// Returns whether or not a dessert row is selected by index.
  bool isSelected(int index) => _dessertSelections.contains(index);

  /// Takes a list of [Dessert]s and saves the row indices of selected rows
  /// into a [Set].
  void setDessertSelections(List<Dessert> desserts) {
    final updatedSet = <int>{};
    for (var i = 0; i < desserts.length; i += 1) {
      var dessert = desserts[i];
      if (dessert.selected) {
        updatedSet.add(i);
      }
    }
    _dessertSelections = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _dessertSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _dessertSelections = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _dessertSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _dessertSelections = value;
  }

  @override
  Object toPrimitives() => _dessertSelections.toList();
}

int _idCounter = 0;

/// Domain model entity
class Dessert {
  Dessert(
    this.bcc_nupi,
    this.bcc_dat,
    this.bcc_lcli,
    this.bcc_eta,
  );

  final int id = _idCounter++;

  final String bcc_nupi;
  final int bcc_dat;
  final double bcc_lcli;
  final int bcc_eta;
  bool selected = false;
}

/// Data source implementing standard Flutter's DataTableSource abstract class
/// which is part of DataTable and PaginatedDataTable synchronous data fecthin API.
/// This class uses static collection of deserts as a data store, projects it into
/// DataRows, keeps track of selected items, provides sprting capability
class DessertDataSource extends DataTableSource {
  DessertDataSource.empty(this.context) {
    desserts = [];
  }

  DessertDataSource(this.context,
      [sortedByCalories = false,
      this.hasRowTaps = false,
      this.hasRowHeightOverrides = false,
      this.hasZebraStripes = false]) {
    desserts = _desserts;
    if (sortedByCalories) {
      sort((d) => d.bcc_dat, true);
    }
  }

  final BuildContext context;
  late List<Dessert> desserts;
  // Add row tap handlers and show snackbar
  bool hasRowTaps = false;
  // Override height values for certain rows
  bool hasRowHeightOverrides = false;
  // Color each Row by index's parity
  bool hasZebraStripes = false;

  void sort<T>(Comparable<T> Function(Dessert d) getField, bool ascending) {
    desserts.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  void updateSelectedDesserts(RestorableDessertSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < desserts.length; i += 1) {
      var dessert = desserts[i];
      if (selectedRows.isSelected(i)) {
        dessert.selected = true;
        _selectedCount += 1;
      } else {
        dessert.selected = false;
      }
    }
    notifyListeners();
  }

  @override
  DataRow getRow(int index, [Color? color]) {
    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(index >= 0);
    if (index >= desserts.length) throw 'index > _desserts.length';
    final dessert = desserts[index];
    return DataRow2.byIndex(
      index: index,
      selected: dessert.selected,
      color: color != null
          ? MaterialStateProperty.all(color)
          : (hasZebraStripes && index.isEven
              ? MaterialStateProperty.all(Theme.of(context).highlightColor)
              : null),
      onSelectChanged: (value) {
        if (dessert.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      onTap: hasRowTaps
          ? () => _showSnackbar(context, 'Tapped on row ${dessert.bcc_nupi}')
          : null,
      onDoubleTap: hasRowTaps
          ? () => _showSnackbar(context, 'Double Tapped on row ${dessert.bcc_nupi}')
          : null,
      onLongPress: hasRowTaps
          ? () => _showSnackbar(context, 'Long pressed on row ${dessert.bcc_nupi}')
          : null,
      onSecondaryTap: hasRowTaps
          ? () => _showSnackbar(context, 'Right clicked on row ${dessert.bcc_nupi}')
          : null,
      onSecondaryTapDown: hasRowTaps
          ? (d) =>
              _showSnackbar(context, 'Right button down on row ${dessert.bcc_nupi}')
          : null,
      specificRowHeight:
          hasRowHeightOverrides && dessert.bcc_lcli >= 25 ? 100 : null,
      cells: [
        DataCell(Text(dessert.bcc_nupi)),
        DataCell(Text('${dessert.bcc_dat}'),
            onTap: () => _showSnackbar(context,
                'Tapped on a cell with "${dessert.bcc_dat}"', Colors.red)),
        DataCell(Text(dessert.bcc_lcli.toStringAsFixed(1))),
        DataCell(Text('${dessert.bcc_eta}')),
      ],
    );
  }

  @override
  int get rowCount => desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (final dessert in desserts) {
      dessert.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? desserts.length : 0;
    notifyListeners();
  }
}

/// Async datasource for AsynPaginatedDataTabke2 example. Based on AsyncDataTableSource which
/// is an extension to FLutter's DataTableSource and aimed at solving
/// saync data fetching scenarious by paginated table (such as using Web API)
class DessertDataSourceAsync extends AsyncDataTableSource {
  DessertDataSourceAsync() {
    print('DessertDataSourceAsync created');
  }

  DessertDataSourceAsync.empty() {
    _empty = true;
    print('DessertDataSourceAsync.empty created');
  }

  DessertDataSourceAsync.error() {
    _errorCounter = 0;
    print('DessertDataSourceAsync.error created');
  }

  bool _empty = false;
  int? _errorCounter;

  RangeValues? _caloriesFilter;

  RangeValues? get caloriesFilter => _caloriesFilter;
  set caloriesFilter(RangeValues? calories) {
    _caloriesFilter = calories;
    refreshDatasource();
  }

  final DesertsFakeWebService _repo = DesertsFakeWebService();

  String _sortColumn = "name";
  bool _sortAscending = true;

  void sort(String columnName, bool ascending) {
    _sortColumn = columnName;
    _sortAscending = ascending;
    refreshDatasource();
  }

  Future<int> getTotalRecords() {
    return Future<int>.delayed(
        const Duration(milliseconds: 0), () => _empty ? 0 : _dessertsX3.length);
  }

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    print('getRows($startIndex, $count)');
    if (_errorCounter != null) {
      _errorCounter = _errorCounter! + 1;

      if (_errorCounter! % 2 == 1) {
        await Future.delayed(const Duration(milliseconds: 1000));
        throw 'Error #${((_errorCounter! - 1) / 2).round() + 1} has occured';
      }
    }

    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(startIndex >= 0);

    // List returned will be empty is there're fewer items than startingAt
    var x = _empty
        ? await Future.delayed(const Duration(milliseconds: 2000),
            () => DesertsFakeWebServiceResponse(0, []))
        : await _repo.getData(
            startIndex, count, _caloriesFilter, _sortColumn, _sortAscending);

    var r = AsyncRowsResponse(
        x.totalRecords,
        x.data.map((dessert) {
          return DataRow(
            key: ValueKey<int>(dessert.id),
            selected: dessert.selected,
            onSelectChanged: (value) {
              if (value != null) {
                setRowSelection(ValueKey<int>(dessert.id), value);
              }
            },
            cells: [
              DataCell(Text(dessert.bcc_nupi)),
              DataCell(Text('${dessert.bcc_dat}')),
              DataCell(Text(dessert.bcc_lcli.toStringAsFixed(1))),
              DataCell(Text('${dessert.bcc_eta}')),
            ],
          );
        }).toList());

    return r;
  }
}

class DesertsFakeWebServiceResponse {
  DesertsFakeWebServiceResponse(this.totalRecords, this.data);

  /// THe total ammount of records on the server, e.g. 100
  final int totalRecords;

  /// One page, e.g. 10 reocrds
  final List<Dessert> data;
}

class DesertsFakeWebService {
  int Function(Dessert, Dessert)? _getComparisonFunction(
      String column, bool ascending) {
    var coef = ascending ? 1 : -1;
    switch (column) {
      case 'name':
        return (Dessert d1, Dessert d2) => coef * d1.bcc_nupi.compareTo(d2.bcc_nupi);
      case 'calories':
        return (Dessert d1, Dessert d2) => coef * (d1.bcc_dat - d2.bcc_dat);
      case 'fat':
        return (Dessert d1, Dessert d2) => coef * (d1.bcc_lcli - d2.bcc_lcli).round();
      case 'carbs':
        return (Dessert d1, Dessert d2) => coef * (d1.bcc_eta - d2.bcc_eta);
      case 'sodium':
    }

    return null;
  }

  Future<DesertsFakeWebServiceResponse> getData(int startingAt, int count,
      RangeValues? caloriesFilter, String sortedBy, bool sortedAsc) async {
    return Future.delayed(
        Duration(
            milliseconds: startingAt == 0
                ? 2650
                : startingAt < 20
                    ? 2000
                    : 400), () {
      var result = _dessertsX3;

      if (caloriesFilter != null) {
        result = result
            .where((e) =>
                e.bcc_dat >= caloriesFilter.start &&
                e.bcc_dat <= caloriesFilter.end)
            .toList();
      }

      result.sort(_getComparisonFunction(sortedBy, sortedAsc));
      return DesertsFakeWebServiceResponse(
          result.length, result.skip(startingAt).take(count).toList());
    });
  }
}

int _selectedCount = 0;

List<Dessert> _desserts = <Dessert>[
  Dessert(
    'Frozen Yogurt',
    159,
    6.0,
    24,
  ),
  Dessert(
    'Ice Cream Sandwich',
    237,
    9.0,
    37,

  ),
  Dessert(
    'Eclair',
    262,
    16.0,
    24,

  ),
  Dessert(
    'Cupcake',
    305,
    3.7,
    67,
  ),
  Dessert(
    'Gingerbread',
    356,
    16.0,
    49,

  ),
  Dessert(
    'Jelly Bean',
    375,
    0.0,
    94,

  ),
  Dessert(
    'Lollipop',
    392,
    0.2,
    98,
  ),
  Dessert(
    'Honeycomb',
    408,
    3.2,
    87,
  ),
  Dessert(
    'Donut',
    452,
    25.0,
    51,
  ),
  Dessert(
    'Apple Pie',
    518,
    26.0,
    65,
  ),
  Dessert(
    'Frozen Yougurt with sugar',
    168,
    6.0,
    26,
  ),
  Dessert(
    'Ice Cream Sandich with sugar',
    246,
    9.0,
    39,
  ),
  Dessert(
    'Eclair with sugar',
    271,
    16.0,
    26,
  ),
  Dessert(
    'Cupcake with sugar',
    314,
    3.7,
    69,
  ),
  Dessert(
    'Gingerbread with sugar',
    345,
    16.0,
    51,
  ),
  Dessert(
    'Jelly Bean with sugar',
    364,
    0.0,
    96,
  ),
  Dessert(
    'Lollipop with sugar',
    401,
    0.2,
    100,
  ),
  Dessert(
    'Honeycomd with sugar',
    417,
    3.2,
    89,
  ),
  Dessert(
    'Donut with sugar',
    461,
    25.0,
    53,
  ),
  Dessert(
    'Apple pie with sugar',
    527,
    26.0,
    67,
  ),
  Dessert(
    'Forzen yougurt with honey',
    223,
    6.0,
    36,
  ),
  Dessert(
    'Ice Cream Sandwich with honey',
    301,
    9.0,
    49,
  ),
  Dessert(
    'Eclair with honey',
    326,
    16.0,
    36,
  ),
  Dessert(
    'Cupcake with honey',
    369,
    3.7,
    79,
  ),
  Dessert(
    'Gignerbread with hone',
    420,
    16.0,
    61,
  ),
  Dessert(
    'Jelly Bean with honey',
    439,
    0.0,
    106,
  ),
  Dessert(
    'Lollipop with honey',
    456,
    0.2,
    110,
  ),
  Dessert(
    'Honeycomd with honey',
    472,
    3.2,
    99,
  ),
  Dessert(
    'Donut with honey',
    516,
    25.0,
    63,
  ),
  Dessert(
    'Apple pie with honey',
    582,
    26.0,
    77,

  ),
];

List<Dessert> _dessertsX3 = _desserts.toList()
  ..addAll(_desserts.map((i) => Dessert('${i.bcc_nupi} x2', i.bcc_dat, i.bcc_lcli,
      i.bcc_eta)))
  ..addAll(_desserts.map((i) => Dessert('${i.bcc_nupi} x3', i.bcc_dat, i.bcc_lcli,
      i.bcc_eta)));

_showSnackbar(BuildContext context, String text, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 1),
    content: Text(text),
  ));
}
