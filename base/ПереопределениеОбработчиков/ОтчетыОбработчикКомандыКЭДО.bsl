Процедура Saby_ЗаполнитьЗначениПараметраОтбора(ПараметрыВызова, ЭлементОтбора, ОтбораЗначение, ОтбораИспользование)
	ПараметрыВызова.Вставить(ОтбораЗначение, ЭлементОтбора.ПравоеЗначение);
	ПараметрыВызова.Вставить(ОтбораИспользование, ЭлементОтбора.Использование);
КонецПроцедуры

Процедура Saby_ЗаполнитьЗначенияПараметровОтбора(ПользовательскиеНастройки, ПараметрыВызова)
		Для Каждого ЭлементОтбора Из ПользовательскиеНастройки Цикл
			// Взаимоисключающиеся параметры.
			Если	ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных")
				И ТипЗнч(ЭлементОтбора.ПравоеЗначение) = Тип("СправочникСсылка.Организации") Тогда
				// Организации
				Saby_ЗаполнитьЗначениПараметраОтбора(ПараметрыВызова, ЭлементОтбора, "Организация", "ЕстьФильтрПоОрганизации");
			ИначеЕсли	ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных")
				И ТипЗнч(ЭлементОтбора.ПравоеЗначение) = Тип("СправочникСсылка.ФизическиеЛица") Тогда
				// ФизическиеЛица
				Saby_ЗаполнитьЗначениПараметраОтбора(ПараметрыВызова, ЭлементОтбора, "ФизическиеЛица", "ЕстьФильтрПоСотрудникам");
			ИначеЕсли	ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных")
				И ТипЗнч(ЭлементОтбора.ПравоеЗначение) = Тип("СправочникСсылка.Сотрудники") Тогда
				// ФизическиеЛица
				Saby_ЗаполнитьЗначениПараметраОтбора(ПараметрыВызова, ЭлементОтбора, "Сотрудники", "ЕстьФильтрПоСотрудникам");
			ИначеЕсли	ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных")
				И ТипЗнч(ЭлементОтбора.ПравоеЗначение) = Тип("СправочникСсылка.ПодразделенияОрганизаций") Тогда
				// ФизическиеЛица
				Saby_ЗаполнитьЗначениПараметраОтбора(ПараметрыВызова, ЭлементОтбора, "Подразделения", "ЕстьФильтрПоПодразделениям");
			ИначеЕсли	ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных")
				 И ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке 
					Тогда
						Если ЭлементОтбора.ПравоеЗначение.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.Организации") Тогда
							// Список - Организации
							Saby_ЗаполнитьЗначениПараметраОтбора(ПараметрыВызова, ЭлементОтбора, "Организация", "ЕстьФильтрПоОрганизации");
							
						ИначеЕсли ЭлементОтбора.ПравоеЗначение.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.ФизическиеЛица") Тогда
							Saby_ЗаполнитьЗначениПараметраОтбора(ПараметрыВызова, ЭлементОтбора, "ФизическиеЛица", "ЕстьФильтрПоСотрудникам");
						ИначеЕсли ЭлементОтбора.ПравоеЗначение.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.Сотрудники") Тогда
							Saby_ЗаполнитьЗначениПараметраОтбора(ПараметрыВызова, ЭлементОтбора, "Сотрудники", "ЕстьФильтрПоСотрудникам");
						Иначе
							Если ЭлементОтбора.ПравоеЗначение.ТипЗначения = Новый ОписаниеТипов("СправочникСсылка.ПодразделенияОрганизаций") Тогда
								// Список - ПодразделенияОрганизаций
								Saby_ЗаполнитьЗначениПараметраОтбора(ПараметрыВызова, ЭлементОтбора, "Подразделения", "ЕстьФильтрПоПодразделениям");
							КонецЕсли;	
						КонецЕсли;	
			Иначе
				Если	ТипЗнч(ЭлементОтбора) = Тип("ЗначениеПараметраНастроекКомпоновкиДанных")
					И ТипЗнч(ЭлементОтбора.Значение) = Тип("СтандартныйПериод")
						Тогда
					ПараметрыВызова.НачалоПериода			= ЭлементОтбора.Значение.ДатаНачала;
					ПараметрыВызова.КонецПериода			= ЭлементОтбора.Значение.ДатаОкончания;
				ИначеЕсли	ТипЗнч(ЭлементОтбора) = Тип("ЗначениеПараметраНастроекКомпоновкиДанных")
					И ТипЗнч(ЭлементОтбора.Значение) = Тип("СтандартнаяДатаНачала")
						Тогда
					ПараметрыВызова.НачалоПериода			= ЭлементОтбора.Значение.Дата;
					ПараметрыВызова.КонецПериода			= Дата(1,1,1);
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
КонецПроцедуры

Процедура Saby_ОбработчикКоманды_КЭДО(ФормаОтчета, Команда, Результат,context_params = Неопределено)
	Если 	ФормаОтчета.ИмяФормы = "Отчет.АнализНачисленийИУдержаний.Форма" Тогда
			
		ПараметрыВызова = Новый Структура("НачалоПериода,КонецПериода,ФизическиеЛица,Организация,ЕстьФильтрПоСотрудникам,ЕстьФильтрПоОрганизации");
        Saby_ЗаполнитьЗначенияПараметровОтбора(ФормаОтчета.Отчет.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы, ПараметрыВызова);
		
		Если Команда.Имя = "Saby_КЭДО_ОтправитьРасчетныйЛистокВСбис" Тогда	
			Saby_КомандыОбменаДляФормыКлиент.ОтправитьРасчетныйЛистокВСБИС(ПараметрыВызова,context_params);
		ИначеЕсли Команда.Имя = "Saby_КЭДО_ОтправитьСокращенныйРасчетныйЛистокВСбис" Тогда	
			Saby_КомандыОбменаДляФормыКлиент.ОтправитьСокращенныйРасчетныйЛистокВСБИС(ПараметрыВызова, context_params);
		ИначеЕсли Команда.Имя = "Saby_КЭДО_ОтправитьПрочийКадровыйРасчетныйЛистокВСбис" Тогда
			СписокРегламента = Saby_ВстраиваниеВСтандартныеФормы.ПолучитьСписокРегламентов("CadresOther");
			ВыборРегламент = Новый СписокЗначений();
			ВыборРегламент.Добавить(Неопределено, "По умолчанию");
			Для каждого СтрРегл из СписокРегламента Цикл
				ВыборРегламент.Добавить(СтрРегл["Name"], СтрРегл["Name"]);	
			КонецЦикла;	
			Оповещение = Новый ОписаниеОповещения("ОтправитьПрочийКадровыйРасчетныйЛистокВСБИС", ЭтотОбъект, ПараметрыВызова );
			ВыборРегламент.ПоказатьВыборЭлемента(Оповещение,"Выберите регламент");
	
			//Saby_КомандыОбменаДляФормыКлиент.ОтправитьПрочийКадровыйРасчетныйЛистокВСБИС(ПараметрыВызова);
		КонецЕсли;	
		Результат = Истина;
	ИначеЕсли ФормаОтчета.ИмяФормы = "Отчет.ОстаткиОтпусков.Форма" Тогда
		ПараметрыВызова = Новый Структура("НачалоПериода,КонецПериода,Сотрудники,Организация,Подразделения,ЕстьФильтрПоСотрудникам,ЕстьФильтрПоОрганизации,ЕстьФильтрПоПодразделениям");
        Saby_ЗаполнитьЗначенияПараметровОтбора(ФормаОтчета.Отчет.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы, ПараметрыВызова);
		Если Команда.Имя = "Saby_КЭДО_ЗагрузитьДанныеВSABY" Тогда	
			Saby_КомандыОбменаДляФормыКлиент.ВыполнитьПроизвольныйИНИ("ОстаткиОтпусков_send", ПараметрыВызова);
		ИначеЕсли Команда.Имя = "Saby_КЭДО_ЗагрузитьВложенияВSABY" Тогда
			Saby_КомандыОбменаДляФормыКлиент.ВыполнитьПроизвольныйИНИ("ПрочийКадровыйОстаткиОтпусков_send", ПараметрыВызова);
		КонецЕсли;	
		Результат = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура ОтправитьПрочийКадровыйРасчетныйЛистокВСБИС(ВыбранныйРегламент, ПараметрыВызова) Экспорт
	Если ВыбранныйРегламент = Неопределено Тогда
		Сообщить("Отправка отменена");
		Возврат;
	Иначе		
		ПараметрыВызова.Вставить("Регламент", ВыбранныйРегламент.Значение);
	КонецЕсли;	
	Saby_КомандыОбменаДляФормыКлиент.ОтправитьПрочийКадровыйРасчетныйЛистокВСБИС(ПараметрыВызова);	
КонецПроцедуры	

