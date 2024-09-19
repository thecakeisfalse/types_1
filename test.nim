import sets, strutils, unittest
import main


proc checkFields(fld, keys: seq[string]): bool =
    var buf = fld.toHashSet
    buf.incl("")
    buf - keys.toHashSet == @[""].toHashSet


proc getKeys(x: auto): seq[string] =
    for key, value in x.fieldPairs():
        result.add(key.toLower)


suite "Проверка первого задания":
  let item = Shelter()
  test "Проверка полей Приюта":
    check checkFields(@["staff", "pet", "manager"], getKeys(item))
    check item.staff == Staff()
    check item.pet == Pet()
    check item.manager == Manager()
  test "Проверка полей Сотрудник":
    check checkFields(@["name", "birthdate", "uid"], getKeys(Staff()))
    check (item.staff.name, item.staff.birthDate, item.staff.uid) == ("", "", 0)
  test "Проверка полей Питомец":
    check checkFields(@["name", "age"], getKeys(Pet()))
    check (item.pet.name, item.pet.age) == ("", 0)
  test "Проверка полей Руководство":
    check checkFields(@["name", "post"], getKeys(Manager()))
    check (item.manager.name, item.manager.post) == ("", "")


suite "Проверка второго задания":
  let item = School()
  test "Проверка полей Школы":
    check checkFields(@["director", "teacher", "student"], getKeys(item))
    check item.director == Director()
    check item.teacher == Teacher()
    check item.student == Student()
  test "Проверка полей Директор":
    check checkFields(@["name"], getKeys(Director()))
    check item.director.name == ""
  test "Проверка полей Учитель":
    check checkFields(@["name", "class"], getKeys(Teacher()))
    check (item.teacher.name, item.teacher.class) == ("", "")
  test "Проверка полей Ученик":
    check checkFields(@["name", "class"], getKeys(Student()))
    check (item.student.name, item.student.class) == ("", "")


suite "Проверка третьего задания":
  let item = Shop()
  test "Проверка полей Магазина":
    check checkFields(@["manager", "staff", "good", "cash"], getKeys(item))
    check item.manager == ShopManager()
    check item.staff == ShopStaff()
    check item.good == Good()
    check item.cash == Cash()
  test "Проверка полей Менеджер":
    check checkFields(@["name"], getKeys(ShopManager()))
    check item.manager.name == ""
  test "Проверка полей Сотрудник":
    check checkFields(@["name", "birthdate", "post"], getKeys(ShopStaff()))
    check (item.staff.name, item.staff.birthDate, item.staff.post) == ("", "", "")
  test "Проверка полей Товар":
    check checkFields(@["title", "enddate"], getKeys(Good()))
    check (item.good.title, item.good.endDate) == ("", "")
  test "Проверка полей Касса":
    check checkFields(@["number"], getKeys(Cash()))
    check item.cash.number == 0
