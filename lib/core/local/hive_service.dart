import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/auth/domain/entity/user.dart';
import '../../features/acl/domain/entity/employee_dto.dart';

class HiveService {
  static const String userBoxName = 'userBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(EmployeeDtoAdapter());
    Hive.registerAdapter(AccountDtoAdapter());
    Hive.registerAdapter(RoleDtoAdapter());
    Hive.registerAdapter(AccessDtoAdapter());
    Hive.registerAdapter(AssignmentDtoAdapter());
    Hive.registerAdapter(OrganizationDtoAdapter());
    Hive.registerAdapter(LocationDtoAdapter());
    Hive.registerAdapter(OrganizationConfigDtoAdapter());
    Hive.registerAdapter(WorkingScheduleDtoAdapter());
    Hive.registerAdapter(LocationDetailDtoAdapter());
    Hive.registerAdapter(JobDtoAdapter());
    Hive.registerAdapter(CompanyDtoAdapter());
    Hive.registerAdapter(JobGroupDtoAdapter());
    await Hive.openBox<User>(userBoxName);
  }

  static Future<void> saveUser(User user) async {
    final box = Hive.box<User>(userBoxName);
    await box.put('user', user);
  }

  static User? getUser() {
    final box = Hive.box<User>(userBoxName);
    return box.get('user');
  }

  static Future<void> deleteUser() async {
    final box = Hive.box<User>(userBoxName);
    await box.delete('user');
  }
}
