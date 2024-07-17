#Область ОписаниеПеременных

&НаКлиенте
Перем ИнтервалОжидания;
&НаКлиенте
Перем ФормаЗакрывается;

#КонецОбласти

#Область include_core_base_locale_ЛокализацияНазваниеПродукта
#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ЭтаФорма.Заголовок = Параметры.ФоновоеЗаданиеНаименование;
	ТекстСообщения = НСтр("ru = 'Пожалуйста, подождите...'");
	Если Не ПустаяСтрока(Параметры.ТекстСообщения) Тогда
		ТекстСообщения = Параметры.ТекстСообщения + Символы.ПС + ТекстСообщения;
		Элементы.ДекорацияПоясняющийТекстДлительнойОперации.Заголовок = ТекстСообщения;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Параметры.ИдентификаторЗадания) Тогда
		ИдентификаторЗадания = Параметры.ИдентификаторЗадания;
	Иначе
		ИдентификаторЗадания = Новый УникальныйИдентификатор;
	КонецЕсли;
	ВложенияАдресВХранилище = ПоместитьВоВременноеХранилище("", ЭтаФорма.УникальныйИдентификатор);
	Параметры.ФоновоеЗаданиеПараметры[0].Вставить("ВложенияАдресВХранилище", ВложенияАдресВХранилище);
	
	ФоновоеЗадание = ФоновыеЗадания.Выполнить(Параметры.ФоновоеЗаданиеИмяМетода, Параметры.ФоновоеЗаданиеПараметры, Строка(ИдентификаторЗадания),Параметры.ФоновоеЗаданиеНаименование);
	ИдентификаторЗадания = ФоновоеЗадание.УникальныйИдентификатор;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если Параметры.ВыводитьОкноОжидания Тогда
		ИнтервалОжидания = ?(Параметры.Интервал <> 0, Параметры.Интервал, 1);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", ИнтервалОжидания, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ОтключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания");
	
	Если Статус <> "Выполняется" Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	ПодключитьОбработчикОжидания("Подключаемый_ОтменитьЗадание", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	Если Статус <> "Выполняется" Тогда
		Возврат;
	КонецЕсли;
	
	ОтменитьВыполнениеЗадания();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область include_core_base_ДлительныеОперации_ПередатьСтатистику
#КонецОбласти

&НаСервере
Процедура ПерезапуститьФоновоеЗадание()
	Задание = Saby_ФоновыеЗаданияСервер.НайтиЗаданиеПоИдентификатору(ИдентификаторЗадания);
	ФоновоеЗадание = ФоновыеЗадания.Выполнить(Параметры.ФоновоеЗаданиеИмяМетода, Параметры.ФоновоеЗаданиеПараметры, Задание.Ключ,Параметры.ФоновоеЗаданиеНаименование);	
	ИдентификаторЗадания = ФоновоеЗадание.УникальныйИдентификатор;
КонецПроцедуры

#Область Подключаемый_ПроверитьВыполнениеЗадания

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()
	
	Задание = ПроверитьЗаданиеВыполнено(ФормаЗакрывается);
	Статус = Задание.Статус;
	СтатистикаПередана = Ложь;
	
	ДополнительныеПараметры_ = get_prop(Задание.Прогресс, "ДополнительныеПараметры");
	Если ТипЗнч(ДополнительныеПараметры) <> Тип("Структура") Тогда
		ДополнительныеПараметры = Новый Структура();
	КонецЕсли;
	
	Если Задание.Прогресс <> Неопределено Тогда
		Если ТипЗнч(ДополнительныеПараметры_) = Тип("Структура") Тогда
			Для Каждого ЗнчКлюч Из ДополнительныеПараметры_ Цикл
				ДополнительныеПараметры.Вставить(ЗнчКлюч.Ключ, ЗнчКлюч.Значение);
			КонецЦикла;
		КонецЕсли;
		ПрогрессСтрокой = ПрогрессСтрокой(Задание.Прогресс);
		Если Не ПустаяСтрока(ПрогрессСтрокой) Тогда
			Элементы.ДекорацияПоясняющийТекстДлительнойОперации.Заголовок = ТекстСообщения + Символы.ПС + ПрогрессСтрокой;
			ТекстОповещения = Задание.Прогресс.Текст;
		КонецЕсли;
	КонецЕсли;
	Если Задание.Сообщения <> Неопределено И ВладелецФормы <> Неопределено Тогда
		ИдентификаторНазначения = ВладелецФормы.УникальныйИдентификатор;
		Для каждого СообщениеПользователю Из Задание.Сообщения Цикл
			СообщениеПользователю.ИдентификаторНазначения = ИдентификаторНазначения;
			СообщениеПользователю.Сообщить();
		КонецЦикла;
		Задание.Сообщения = Новый ФиксированныйМассив(Новый Массив);
	КонецЕсли;
	
	Если Статус = "Выполнено" Тогда
		СтатусВыполнения = get_prop(ДополнительныеПараметры, "status");
		Если СтатусВыполнения = "run" Тогда
			// Выполняем команду через оповещение
			Контекст = Новый Структура;
			Контекст.Вставить("step", ДополнительныеПараметры.step);
			
			ВыполнитьКоманды_Клиент(
				Новый ОписаниеОповещения("Подключаемый_ПроверитьВыполнениеЗаданияПослеВыполненияКоманды", ЭтотОбъект, Контекст),
				ДополнительныеПараметры.commands,
				ДополнительныеПараметры.commands_data);
				
			Возврат;

		ИначеЕсли СтатусВыполнения = "error" Тогда
			//TODO отвратительно
			РезультатВыгрузки = ДополнительныеПараметры.data;
			КартинкаОповещения = БиблиотекаКартинок["Ошибка32"];

			Если ТипЗнч(РезультатВыгрузки.detail) = Тип("Строка") Тогда
				ТекстОповещения = СокрЛП(РезультатВыгрузки.message) + ". " +  СокрЛП(РезультатВыгрузки.detail);
			Иначе	
				ТекстОповещения = СокрЛП(РезультатВыгрузки.message) + ". ";
			КонецЕсли;
			ПередатьСтатистику_Клиент(Статус, СтатусВыполнения, Задание, ДополнительныеПараметры);
			СтатистикаПередана = Истина;
			ExtExceptionToJournal(РезультатВыгрузки);
		ИначеЕсли СтатусВыполнения = "complete" Тогда
			Если Не ЗначениеЗаполнено(ТекстОповещения) Тогда
				ТекстОповещения = "Выполнено";
			КонецЕсли;
			
			ДопПараметрыДата = get_prop(ДополнительныеПараметры, "Data");
			КартинкаИмя = get_prop(ДопПараметрыДата, "Картинка");
			Если Не ПустаяСтрока(КартинкаИмя) Тогда
				КартинкаОповещения = БиблиотекаКартинок[КартинкаИмя];
			Иначе
				КартинкаОповещения = БиблиотекаКартинок["ЗеленаяГалка"];
			КонецЕсли;
			КоличествоОшибок		= get_prop(ДополнительныеПараметры, "CountErrors", 0);
			КоличествоОбработано	= get_prop(ДополнительныеПараметры, "CountConfirmed", 0);
			ВсегоОбъектов			= get_prop(ДополнительныеПараметры, "CountObjects", 0);
			Если	КоличествоОшибок > 0
					ИЛИ КоличествоОшибок + КоличествоОбработано <> ВсегоОбъектов Тогда
				СтатусВыполнения = "error";
				КартинкаОповещения = БиблиотекаКартинок[ЛокализацияНазваниеПродукта()+"_Ошибка32"];
			КонецЕсли;
			
			Если ЗначениеЗаполнено(СтатусВыполнения) Тогда
				ПередатьСтатистику_Клиент(Статус, СтатусВыполнения, Задание, ДополнительныеПараметры);
				СтатистикаПередана = Истина;
			КонецЕсли;
		КонецЕсли;
		Если Не СтатистикаПередана Тогда
			ПередатьСтатистику_Клиент(Статус, СтатусВыполнения, Задание, ДополнительныеПараметры);
		КонецЕсли;
		
		//Сообщений об ошибке может быть несколько
		СообщенияДата = Saby_Core.get_prop(ДополнительныеПараметры, "data");
		мСообщений = Неопределено;
		Если ТипЗнч(СообщенияДата) = Тип("Структура") или ТипЗнч(СообщенияДата) = Тип("Соответствие") Тогда
			мСообщений = Saby_Core.get_prop(СообщенияДата, "detail");
		КонецЕсли;
		Если ТипЗнч(мСообщений) = Тип("Массив") Тогда
			ТекстОповещения_ = ТекстОповещения;
			Для Каждого ДанныеСообщения Из мСообщений Цикл
				ТекстОповещения		= Saby_Core.get_prop(ДанныеСообщения, "message") +" "+ Saby_Core.get_prop(ДанныеСообщения, "detail");
				ПоказатьОповещение();
			КонецЦикла;
			ТекстОповещения = ТекстОповещения_;
			ДополнительныеПараметры.data.Вставить("detail", "");
		КонецЕсли;
		//Итоговое
		ПоказатьОповещение();

		Если ВозвращатьРезультатВОбработкуВыбора() Тогда
			ОповеститьОВыборе(Задание.Результат);
			Возврат;
		КонецЕсли;
		Закрыть(РезультатВыполнения(Задание));
		Возврат;
		
	ИначеЕсли Статус = "Ошибка" Тогда
		
		ПередатьСтатистику_Клиент(Статус, Неопределено, Задание, ДополнительныеПараметры);
		Закрыть(РезультатВыполнения(Задание));
		Если ВозвращатьРезультатВОбработкуВыбора() Тогда
			ВызватьИсключение Задание.КраткоеПредставлениеОшибки;
		КонецЕсли;
		Возврат;
		
	КонецЕсли;
	
	Если Параметры.ВыводитьОкноОжидания Тогда
		Если Параметры.Интервал = 0 Тогда
			ИнтервалОжидания = ИнтервалОжидания * 1.4;
			Если ИнтервалОжидания > 15 Тогда
				ИнтервалОжидания = 15;
			КонецЕсли;
		КонецЕсли;
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", ИнтервалОжидания, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗаданияПослеВыполненияКоманды(commands_result, Контекст) Экспорт
	
	Параметры.ФоновоеЗаданиеПараметры[0]["commands_result"] = commands_result;
	Параметры.ФоновоеЗаданиеПараметры[0].Вставить("step", Контекст.step);
	
	ПерезапуститьФоновоеЗадание();
	Если Параметры.ВыводитьОкноОжидания Тогда
		Если Параметры.Интервал = 0 Тогда
			ИнтервалОжидания = ИнтервалОжидания * 1.4;
			Если ИнтервалОжидания > 15 Тогда
				ИнтервалОжидания = 15;
			КонецЕсли;
		КонецЕсли;
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", ИнтервалОжидания, Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура Подключаемый_ОтменитьЗадание()
	
	ФормаЗакрывается = Истина;
	Подключаемый_ПроверитьВыполнениеЗадания(); // а вдруг задание уже выполнилось.
	Если Статус = "Отменено" Тогда
		Статус = Неопределено;
		Если Открыта() Тогда
			Закрыть(РезультатВыполнения(Неопределено));
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьОповещение()
	
	Если Параметры.ОповещениеПользователя = Неопределено Или Не Параметры.ОповещениеПользователя.Показать Тогда
		Возврат;
	КонецЕсли;
	
	Оповещение = Параметры.ОповещениеПользователя;
	
	НавигационнаяСсылкаОповещения = Оповещение.НавигационнаяСсылка;
	Если НавигационнаяСсылкаОповещения = Неопределено И ВладелецФормы <> Неопределено И ВладелецФормы.Окно <> Неопределено Тогда
		НавигационнаяСсылкаОповещения = ВладелецФормы.Окно.ПолучитьНавигационнуюСсылку();
	КонецЕсли;
	ПояснениеОповещения = Оповещение.Пояснение;
	Если ПояснениеОповещения = Неопределено И ВладелецФормы <> Неопределено И ВладелецФормы.Окно <> Неопределено Тогда
		ПояснениеОповещения = ВладелецФормы.Окно.Заголовок;
	КонецЕсли;
	
	Если 	Параметры.ФоновоеЗаданиеНаименование = "Отправка в "+ЛокализацияНазваниеПродукта() //команда - "Отправка в СБИС"
				или 
			Параметры.ФоновоеЗаданиеНаименование = "Выгрузка в 1С"  //Действие -"Выгрузка в 1С" с формы задач
				Тогда
		НавигационнаяСсылкаОповещения = Новый ОписаниеОповещения("ОткрытьФормуОтчетаОЗагрузке", Saby_КомандыОбменаДляФормыКлиент,Параметры.ФоновоеЗаданиеПараметры[0]);
	КонецЕсли;
	Оповестить("Saby_ЗавершениеДлительнойОперации");
	ПоказатьОповещениеПользователя(ПояснениеОповещения,НавигационнаяСсылкаОповещения, 
		?(НЕ ПустаяСтрока(ТекстОповещения),ТекстОповещения, ?(Оповещение.Текст <> Неопределено, Оповещение.Текст, НСтр("ru = 'Действие выполнено'")))
		,КартинкаОповещения
		,СтатусОповещенияПользователя.Важное,);

КонецПроцедуры

&НаСервере
Функция ПроверитьЗаданиеВыполнено(ФормаЗакрывается)
	
	Задание = Saby_ФоновыеЗаданияСервер.ОперацияВыполнена(ИдентификаторЗадания, Ложь, Параметры.ВыводитьПрогрессВыполнения,
		Параметры.ВыводитьСообщения);
	
	Если Параметры.ПолучатьРезультат Тогда
		Если Задание.Статус = "Выполнено" Тогда
			Задание.Вставить("Результат", ПолучитьИзВременногоХранилища(Параметры.АдресРезультата));
		Иначе
			Задание.Вставить("Результат", Неопределено);
		КонецЕсли;
	КонецЕсли;
	
	Если ФормаЗакрывается = Истина Тогда
		ОтменитьВыполнениеЗадания();
		Задание.Статус = "Отменено";
	КонецЕсли;	
	
	Возврат Задание;
	
КонецФункции

&НаКлиенте
Функция ПрогрессСтрокой(Прогресс)
	
	Результат = "";
	Если Прогресс = Неопределено Тогда
		Возврат Результат;
	КонецЕсли;
	
	Процент = 0;
	Если Прогресс.Свойство("Процент", Процент) Тогда
		Результат = Строка(Процент) + "%";
	КонецЕсли;
	Текст = 0;
	Если Прогресс.Свойство("Текст", Текст) Тогда
		Если Не ПустаяСтрока(Результат) Тогда
			Результат = Результат + " (" + Текст + ")";
		Иначе
			Результат = Текст;
		КонецЕсли;
	КонецЕсли;

	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция РезультатВыполнения(Задание)
	
	Если Задание = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("Статус", Задание.Статус);
	Результат.Вставить("АдресРезультата", Параметры.АдресРезультата);
	Результат.Вставить("АдресДополнительногоРезультата", Параметры.АдресДополнительногоРезультата);
	Результат.Вставить("КраткоеПредставлениеОшибки", Задание.КраткоеПредставлениеОшибки);
	Результат.Вставить("ПодробноеПредставлениеОшибки", Задание.ПодробноеПредставлениеОшибки);
	Результат.Вставить("Сообщения", Задание.Сообщения);
	
	Если Параметры.ПолучатьРезультат Тогда
		Результат.Вставить("Результат", Задание.Результат);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ВозвращатьРезультатВОбработкуВыбора()
	Возврат ОписаниеОповещенияОЗакрытии = Неопределено
		И Параметры.ПолучатьРезультат
		И ТипЗнч(ВладелецФормы) = Тип("ФормаКлиентскогоПриложения");
КонецФункции

&НаСервере
Процедура ОтменитьВыполнениеЗадания()
	
	ДлительныеОперации.ОтменитьВыполнениеЗадания(ИдентификаторЗадания);
	
КонецПроцедуры

#КонецОбласти

#Область include_core_base_ExtException
#КонецОбласти 

#Область include_core_base_Helpers_РаботаСоСвойствамиСтруктуры
#КонецОбласти

#Область include_BlocklyExecutor_base_Commands
#КонецОбласти



#Область include_core_base_Криптография_НаКлиенте1С_МодульФормы
#КонецОбласти

#Область include_core_base_Криптография_НаКлиенте1С
#КонецОбласти
