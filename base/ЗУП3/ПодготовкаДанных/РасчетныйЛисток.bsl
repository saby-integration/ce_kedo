Функция ПодготовитьДанныеПрочийКадровыйРасчетныйЛисток(ПараметрыЗапроса) Экспорт

	ПараметрыВызова = Новый Массив;	

	ФизическиеЛица 			= Новый СписокЗначений;
	Организации 			= Новый СписокЗначений;
	Подразделения 			= Новый СписокЗначений;
	ОрганизацииЗаполнены 	= Ложь;
	ФизическиеЛицаЗаполнены = Ложь; 
	ПодразделенияЗаполнены 	= Ложь;
	ПодразделенияВСписке 	= Истина;
	ОрганизацииВСписке		= Истина;
	ФизическиеЛицаВСписке = Истина;

	Если ПараметрыЗапроса.ЕстьФильтрПоФизическимЛицам Тогда
		Если ТипЗнч(ПараметрыЗапроса.ФизическиеЛица) = Тип("СправочникСсылка.ФизическиеЛица") Тогда
			Если НЕ ПараметрыЗапроса.ФизическиеЛица = Справочники.ФизическиеЛица.ПустаяСсылка() Тогда
				ФизическиеЛица.Добавить(ПараметрыЗапроса.ФизическиеЛица);
				ФизическиеЛицаЗаполнены = Истина;	
			КонецЕсли;
		ИначеЕсли ТипЗнч(ПараметрыЗапроса.ФизическиеЛица) = Тип("СписокЗначений") Тогда 
			ФизическиеЛица = ПараметрыЗапроса.ФизическиеЛица;
			ФизическиеЛицаЗаполнены = ПараметрыЗапроса.ФизическиеЛица.Количество() > 0;
		КонецЕсли;
		Если ПараметрыЗапроса.ВидСравненияФизическиеЛица = ВидСравненияКомпоновкиДанных.НеРавно
			ИЛИ ПараметрыЗапроса.ВидСравненияФизическиеЛица = ВидСравненияКомпоновкиДанных.НеВИерархии
			ИЛИ ПараметрыЗапроса.ВидСравненияФизическиеЛица = ВидСравненияКомпоновкиДанных.НеВСписке
			ИЛИ ПараметрыЗапроса.ВидСравненияФизическиеЛица = ВидСравненияКомпоновкиДанных.НеВСпискеПоИерархии
			ИЛИ ПараметрыЗапроса.ВидСравненияФизическиеЛица = ВидСравненияКомпоновкиДанных.НеЗаполнено Тогда
			ФизическиеЛицаВСписке = Ложь
		Иначе
			ФизическиеЛицаВСписке = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Если ПараметрыЗапроса.ЕстьФильтрПоОрганизации Тогда
		Если ТипЗнч(ПараметрыЗапроса.Организация) = Тип("СправочникСсылка.Организации") Тогда
			Если НЕ ПараметрыЗапроса.Организация = Справочники.Организации.ПустаяСсылка() Тогда
	    		Организации.Добавить(ПараметрыЗапроса.Организация);
				ОрганизацииЗаполнены = Истина;
			КонецЕсли;
		ИначеЕсли ТипЗнч(ПараметрыЗапроса.Организация) = Тип("СписокЗначений") Тогда
			Организации = ПараметрыЗапроса.Организация;
			ОрганизацииЗаполнены = ПараметрыЗапроса.Организация.Количество() > 0;;
		КонецЕсли;
		Если ПараметрыЗапроса.ВидСравненияОрганизация = ВидСравненияКомпоновкиДанных.НеРавно
			ИЛИ ПараметрыЗапроса.ВидСравненияОрганизация = ВидСравненияКомпоновкиДанных.НеВИерархии
			ИЛИ ПараметрыЗапроса.ВидСравненияОрганизация = ВидСравненияКомпоновкиДанных.НеВСписке
			ИЛИ ПараметрыЗапроса.ВидСравненияОрганизация = ВидСравненияКомпоновкиДанных.НеВСпискеПоИерархии
			ИЛИ ПараметрыЗапроса.ВидСравненияОрганизация = ВидСравненияКомпоновкиДанных.НеЗаполнено Тогда
			ОрганизацииВСписке = Ложь
		Иначе
			ОрганизацииВСписке = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Если ПараметрыЗапроса.ЕстьФильтрПоПодразделениям Тогда
		Если ТипЗнч(ПараметрыЗапроса.Подразделения) = Тип("СправочникСсылка.ПодразделенияОрганизаций") Тогда
			Если НЕ ПараметрыЗапроса.Подразделения = Справочники.ПодразделенияОрганизаций.ПустаяСсылка() Тогда
	    		Подразделения.Добавить(ПараметрыЗапроса.Подразделения);
				ПодразделенияЗаполнены = Истина;
			КонецЕсли;
		ИначеЕсли ТипЗнч(ПараметрыЗапроса.Подразделения) = Тип("СписокЗначений") Тогда
			Подразделения = ПараметрыЗапроса.Подразделения;
			ПодразделенияЗаполнены = ПараметрыЗапроса.Подразделения.Количество() > 0;;
		КонецЕсли;
		Если ПараметрыЗапроса.ВидСравненияПодразделения = ВидСравненияКомпоновкиДанных.НеРавно
			ИЛИ ПараметрыЗапроса.ВидСравненияПодразделения = ВидСравненияКомпоновкиДанных.НеВИерархии
			ИЛИ ПараметрыЗапроса.ВидСравненияПодразделения = ВидСравненияКомпоновкиДанных.НеВСписке
			ИЛИ ПараметрыЗапроса.ВидСравненияПодразделения = ВидСравненияКомпоновкиДанных.НеВСпискеПоИерархии
			ИЛИ ПараметрыЗапроса.ВидСравненияПодразделения = ВидСравненияКомпоновкиДанных.НеЗаполнено Тогда
			ПодразделенияВСписке = Ложь
		Иначе
			ПодразделенияВСписке = Истина;
		КонецЕсли;
	КонецЕсли;
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	КадроваяИсторияСотрудниковИнтервальный.ФизическоеЛицо КАК ФизическоеЛицо,
		|	КадроваяИсторияСотрудниковИнтервальный.Организация КАК Организация,
		|	КадроваяИсторияСотрудниковИнтервальный.Подразделение КАК Подразделение,
		|	КадроваяИсторияСотрудниковИнтервальный.Сотрудник КАК Сотрудник,
		|	КадроваяИсторияСотрудниковИнтервальный.ГоловнаяОрганизация КАК ГоловнаяОрганизация
		|ИЗ
		|	РегистрСведений.КадроваяИсторияСотрудниковИнтервальный КАК КадроваяИсторияСотрудниковИнтервальный
		|ГДЕ
		|	КадроваяИсторияСотрудниковИнтервальный.ДатаОкончания >= &НачалоПериода
		|	И КадроваяИсторияСотрудниковИнтервальный.ДатаНачала <= &КонецПериода
		|	И ВЫБОР
		|			КОГДА &ФизическиеЛицаЗаполнены = ЛОЖЬ
		|				ТОГДА ИСТИНА
		|			ИНАЧЕ ВЫБОР
		|					КОГДА &ФизическиеЛицаВСписке = ИСТИНА
		|						ТОГДА КадроваяИсторияСотрудниковИнтервальный.ФизическоеЛицо В (&ФизическиеЛица)
		|					ИНАЧЕ НЕ КадроваяИсторияСотрудниковИнтервальный.ФизическоеЛицо В (&ФизическиеЛица)
		|				КОНЕЦ
		|		КОНЕЦ
		|	И ВЫБОР
		|			КОГДА &ОрганизацииЗаполнены = ЛОЖЬ
		|				ТОГДА ИСТИНА
		|			ИНАЧЕ ВЫБОР
		|					КОГДА &ОрганизацииВСписке = ИСТИНА
		|						ТОГДА КадроваяИсторияСотрудниковИнтервальный.Организация В (&Организации)
		|					ИНАЧЕ НЕ КадроваяИсторияСотрудниковИнтервальный.Организация В (&Организации)
		|				КОНЕЦ
		|		КОНЕЦ
		|	И ВЫБОР
		|			КОГДА &ПодразделенияЗаполнены = ЛОЖЬ
		|				ТОГДА ИСТИНА
		|			ИНАЧЕ ВЫБОР
		|					КОГДА &ПодразделенияВСписке = ИСТИНА
		|						ТОГДА КадроваяИсторияСотрудниковИнтервальный.Подразделение В (&Подразделения)
		|					ИНАЧЕ НЕ КадроваяИсторияСотрудниковИнтервальный.Подразделение В (&Подразделения)
		|				КОНЕЦ
		|		КОНЕЦ
		|	И НЕ КадроваяИсторияСотрудниковИнтервальный.Сотрудник.ПометкаУдаления
		|
		|УПОРЯДОЧИТЬ ПО
		|	КадроваяИсторияСотрудниковИнтервальный.ДатаОкончания УБЫВ
		|ИТОГИ
		|	МАКСИМУМ(ГоловнаяОрганизация)
		|ПО
		|	ФизическоеЛицо";
	
	Запрос.УстановитьПараметр("ФизическиеЛица", ФизическиеЛица);
	Запрос.УстановитьПараметр("ОрганизацииЗаполнены", ОрганизацииЗаполнены);
	Запрос.УстановитьПараметр("ФизическиеЛицаЗаполнены", ФизическиеЛицаЗаполнены); 
	Запрос.УстановитьПараметр("Организации", Организации);
	Запрос.УстановитьПараметр("Подразделения", Подразделения);
	Запрос.УстановитьПараметр("ПодразделенияЗаполнены", ПодразделенияЗаполнены);
	Запрос.УстановитьПараметр("ОрганизацииВСписке", ОрганизацииВСписке);
	Запрос.УстановитьПараметр("ПодразделенияВСписке", ПодразделенияВСписке);
	Запрос.УстановитьПараметр("ФизическиеЛицаВСписке", ФизическиеЛицаВСписке);
	Запрос.УстановитьПараметр("НачалоПериода", ПараметрыЗапроса.НачалоПериода);
	Запрос.УстановитьПараметр("КонецПериода", ПараметрыЗапроса.КонецПериода);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Попытка
		
		Пока Выборка.Следующий() Цикл
			УстановитьПривилегированныйРежим(Истина);
			КлючВарианта = ПараметрыЗапроса.КлючВарианта;
			Если КлючВарианта = "РасчетныйЛисток" Тогда
				ОтчетРасчетныйЛисток = ЗарплатаКадрыОтчеты.ОтчетРасчетныйЛисток();
				Попытка
					Результат = Отчеты.АнализНачисленийИУдержаний.ДанныеРасчетныхЛистков(   
								Выборка.ФизическоеЛицо,
								Выборка.ГоловнаяОрганизация,
								ПараметрыЗапроса.НачалоПериода,
								ПараметрыЗапроса.КонецПериода,
								ОтчетРасчетныйЛисток);
				Исключение
					//Начиная с Версии ЗУП 3.1.24.408			
					Результат = ЗарплатаКадрыОтчеты.ДанныеРасчетныхЛистков(
								Выборка.ФизическоеЛицо, 
								Выборка.ГоловнаяОрганизация,
								ПараметрыЗапроса.НачалоПериода,
								ПараметрыЗапроса.КонецПериода,
								ОтчетРасчетныйЛисток);
				КонецПопытки;
				ДокументРезультат = Результат.ДокументРезультат;
			Иначе
				
				ОтчетОбъектРЛ = Отчеты.АнализНачисленийИУдержаний.Создать();
				ОтчетОбъектРЛ.ИнициализироватьОтчет(КлючВарианта);           
				ВариантОтчета = ВариантыОтчетов.ВариантОтчета(ОбщегоНазначения.ИдентификаторОбъектаМетаданных(ОтчетОбъектРЛ.Метаданные()), КлючВарианта);
				СхемаКомпоновкиДанных = Отчеты.АнализНачисленийИУдержаний.ПолучитьМакет("ОсновнаяСхемаКомпоновкиДанных");
				КомпоновщикНастроекКомпоновкиДанных = Новый КомпоновщикНастроекКомпоновкиДанных;
				КомпоновщикНастроекКомпоновкиДанных.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(СхемаКомпоновкиДанных));
				КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(СхемаКомпоновкиДанных.НастройкиПоУмолчанию);
				КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьПользовательскиеНастройки(ОтчетОбъектРЛ.КомпоновщикНастроек.ПользовательскиеНастройки);
				КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(ВариантОтчета.Настройки.Получить());
				ОтчетОбъектРЛ.КомпоновщикНастроек.ЗагрузитьНастройки(ВариантОтчета.Настройки.Получить());
				
				ЭлементОтбораФЛ = ОтчетОбъектРЛ.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Найти(ПараметрыЗапроса.ИдентификаторФизическоеЛицо);
				ЭлементОтбораФЛ.ПравоеЗначение	= Выборка.ФизическоеЛицо;
				ЭлементОтбораФЛ.ВидСравнения	= ВидСравненияКомпоновкиДанных.Равно;
				ЭлементОтбораФЛ.Использование	= Истина;	
				
				ЭлементОтбораПериод = ОтчетОбъектРЛ.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Найти(ПараметрыЗапроса.ИдентификаторПериод);
				Если ТипЗнч(ЭлементОтбораПериод.Значение) = Тип("СтандартныйПериод") Тогда
					ЭлементОтбораПериод.Значение.ДатаНачала 	= ПараметрыЗапроса.НачалоПериода;
					ЭлементОтбораПериод.Значение.ДатаОкончания 	= ПараметрыЗапроса.КонецПериода;
				ИначеЕсли ТипЗнч(ЭлементОтбораПериод.Значение) = Тип("СтандартнаяДатаНачала") Тогда
					ЭлементОтбораПериод.Значение.Дата = ПараметрыЗапроса.НачалоПериода;
				КонецЕсли;
				
				Если ПараметрыЗапроса.Свойство("ИдентификаторОрганизация") Тогда
					ЭлементОтбораОрганизация = ОтчетОбъектРЛ.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Найти(ПараметрыЗапроса.ИдентификаторОрганизация);
					Если ОрганизацииВСписке Тогда
						ЭлементОтбораОрганизация.ВидСравнения	= ВидСравненияКомпоновкиДанных.ВСписке;
					Иначе
						ЭлементОтбораОрганизация.ВидСравнения	= ВидСравненияКомпоновкиДанных.НеВСписке;
					КонецЕсли;
					ЭлементОтбораОрганизация.ПравоеЗначение	= Организации;
					ЭлементОтбораОрганизация.Использование	= ОрганизацииЗаполнены;	
				КонецЕсли;
				
				Если ПараметрыЗапроса.Свойство("ИдентификаторПодразделение") Тогда
					ЭлементОтбораПодразделение = ОтчетОбъектРЛ.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы.Найти(ПараметрыЗапроса.ИдентификаторПодразделение);
					Если ПодразделенияВСписке Тогда
						ЭлементОтбораПодразделение.ВидСравнения	= ВидСравненияКомпоновкиДанных.ВСписке;
					Иначе
						ЭлементОтбораПодразделение.ВидСравнения	= ВидСравненияКомпоновкиДанных.НеВСписке;
					КонецЕсли;
					ЭлементОтбораПодразделение.ПравоеЗначение	= Подразделения;
					ЭлементОтбораПодразделение.Использование = ПодразделенияЗаполнены;
				КонецЕсли;
				
				КомпоновщикМакетаКомпоновкиДанных = Новый КомпоновщикМакетаКомпоновкиДанных;
				МакетКомпоновкиДанных = КомпоновщикМакетаКомпоновкиДанных.Выполнить(СхемаКомпоновкиДанных, КомпоновщикНастроекКомпоновкиДанных.ПолучитьНастройки(),,,);

				ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
				ВнешниеНаборыДанных = ЗарплатаКадрыОтчеты.НаборыВнешнихДанныхАнализНачисленийИУдержаний();
				ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновкиДанных,ВнешниеНаборыДанных);

				Результат = Новый ТабличныйДокумент;

				ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
				ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент.УстановитьДокумент(Результат);
				//ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент.Вывести(ПроцессорКомпоновкиДанных);
				ОтчетОбъектРЛ.СкомпоноватьРезультат(Результат); 
				Результат.АвтоМасштаб = Истина;
			
				УстановитьПривилегированныйРежим(Ложь);
				
				ДокументРезультат = Результат;
			КонецЕсли;
			
			Если ДокументРезультат.ВысотаТаблицы > 0 Тогда
				НазваниеПФ = "Расчетный листок от " + Формат(ПараметрыЗапроса.НачалоПериода, "ДЛФ=Д") + " по " + Формат(ПараметрыЗапроса.КонецПериода, "ДЛФ=Д") + " для " + Строка(Выборка.ФизическоеЛицо);
				Вложение = Новый Соответствие;  
				Вложение["Название"] = НазваниеПФ; 
				
				ПотокВПамяти = Новый ПотокВПамяти;
				ДокументРезультат.Записать(ПотокВПамяти, ТипФайлаТабличногоДокумента.PDF);
				ФайлBase64 = Base64Строка(ПотокВПамяти.ЗакрытьИПолучитьДвоичныеДанные());
							
				//отправка на СБИС Диск
				ИмяФайла = НазваниеПФ + ".pdf";
				context_params = Saby_Core.ПроверитьНаличиеПараметровПодключения(); 
				ОбъектОбработки = Обработки.SABY.Создать();
				СсылкаНаPDF = Неопределено;
				СсылкаНаPDF = ОбъектОбработки.local_helper_convert_to_pdfa_to_disk_x(context_params, ФайлBase64, ИмяФайла);
				//ТипКонтента = ПолучитьКонтентТипВложения(ИмяФайла);
				СсылкаНаСБИСДиск = Saby_Core.get_prop(СсылкаНаPDF, "FileId");
				//отправка на СБИС Диск

				//Прикреплённый файл
				ВыборкаДетальныеЗаписи = Выборка.Выбрать();
				ВыборкаДетальныеЗаписи.Следующий();
				Вложение["Файл"] = Новый Соответствие;
				Вложение["Файл"].Вставить("Имя", НазваниеПФ+".pdf");
				Вложение["Файл"].Вставить("Ссылка", СсылкаНаСБИСДиск);
				Вложение["Файл"].Вставить("ContentType", "application/pdf");
				МассивВложений = Новый Массив;
				МассивВложений.Добавить(Вложение);
				
				ПараметрыПКД = Новый Структура();
				ПараметрыПКД.Вставить("Регламент", saby_core.get_prop(ПараметрыЗапроса,"Регламент"));
				ПараметрыПКД.Вставить("ЕстьФильтрПоОрганизации", ПараметрыЗапроса.ЕстьФильтрПоОрганизации);
				ПараметрыПКД.Вставить("ЕстьФильтрПоСотрудникам", ПараметрыЗапроса.ЕстьФильтрПоСотрудникам);
				ПараметрыПКД.Вставить("НачалоПериода", ПараметрыЗапроса.НачалоПериода);
				ПараметрыПКД.Вставить("КонецПериода", ПараметрыЗапроса.КонецПериода);
				ПараметрыПКД.Вставить("Организация", ВыборкаДетальныеЗаписи.Организация);
				ПараметрыПКД.Вставить("ФизическоеЛицо", ВыборкаДетальныеЗаписи.ФизическоеЛицо);
				ПараметрыПКД.Вставить("Подразделение", ВыборкаДетальныеЗаписи.Подразделение);
				ПараметрыПКД.Вставить("Сотрудник", ВыборкаДетальныеЗаписи.Сотрудник);
				ПараметрыПКД.Вставить("_print_forms", МассивВложений);
				
				ПараметрыВызова.Добавить(ПараметрыПКД);
			КонецЕсли; 

		КонецЦикла;	
 	Исключение
		ИнфОбОшибке = ИнформацияОбОшибке();
	КонецПопытки;	
	
	Возврат ПараметрыВызова;
КонецФункции
