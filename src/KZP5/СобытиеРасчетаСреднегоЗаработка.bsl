
Функция _ТолькоКомпенсация(Объект)
	Возврат Объект.ПредоставитьКомпенсациюОсновногоОтпуска И Не Объект.ПредоставитьОсновнойОтпуск И Не Объект.ПредоставитьДополнительныйОтпуск
		Или (Не Объект.ПредоставитьОсновнойОтпуск И Объект.ПредоставитьДополнительныйОтпуск 
		И Объект.ДополнительныеОтпуска.Итог("КоличествоДней") = 0 И Объект.ДополнительныеОтпуска.Итог("КоличествоДнейКомпенсации") > 0);
КонецФункции

Процедура Saby_ЗаписьДокументаСоСреднимЗаработкомПередЗаписью(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	// Если НЕ Источник.ДополнительныеСвойства.Свойство("ЗаписьОбновлениеДокумента") Тогда
	//	//Код только для загружаемых расширением документов
	//	Возврат;
	//КонецЕсли;
	//Если Источник.ОбменДанными.Загрузка Тогда
	//	Возврат;
	//КонецЕсли;
	// Если НЕ ОбщегоНазначения.ЕстьРеквизитОбъекта("СреднийЗаработок",  Источник.Метаданные()) Тогда
	//	Возврат;
	//КонецЕсли;
	// Если Источник.СреднийЗаработок <> 0 Тогда
	//	Возврат;
	//КонецЕсли;
	//
	//Попытка
	//	ВидРасчета = ?(_ТолькоКомпенсация(Источник), Источник.ВидРасчетаКомпенсацииОсновногоОтпуска, Источник.ВидРасчетаОсновногоОтпуска);
	//	ПериодРасчетаСреднего = УчетСреднегоЗаработка.ПериодРасчетаОбщегоСреднегоЗаработкаСотрудника(Источник.ДатаНачалаСобытия, Источник.Сотрудник, ВидРасчета);
	//	Источник.ПериодРасчетаСреднегоЗаработкаНачало		= ПериодРасчетаСреднего.ДатаНачала;
	//	Источник.ПериодРасчетаСреднегоЗаработкаОкончание 	= ПериодРасчетаСреднего.ДатаОкончания;

	//	ДополнительныеПараметры = УчетСреднегоЗаработкаКлиентСервер.ДополнительныеПараметрыРасчетаСреднегоЗаработка();
	//	СотрудникиДляРасчета = Новый Массив;
	//	СотрудникиДляРасчета.Добавить(Источник.Сотрудник);
	//	СпособыРасчетаОтпусковСотрудников = ОстаткиОтпусков.СпособыРасчетаОтпусковСотрудников(СотрудникиДляРасчета, КонецМесяца(Источник.ДатаНачалаСобытия));
	//	ДополнительныеПараметры.СпособРасчетаОтпуска = СпособыРасчетаОтпусковСотрудников[Источник.Сотрудник];
	//	Источник.СреднийЗаработок = УчетСреднегоЗаработка.СреднийЗаработок(Источник.Сотрудник, Источник.ДатаНачалаСобытия, ДополнительныеПараметры);
	//Исключение
	//	ИнфоОбОшибке	= ИнформацияОбОшибке();
	//	СтруктураОшибки	= Saby_Core.ExtExceptionAnalyse(ИнфоОбОшибке);
	//	Saby_Core.ExtExceptionToJournal(СтруктураОшибки);
	//КонецПопытки;
КонецПроцедуры

