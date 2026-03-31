import 'package:flutter/material.dart';

void main() {
  runApp(const ColumnSelectorApp());
}

class ColumnSelectorApp extends StatelessWidget {
  const ColumnSelectorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Column Selector Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DataTableWithColumnSelector(),
    );
  }
}

class DataTableWithColumnSelector extends StatefulWidget {
  const DataTableWithColumnSelector({Key? key}) : super(key: key);

  @override
  State<DataTableWithColumnSelector> createState() =>
      _DataTableWithColumnSelectorState();
}

class _DataTableWithColumnSelectorState
    extends State<DataTableWithColumnSelector> {
  final List<ColumnConfig> _availableColumns = [
    ColumnConfig(id: 'nome', label: 'Nome', isVisible: true),
    ColumnConfig(
        id: 'tipo_organizzazione',
        label: 'Tipo Organizzazione',
        isVisible: true),
    ColumnConfig(id: 'licenza', label: 'Licenza', isVisible: true),
    ColumnConfig(id: 'attrezzatura', label: 'Attrezzatura', isVisible: false),
    ColumnConfig(id: 'dispositivi', label: 'Dispositivi', isVisible: false),
  ];

  final List<Map<String, String>> _sampleData = [
    {
      'nome': 'Ente 1',
      'tipo_organizzazione': 'Associazione',
      'licenza': 'Attiva',
      'attrezzatura': '10',
      'dispositivi': '5',
    },
    {
      'nome': 'Ente 2',
      'tipo_organizzazione': 'Coordinamento',
      'licenza': 'Attiva',
      'attrezzatura': '15',
      'dispositivi': '8',
    },
    {
      'nome': 'Ente 3',
      'tipo_organizzazione': 'Regione',
      'licenza': 'Scaduta',
      'attrezzatura': '20',
      'dispositivi': '12',
    },
  ];

  String _searchQuery = '';

  void _toggleColumn(String columnId) {
    setState(() {
      final index =
          _availableColumns.indexWhere((col) => col.id == columnId);
      if (index != -1) {
        _availableColumns[index].isVisible =
            !_availableColumns[index].isVisible;
      }
    });
  }

  List<ColumnConfig> get _visibleColumns =>
      _availableColumns.where((col) => col.isVisible).toList();

  List<ColumnConfig> get _filteredColumns {
    if (_searchQuery.isEmpty) {
      return _availableColumns;
    }
    return _availableColumns
        .where((col) =>
            col.label.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Table with Column Selector'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enti',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                _buildColumnSelectorButton(),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: _buildDataTable(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumnSelectorButton() {
    return MenuAnchor(
      builder: (context, controller, child) {
        return ElevatedButton.icon(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.view_column),
          label: const Text('Colonne'),
        );
      },
      menuChildren: [
        Container(
          width: 300,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search columns...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              const Divider(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredColumns.length,
                  itemBuilder: (context, index) {
                    final column = _filteredColumns[index];
                    return _buildColumnMenuItem(column);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColumnMenuItem(ColumnConfig column) {
    return InkWell(
      onTap: () {
        _toggleColumn(column.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                column.label,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (column.isVisible)
              const Icon(
                Icons.check,
                color: Colors.blue,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
      columns: _visibleColumns
          .map((col) => DataColumn(
                label: Text(
                  col.label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ))
          .toList(),
      rows: _sampleData
          .map((data) => DataRow(
                cells: _visibleColumns
                    .map((col) => DataCell(Text(data[col.id] ?? '')))
                    .toList(),
              ))
          .toList(),
    );
  }
}

class ColumnConfig {
  final String id;
  final String label;
  bool isVisible;

  ColumnConfig({
    required this.id,
    required this.label,
    required this.isVisible,
  });
}
