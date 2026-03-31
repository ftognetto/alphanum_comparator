# Column Selector Checkmark Fix

## Issue Description (MYV-311)

**Problem:** In the data table column selector, when a column is removed from the visible columns, the checkmark next to the column name doesn't disappear.

**Expected Behavior:** When a user clicks on a column in the selector to hide it, the checkmark should disappear immediately to indicate the column is no longer visible.

## Root Cause

The issue occurs when the state management for column visibility is not properly synchronized with the UI checkmark display. Common causes include:

1. **Stale State:** The column visibility state is not being updated correctly when toggling columns
2. **Rendering Issue:** The UI is not re-rendering when the visibility state changes
3. **Key-based Rendering:** Using incorrect or missing keys for the list items causing Flutter to not update the correct widgets
4. **Async State Updates:** State updates happening asynchronously without proper setState() calls

## Solution

The fix involves ensuring proper state management with the following key principles:

### 1. **Proper State Model**

```dart
class ColumnConfig {
  final String id;
  final String label;
  bool isVisible;  // Mutable state that tracks visibility

  ColumnConfig({
    required this.id,
    required this.label,
    required this.isVisible,
  });
}
```

### 2. **Synchronized Toggle Function**

```dart
void _toggleColumn(String columnId) {
  setState(() {
    final index = _availableColumns.indexWhere((col) => col.id == columnId);
    if (index != -1) {
      // Directly toggle the visibility
      _availableColumns[index].isVisible = !_availableColumns[index].isVisible;
    }
  });
}
```

**Key Points:**
- Always wrap state changes in `setState()`
- Update the state immediately and synchronously
- Use direct property mutation for simple boolean toggles

### 3. **Conditional Checkmark Rendering**

```dart
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
          // Only render checkmark if column is visible
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
```

**Key Points:**
- Use conditional rendering (`if (column.isVisible)`) instead of opacity or visibility widgets
- This ensures the widget is completely removed from the widget tree when not visible
- Avoids issues with widget recycling or stale references

### 4. **List Rebuilding on Filter**

```dart
List<ColumnConfig> get _filteredColumns {
  if (_searchQuery.isEmpty) {
    return _availableColumns;
  }
  return _availableColumns
      .where((col) => col.label.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();
}
```

**Key Points:**
- Always return a fresh list when filtering
- This ensures ListView.builder gets new data and rebuilds correctly

## Common Mistakes to Avoid

### ❌ **Mistake 1: Not Using setState()**
```dart
// WRONG - UI won't update
void _toggleColumn(String columnId) {
  final col = _availableColumns.firstWhere((c) => c.id == columnId);
  col.isVisible = !col.isVisible;
}
```

### ❌ **Mistake 2: Using Opacity Instead of Conditional Rendering**
```dart
// WRONG - Widget still exists in tree, just invisible
Opacity(
  opacity: column.isVisible ? 1.0 : 0.0,
  child: Icon(Icons.check),
)
```

### ❌ **Mistake 3: Async State Updates Without Callback**
```dart
// WRONG - State update happens after render
void _toggleColumn(String columnId) {
  Future.delayed(Duration.zero, () {
    setState(() {
      // Update state
    });
  });
}
```

### ✅ **Correct Approach**
```dart
// CORRECT - Immediate synchronous update
void _toggleColumn(String columnId) {
  setState(() {
    final index = _availableColumns.indexWhere((col) => col.id == columnId);
    if (index != -1) {
      _availableColumns[index].isVisible = !_availableColumns[index].isVisible;
    }
  });
}
```

## Testing the Fix

1. **Test Column Hiding:**
   - Click on a visible column in the selector
   - Verify the checkmark disappears immediately
   - Verify the column is removed from the data table

2. **Test Column Showing:**
   - Click on a hidden column (no checkmark)
   - Verify the checkmark appears immediately
   - Verify the column is added to the data table

3. **Test Search Filter:**
   - Type in the search box
   - Verify columns filter correctly
   - Verify checkmarks remain synchronized with actual visibility state

4. **Test Rapid Toggling:**
   - Quickly toggle columns on/off multiple times
   - Verify checkmarks always reflect the current state
   - Verify no visual glitches or lag

## Implementation Checklist

- [x] Use StatefulWidget for components with mutable state
- [x] Wrap all state mutations in setState()
- [x] Use conditional rendering (`if`) for checkmarks
- [x] Ensure toggle function is synchronous
- [x] Use proper key identification for list items
- [x] Test all edge cases (rapid toggling, search, etc.)

## Example Usage

See `example/lib/column_selector_example.dart` for a complete working implementation demonstrating the fix.

To run the example:

```bash
cd example
flutter run -d chrome  # For web
flutter run            # For mobile/desktop
```

## Related Issues

This fix addresses the core issue of checkmark synchronization and can be applied to similar problems:
- Checkbox state not updating in lists
- Toggle switches not reflecting state changes
- Filter selections not updating UI
- Any scenario where UI should reflect boolean state changes

## References

- Flutter State Management: https://docs.flutter.dev/development/data-and-backend/state-mgmt
- Flutter Stateful Widgets: https://docs.flutter.dev/development/ui/interactive
- Conditional Rendering in Flutter: https://dart.dev/guides/language/language-tour#control-flow-statements
