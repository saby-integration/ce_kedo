
// BSP.3001007294

&Вместо("ВидыКоманд")
Функция Integration_ВидыКоманд()
	МодульCore = МодульCore();
	Результат = ПродолжитьВызов();
	НазваниеПродукта = ЛокализацияНазваниеПродукта();
	Если МодульCore.ТекущемуПользователюМожноРаботатьСРасширением() ИЛИ
		МодульCore.ВключеноИспользованиеПодсистемыКЕДО() Тогда
		Вид				= Результат.Добавить();
		Вид.Заголовок	= НазваниеПродукта;
		Вид.Имя			= НазваниеПродукта+"_КОМАНДЫ";
		Вид.ИмяПодменю	= НазваниеПродукта+"_Integration";
		Вид.Порядок		= 20;
		Вид.Картинка    = Новый Картинка;
		Вид.Отображение = ОтображениеКнопки.КартинкаИТекст;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

&После("ВывестиКоманды")
Процедура Integration_ВывестиКоманды(Форма, Команды, ПараметрыРазмещения)
	НазваниеПродукта 	= ЛокализацияНазваниеПродукта();
	//В бухгалтерии нужно немного подвинуть группу команд в лево. иначе ее не видно на панели задач
	Если Найти(Метаданные.Имя, "Бухгалтерия") > 0 Тогда 
		Если ПараметрыРазмещения.КоманднаяПанель = Неопределено Тогда Возврат; КонецЕсли;
		РодительЭлемента	= Форма.Элементы.Найти(ПараметрыРазмещения.КоманднаяПанель.Имя);
		ДочерниеЭлементы	= РодительЭлемента.ПодчиненныеЭлементы;
		Подгруппа			= ДочерниеЭлементы.Найти(НазваниеПродукта+"_Integration");
		СтрокаПоиска		= Неопределено;
		Для Каждого ЭлементДочерний Из  ДочерниеЭлементы Цикл
			Если Найти(ЭлементДочерний.Имя, "СтрокаПоиска" ) > 0 Тогда
				СтрокаПоиска	= ЭлементДочерний;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		Если
			РодительЭлемента <> Неопределено И
			СтрокаПоиска <> Неопределено И
			Подгруппа <> Неопределено
												Тогда
			Форма.Элементы.Переместить(Подгруппа, РодительЭлемента, СтрокаПоиска);
		КонецЕсли;
	КонецЕсли;
	//В бухгалтерии нужно немного подвинуть группу команд в лево. иначе ее не видно на панели задач
	Если Найти(Метаданные.Имя, "КаминЗарплата") > 0 Тогда 
		РодительЭлемента	= Форма.Элементы.Найти("ФормаКоманднаяПанель");
		ДочерниеЭлементы	= РодительЭлемента.ПодчиненныеЭлементы;
		Подгруппа			= ДочерниеЭлементы.Найти(НазваниеПродукта+"_Integration");
		СтрокаПоиска		= Неопределено;

		// Формы журналов документов
		Для Каждого ЭлементДочерний Из  ДочерниеЭлементы Цикл
			Если Найти(ЭлементДочерний.Имя, "СоздатьДокументСЗВТД" ) > 0 Тогда
				СтрокаПоиска	= ЭлементДочерний;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		
		// Формы списка справочников
		// Если не нашли элемент СоздатьДокументСЗВТД, поишем кнопку - Обновить
		Если СтрокаПоиска	= Неопределено Тогда 
			Для Каждого ЭлементДочерний Из  ДочерниеЭлементы Цикл
				Если Найти(ЭлементДочерний.Имя, "Обновить" ) > 0 Тогда
					СтрокаПоиска	= ЭлементДочерний;
					Прервать;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
			
		Если
			РодительЭлемента <> Неопределено И
			СтрокаПоиска <> Неопределено И
			Подгруппа <> Неопределено
												Тогда
			Форма.Элементы.Переместить(Подгруппа, РодительЭлемента, СтрокаПоиска);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&После("ПриСозданииНаСервере")
Процедура Integration_ПриСозданииНаСервере(Форма, ПараметрыРазмещения = Неопределено) Экспорт
	//Добавление колонок
	МодульВстраиваниеВСтандартныеФормы = МодульВстраиваниеВСтандартныеФормы(); 
	МодульCore = МодульCore();

	Если 
		Не МодульВстраиваниеВСтандартныеФормы.ЭтоФормаСписка(Форма) ИЛИ
		МодульВстраиваниеВСтандартныеФормы.ЭтоФормаИсключения(Форма) ИЛИ
		//Проверка прав
		НЕ МодульCore.ТекущемуПользователюМожноРаботатьСРасширением() ИЛИ
		НЕ МодульCore.ВключеноИспользованиеПодсистемыКЕДО()
		Тогда
		Возврат; 
	КонецЕсли;
	МодульВстраиваниеВСтандартныеФормы.ДобавитьКолонкиВДинамическийСписок(Форма);
	
	//Если вдруг нужно раскрасить форму, колонку, нам сюда
	//Saby_КолонкиСостояния.УстановитьУсловноеОформление(Форма, НаименованиеРеквизитаСписок, ГруппаНастроек, ПараметрыКритерияОтбора, ГруппаПараметровКритерияОтбора, УспешноеВыполнение);
	
	//Придет время и нас попросят добавить на формы  отбора поле
	//Saby_КолонкиСостояния.УстановитьФильтры(Форма, НаименованиеРеквизитаСписок, ГруппаНастроек, ПараметрыКритерияОтбора, ГруппаПараметровКритерияОтбора, УспешноеВыполнение);
КонецПроцедуры
