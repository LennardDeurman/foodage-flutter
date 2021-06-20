import 'package:fdg_web_admin/src/models/store.dart';
import 'package:fdg_common/fdg_common.dart';

class StorePickerCubit extends ResourceListCubit<Store> {
  @override
  Future<List<Store>> getInitialData() {
    return Future.value(
      [
        Store(name: 'Albert Heijn'),
        Store(name: 'Jumbo'),
        Store(name: 'C1000'),
        Store(name: 'Dirk'),
      ],
    ); //TODO: Replace this with API call
  }
}
