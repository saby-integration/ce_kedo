
&После("ВывестиКоманды")
Процедура Integration_ВывестиКоманды(Форма, Команды, ПараметрыРазмещения)
	//В бухгалтерии нужно немного подвинуть группу команд в лево. иначе ее не видно на панели задач
	Если Найти(Метаданные.Имя, "Бухгалтерия") = 0 Тогда Возврат; КонецЕсли;
	Если ПараметрыРазмещения.КоманднаяПанель = Неопределено Тогда Возврат; КонецЕсли;
	РодительЭлемента	= Форма.Элементы.Найти(ПараметрыРазмещения.КоманднаяПанель.Имя);
	ДочерниеЭлементы	= РодительЭлемента.ПодчиненныеЭлементы;
	НазваниеПродукта 	= ЛокализацияНазваниеПродукта();
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
КонецПроцедуры

&После("ПриСозданииНаСервере")
Процедура Integration_ПриСозданииНаСервере(Форма, Знач ПараметрыРазмещения = Неопределено) Экспорт
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
	МодульВстраиваниеВСтандартныеФормы.ДобавитьКолонкиВДинамическийСписок(Форма, ПараметрыРазмещения);
	
	//Если вдруг нужно раскрасить форму, колонку, нам сюда
	//Saby_КолонкиСостояния.УстановитьУсловноеОформление(Форма, НаименованиеРеквизитаСписок, ГруппаНастроек, ПараметрыКритерияОтбора, ГруппаПараметровКритерияОтбора, УспешноеВыполнение);
	
	//Придет время и нас попросят добавить на формы  отбора поле
	//Saby_КолонкиСостояния.УстановитьФильтры(Форма, НаименованиеРеквизитаСписок, ГруппаНастроек, ПараметрыКритерияОтбора, ГруппаПараметровКритерияОтбора, УспешноеВыполнение);
КонецПроцедуры
