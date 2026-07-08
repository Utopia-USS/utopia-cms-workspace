import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_cms/src/delegate/cms_delegate_exception.dart';
import 'package:utopia_cms/src/model/entry/cms_entry.dart';
import 'package:utopia_cms/src/model/entry/cms_entry_modifier.dart';
import 'package:utopia_cms/src/model/entry/primitives/cms_text_entry.dart';
import 'package:utopia_cms/src/model/table/cms_table_page_params.dart';
import 'package:utopia_cms/src/ui/item_management/cms_management_page.dart';
import 'package:utopia_cms/src/ui/item_management/state/cms_management_state.dart';
import 'package:utopia_cms/src/util/foundation.dart';
import 'package:utopia_cms/src/util/json_map.dart';

SimpleHookContext<CmsItemManagementState> _build({
  JsonMap? initialValue,
  Future<JsonMap> Function(JsonMap newJson, JsonMap? oldJson)? uploadChanges,
  Future<void> Function()? deleteItem,
  IList<CmsEntry<dynamic>> entries = const IList.empty(),
  CmsTableParams params = CmsTableParams.defaultParams,
  // ignore: avoid_positional_boolean_parameters
  void Function(bool)? moveBack,
}) {
  return SimpleHookContext<CmsItemManagementState>(
    () => useCmsItemManagementState(
      args: CmsManagementArgs(
        initialValue: initialValue,
        uploadChanges: uploadChanges ?? (newJson, oldJson) async => newJson,
        deleteItem: deleteItem,
        params: params,
        entries: entries,
        sectionEntries: const [],
      ),
      moveBack: moveBack ?? (_) {},
    ),
  );
}

void main() {
  group('useCmsItemManagementState', () {
    test('create mode starts with empty values, isEdit false and no changes', () {
      final context = _build();
      addTearDown(context.dispose);

      expect(context().isEdit, isFalse);
      expect(context().values, <String, dynamic>{});
      expect(context().hasChanges, isFalse);
    });

    test('edit mode starts as a copy of initialValue', () {
      final initialValue = {
        'user': {'name': 'Alice'},
      };
      final context = _build(initialValue: initialValue);
      addTearDown(context.dispose);

      expect(context().isEdit, isTrue);
      expect(context().values, initialValue);
    });

    test('onValueChanged sets a nested path and marks hasChanges', () {
      final context = _build(initialValue: {'user': <String, dynamic>{}});
      addTearDown(context.dispose);

      context().onValueChanged('user.name', 'x');

      expect(context().values, {
        'user': {'name': 'x'},
      });
      expect(context().hasChanges, isTrue);
    });

    test('isButtonAvailable requires all required+editable fields and ignores required-but-not-editable ones', () {
      final entries = IList<CmsEntry<dynamic>>([
        CmsTextEntry(key: 'name'),
        CmsTextEntry(key: 'ignored', modifier: const CmsEntryModifier(editable: false)),
      ]);
      final context = _build(entries: entries);
      addTearDown(context.dispose);

      expect(context().isButtonAvailable, isFalse);

      context().onValueChanged('name', 'x');
      expect(context().isButtonAvailable, isTrue);
    });

    test('edit mode requires hasChanges even when required fields are already filled', () {
      final entries = IList<CmsEntry<dynamic>>([CmsTextEntry(key: 'name')]);
      final context = _build(entries: entries, initialValue: {'name': 'Alice'});
      addTearDown(context.dispose);

      expect(context().isButtonAvailable, isFalse);

      context().onValueChanged('name', 'Bob');
      expect(context().isButtonAvailable, isTrue);
    });

    test('onSubmit success calls uploadChanges once with (values, initialValue) and moveBack(true)', () async {
      final calls = <(JsonMap, JsonMap?)>[];
      final moveBackCalls = <bool>[];
      final initialValue = {'name': 'Alice'};
      final context = _build(
        initialValue: initialValue,
        uploadChanges: (newJson, oldJson) async {
          calls.add((newJson, oldJson));
          return {'name': 'Alice', 'id': 1};
        },
        moveBack: moveBackCalls.add,
      );
      addTearDown(context.dispose);

      context().onValueChanged('name', 'Bob');
      await context().onSubmit();
      await context.waitUntil((s) => !s.isUploading);

      expect(calls.length, 1);
      expect(calls.single.$1, {'name': 'Bob'});
      expect(calls.single.$2, initialValue);
      expect(moveBackCalls, [true]);
      expect(context().isUploading, isFalse);
    });

    test('onSaved callbacks all receive the uploadChanges result before moveBack runs', () async {
      final order = <String>[];
      final moveBackCalls = <bool>[];
      final resultMap = {'id': 42};
      final context = _build(
        initialValue: {'name': 'Alice'},
        uploadChanges: (newJson, oldJson) async => resultMap,
        moveBack: (v) {
          order.add('moveBack');
          moveBackCalls.add(v);
        },
      );
      addTearDown(context.dispose);

      JsonMap? received1;
      JsonMap? received2;
      context().addOnSavedCallback((result) async {
        received1 = result;
        order.add('callback1');
      });
      context().addOnSavedCallback((result) async {
        received2 = result;
        order.add('callback2');
      });

      await context().onSubmit();
      await context.waitUntil((s) => !s.isUploading);

      expect(received1, resultMap);
      expect(received2, resultMap);
      expect(order, ['callback1', 'callback2', 'moveBack']);
    });

    test('onSubmit surfaces a CmsDelegateException message and skips moveBack; a later success clears it', () async {
      final moveBackCalls = <bool>[];
      var shouldFail = true;
      final context = _build(
        initialValue: {'name': 'Alice'},
        uploadChanges: (newJson, oldJson) async {
          if (shouldFail) throw const CmsDelegateException('boom');
          return newJson;
        },
        moveBack: moveBackCalls.add,
      );
      addTearDown(context.dispose);

      await context().onSubmit();
      await context.waitUntil((s) => !s.isUploading);

      expect(context().errorMessage, 'boom');
      expect(moveBackCalls, isEmpty);
      expect(context().isUploading, isFalse);

      shouldFail = false;
      await context().onSubmit();
      await context.waitUntil((s) => !s.isUploading);

      expect(context().errorMessage, isNull);
      expect(moveBackCalls, [true]);
    });

    test('onDelete calls deleteItem then moveBack(true)', () async {
      final order = <String>[];
      final moveBackCalls = <bool>[];
      final context = _build(
        initialValue: {'name': 'Alice'},
        deleteItem: () async {
          order.add('delete');
        },
        moveBack: (v) {
          order.add('moveBack');
          moveBackCalls.add(v);
        },
      );
      addTearDown(context.dispose);

      await context().onDelete();
      await context.waitUntil((s) => !s.isDeleting);

      expect(moveBackCalls, [true]);
      expect(order, ['delete', 'moveBack']);
    });

    // Spec discrepancy check: useCmsItemManagementState.onDelete does not guard on
    // args.deleteItem being non-null - `args.deleteItem?.call()` simply no-ops when
    // null, and moveBack(true) still runs. This matches the spec's own prediction,
    // so it is confirmed actual behavior, not a bug.
    test('onDelete with no deleteItem set still calls moveBack(true)', () async {
      final moveBackCalls = <bool>[];
      final context = _build(initialValue: {'name': 'Alice'}, moveBack: moveBackCalls.add);
      addTearDown(context.dispose);

      await context().onDelete();
      await context.waitUntil((s) => !s.isDeleting);

      expect(moveBackCalls, [true]);
    });

    test('canDelete is true only for edit mode with params.canDelete', () {
      final createContext = _build();
      addTearDown(createContext.dispose);
      expect(createContext().canDelete, isFalse);

      final editDeletable = _build(initialValue: {'name': 'x'});
      addTearDown(editDeletable.dispose);
      expect(editDeletable().canDelete, isTrue);

      final editNotDeletable = _build(initialValue: {'name': 'x'}, params: const CmsTableParams(canDelete: false));
      addTearDown(editNotDeletable.dispose);
      expect(editNotDeletable().canDelete, isFalse);
    });

    test('canCreate is true in create mode and mirrors params.canEdit in edit mode', () {
      final createContext = _build(params: const CmsTableParams(canEdit: false));
      addTearDown(createContext.dispose);
      expect(createContext().canCreate, isTrue);

      final editCanEdit = _build(initialValue: {'name': 'x'});
      addTearDown(editCanEdit.dispose);
      expect(editCanEdit().canCreate, isTrue);

      final editCannotEdit = _build(initialValue: {'name': 'x'}, params: const CmsTableParams(canEdit: false));
      addTearDown(editCannotEdit.dispose);
      expect(editCannotEdit().canCreate, isFalse);
    });
  });
}
