
Функция ПодготовитьДанныеПрочийКадровыйРасчетныйЛисток(ПараметрыЗапроса) Экспорт

	ПараметрыВызова = Новый Массив;	

	ФизическиеЛица = Новый СписокЗначений;
	Организации = Новый СписокЗначений;
	ОрганизацииЗаполнены = Ложь;
	ФизическиеЛицаЗаполнены = Ложь;
	Если ТипЗнч(ПараметрыЗапроса.ФизическиеЛица) = Тип("СправочникСсылка.ФизическиеЛица") Тогда
		Если НЕ ПараметрыЗапроса.ФизическиеЛица = Справочники.ФизическиеЛица.ПустаяСсылка() Тогда
    		ФизическиеЛица.Добавить(ПараметрыЗапроса.ФизическиеЛица);
			ФизическиеЛицаЗаполнены = Истина;	
		КонецЕсли;
	ИначеЕсли ТипЗнч(ПараметрыЗапроса.ФизическиеЛица) = Тип("СписокЗначений") Тогда 
		ФизическиеЛица = ПараметрыЗапроса.ФизическиеЛица;
		ФизическиеЛицаЗаполнены = ПараметрыЗапроса.ФизическиеЛица.Количество() > 0;
	КонецЕсли;
	
	Если ТипЗнч(ПараметрыЗапроса.Организация) = Тип("СправочникСсылка.Организации") Тогда
		Если НЕ ПараметрыЗапроса.Организация = Справочники.Организации.ПустаяСсылка() Тогда
    		Организации.Добавить(ПараметрыЗапроса.Организация);
			ОрганизацииЗаполнены = Истина;
		КонецЕсли;
	ИначеЕсли ТипЗнч(ПараметрыЗапроса.Организация) = Тип("СписокЗначений") Тогда
		Организации = ПараметрыЗапроса.Организация;
		ОрганизацииЗаполнены = ПараметрыЗапроса.Организация.Количество > 0;;
	КонецЕсли;
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	Сотрудники.ГоловнаяОрганизация КАК ГоловнаяОрганизация,
		|	Сотрудники.ФизическоеЛицо КАК ФизическоеЛицо
		|	ИЗ
		|	Справочник.Сотрудники КАК Сотрудники
		|	ГДЕ
		|	ВЫБОР
		|	КОГДА &ФизическиеЛицаЗаполнены = Ложь
		|	ТОГДА ИСТИНА
		|	ИНАЧЕ Сотрудники.ФизическоеЛицо В (&ФизическиеЛица)
		|	КОНЕЦ
		|	И ВЫБОР
		|	КОГДА &ОрганизацииЗаполнены = Ложь
		|	ТОГДА ИСТИНА
		|	ИНАЧЕ Сотрудники.ГоловнаяОрганизация В (&Организации)
		|	КОНЕЦ
		|	И Сотрудники.ПометкаУдаления = ЛОЖЬ";
	
	Запрос.УстановитьПараметр("ФизическиеЛица", ФизическиеЛица);
	Запрос.УстановитьПараметр("Организации", Организации);
	Запрос.УстановитьПараметр("ФизическиеЛицаЗаполнены", ФизическиеЛицаЗаполнены);
	Запрос.УстановитьПараметр("ОрганизацииЗаполнены", ОрганизацииЗаполнены);

	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();  
	
	Попытка
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			
			УстановитьПривилегированныйРежим(Истина);
            ОтчетРасчетныйЛисток = ЗарплатаКадрыОтчеты.ОтчетРасчетныйЛисток();
			Попытка
				Результат = Отчеты.АнализНачисленийИУдержаний.ДанныеРасчетныхЛистков(   
							ВыборкаДетальныеЗаписи.ФизическоеЛицо,
				            ВыборкаДетальныеЗаписи.ГоловнаяОрганизация,
							ПараметрыЗапроса.НачалоПериода,
							ПараметрыЗапроса.КонецПериода,
							ОтчетРасчетныйЛисток);
			Исключение
				//Начиная с Версии ЗУП 3.1.24.408			
				Результат = ЗарплатаКадрыОтчеты.ДанныеРасчетныхЛистков(
							ВыборкаДетальныеЗаписи.ФизическоеЛицо, 
							ВыборкаДетальныеЗаписи.ГоловнаяОрганизация,
							ПараметрыЗапроса.НачалоПериода,
							ПараметрыЗапроса.КонецПериода,
							ОтчетРасчетныйЛисток);
			КонецПопытки; 
						
			УстановитьПривилегированныйРежим(Ложь);
			
			ДокументРезультат = Результат.ДокументРезультат;
			
			НазваниеПФ = "Расчетный листок от " + Формат(ПараметрыЗапроса.НачалоПериода, "ДЛФ=Д") + " по " + Формат(ПараметрыЗапроса.КонецПериода, "ДЛФ=Д") + " для " + Строка(ВыборкаДетальныеЗаписи.ФизическоеЛицо);
			Вложение = Новый Соответствие;
			Вложение["Название"] = НазваниеПФ; 
			
			ПотокВПамяти = Новый ПотокВПамяти;
			ДокументРезультат.Записать(ПотокВПамяти, ТипФайлаТабличногоДокумента.PDF);
			ФайлBase64 = Base64Строка(ПотокВПамяти.ЗакрытьИПолучитьДвоичныеДанные());
						
			Вложение["Файл"] = Новый Соответствие;
			Вложение["Файл"].Вставить("Имя", НазваниеПФ+".pdf");
			Вложение["Файл"].Вставить("ДвоичныеДанные", ФайлBase64);
			Вложение["Файл"].Вставить("ContentType", "application/pdf");;			
	        МассивВложений = Новый Массив;
			МассивВложений.Добавить(Вложение);
			
			ПараметрыПКД = Новый Структура("Регламент, ЕстьФильтрПоОрганизации, ЕстьФильтрПоСотрудникам, НачалоПериода, КонецПериода, Организация, ФизическоеЛицо, _print_forms",
			saby_core.get_prop(ПараметрыЗапроса,"Регламент"),
			ПараметрыЗапроса.ЕстьФильтрПоОрганизации,
			ПараметрыЗапроса.ЕстьФильтрПоСотрудникам,
			ПараметрыЗапроса.НачалоПериода,
			ПараметрыЗапроса.КонецПериода,
			ВыборкаДетальныеЗаписи.ГоловнаяОрганизация,
			ВыборкаДетальныеЗаписи.ФизическоеЛицо,
			МассивВложений);
			
			ПараметрыВызова.Добавить(ПараметрыПКД); 

		КонецЦикла;	
 	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
	КонецПопытки;	
	
	Возврат ПараметрыВызова;
КонецФункции

