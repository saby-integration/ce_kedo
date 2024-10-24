
&НаСервере
Процедура УбратьДублиСотрудников()
	ВрТаблица =СписокИсполнителей.Выгрузить(,"Сотрудник");
	ВрТаблица.Свернуть("Сотрудник");
	СписокИсполнителей.Загрузить(ВрТаблица);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытииФормыВыбораСотрудника(Значение, ДопПараметры) Экспорт
	Если ТипЗнч(Значение) = Тип("Массив") Тогда
		Для Каждого НовыйСотрудник Из Значение Цикл
			НоваяСтрока = СписокИсполнителей.Добавить();
			НоваяСтрока.Сотрудник	= НовыйСотрудник;
		КонецЦикла;
    КонецЕсли;
    УбратьДублиСотрудников();
КонецПроцедуры
		
&НаКлиенте
Процедура ДобавитьСотрудника(Команда)
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("РежимВыбора", Истина);
	ПараметрыФормы.Вставить("МножественныйВыбор", Истина);
	ОбработкаВыбора = Новый ОписаниеОповещения(
		"ПриЗакрытииФормыВыбораСотрудника",
		ЭтаФорма,
		"ПодборРеализации");
	ОткрытьФорму(
			"Справочник.Сотрудники.ФормаВыбора",
			ПараметрыФормы,
	        ЭтаФорма,
			,
			,
			,
			ОбработкаВыбора);
КонецПроцедуры

&НаКлиенте
Процедура СписокИсполнителейСотрудникПриИзменении(Элемент)
	УбратьДублиСотрудников();
КонецПроцедуры

