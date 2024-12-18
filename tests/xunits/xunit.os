#Использовать asserts
#Использовать tempfiles
#Использовать "utils"
#Использовать "../.."

#Область ОписаниеПеременных

Перем НакопленныеВременныеФайлы; // фиксация накопленных времнных файлов для сброса

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

&Тест
Процедура ТестДолжен_ВыполнитьУспешноеТестированиеПроектаIbsrv() Экспорт

	// Дано
	ИмяРасширения = "ТестOK";

	Исполнитель = Новый Тест_ИсполнительКоманд("xunit");

	КаталогSrcCf = Исполнитель.ПутьТестовыхДанных("cf");
	Исполнитель.УстановитьКонтекстИБИзФайловКонфигурации(КаталогSrcCf);
	Исполнитель.ОбновитьКонфигурациюБазыДанных();

	КаталогSrc = Исполнитель.ПутьТестовыхДанных("xdd_cfe_OK");
	Исполнитель.СоздатьРасширениеИзФайлов(ИмяРасширения, КаталогSrc);
	Исполнитель.ОбновитьКонфигурациюБазыДанных(ИмяРасширения);

	Исполнитель.ДобавитьПараметр(ИмяРасширения);
	Исполнитель.ДобавитьФлаг("--config-tests");
	Исполнитель.ДобавитьПараметр("--xddExitCodePath", "./exitCode.txt");
	Исполнитель.ДобавитьФлаг("--ibsrv");
	
	// Когда
	Исполнитель.ВыполнитьКоманду();

	// Тогда
	Исполнитель.ОжидаемЧтоВыводСодержит("Используется ibsrv");
	Исполнитель.ОжидаемЧтоВыводСодержит("Все тесты выполнены!");
	
КонецПроцедуры

&Тест
Процедура ТестДолжен_ВыполнитьОшибочноеТестированиеПроектаIbsrv() Экспорт

	// Дано
	ИмяРасширения = "ТестFAIL";

	Исполнитель = Новый Тест_ИсполнительКоманд("xunit");
	
	КаталогSrcCf = Исполнитель.ПутьТестовыхДанных("cf");
	Исполнитель.УстановитьКонтекстИБИзФайловКонфигурации(КаталогSrcCf);
	Исполнитель.ОбновитьКонфигурациюБазыДанных();

	КаталогSrc = Исполнитель.ПутьТестовыхДанных("xdd_cfe_FAIL");
	Исполнитель.СоздатьРасширениеИзФайлов(ИмяРасширения, КаталогSrc);
	Исполнитель.ОбновитьКонфигурациюБазыДанных(ИмяРасширения);
	
	// Когда
	Исполнитель.ДобавитьПараметр(ИмяРасширения);
	Исполнитель.ДобавитьФлаг("--config-tests");
	Исполнитель.ДобавитьПараметр("--xddExitCodePath", "./exitCode.txt");
	Исполнитель.ДобавитьФлаг("--ibsrv");

	// Тогда
	Ожидаем.Что(Исполнитель)
		.Метод("ВыполнитьКоманду")
		.ВыбрасываетИсключение("Часть тестов упала!");
	Исполнитель.ОжидаемЧтоВыводСодержит("Используется ibsrv");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПередЗапускомТеста() Экспорт
	
	НакопленныеВременныеФайлы = ВременныеФайлы.Файлы();
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
	ВременныеФайлы.УдалитьНакопленныеВременныеФайлы(НакопленныеВременныеФайлы);
	
КонецПроцедуры

#КонецОбласти
