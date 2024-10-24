
&НаСервере
Процедура УстановитьТекустЗапросаСписка()
	НовыйЗапрос	=
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|ДС.Объект КАК Сотрудник,
	|ВЫБОР КОГДА ДС.Значение = ИСТИНА
	|	ТОГДА 1
	|	ИНАЧЕ 0
	|КОНЕЦ КАК ИндексКартинки,
	|ДС.Значение КАК КЭДО
	|ПОМЕСТИТЬ СвойстваКЭДО
	|ИЗ
	|	РегистрСведений.ДополнительныеСведения КАК ДС
	|ГДЕ
	|	ДС.Свойство.Имя = ""КЭДО""
	|;
    |
	|////////////////////////////////////////////////////////////////////////////////
    |	ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Saby_Состояние.Объект КАК Ссылка,
	|	Saby_Состояние.Сервис КАК Сервис,
	|	Saby_Состояние.Аккаунт КАК Аккаунт,
	|	Saby_Состояние.АктивныйЭтап КАК АктивныйЭтап,
	|	Saby_Состояние.Состояние КАК Состояние,
	|	Saby_Состояние.UID КАК UID,
	|	Saby_Состояние.SbisId КАК SbisId,
	|	ВЫБОР
	|		КОГДА НаличиеФайлов.ЕстьФайлы ЕСТЬ NULL
	|			ТОГДА 0
	|		КОГДА НаличиеФайлов.ЕстьФайлы
	|			ТОГДА 1
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК ЕстьФайлы,
	|	ВЫБОР
	|		КОГДА Saby_Состояние.Объект.Организация ЕСТЬ NULL
	|			ТОГДА Saby_Состояние.Объект.ГоловнаяОрганизация
	|		ИНАЧЕ Saby_Состояние.Объект.Организация
	|	КОНЕЦ КАК Организация,
	|	ВЫБОР
	|		КОГДА Saby_Состояние.Объект.Сотрудник ЕСТЬ NULL
	|			ТОГДА Saby_Состояние.Объект
	|		ИНАЧЕ Saby_Состояние.Объект.Сотрудник
	|	КОНЕЦ КАК Сотрудник
	|ПОМЕСТИТЬ ВТ
	|ИЗ
	|	РегистрСведений.Saby_Состояние КАК Saby_Состояние
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.НаличиеФайлов КАК НаличиеФайлов
	|		ПО (Saby_Состояние.Объект = НаличиеФайлов.ОбъектСФайлами)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ.Ссылка КАК Ссылка,
	|	ВТ.Сервис КАК Сервис,
	|	ВТ.Аккаунт КАК Аккаунт,
	|	ВТ.АктивныйЭтап КАК АктивныйЭтап,
	|	ВТ.Состояние КАК Состояние,
	|	ВТ.UID КАК UID,
	|	ВТ.SbisId КАК SbisId,
	|	ВТ.ЕстьФайлы КАК ЕстьФайлы,
	|	ВТ.Организация КАК Организация,
	|	ВТ.Сотрудник КАК Сотрудник,
	|	КадроваяИсторияСотрудниковСрезПоследних.Подразделение КАК Подразделение,
	|	КадроваяИсторияСотрудниковСрезПоследних.Должность КАК Должность,
	|	ЕСТЬNULL(СвойстваКЭДО.ИндексКартинки, 0)  КАК ПризнакКЭДО
	|ИЗ
	|	ВТ КАК ВТ
	|	ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КадроваяИсторияСотрудников.СрезПоследних КАК КадроваяИсторияСотрудниковСрезПоследних
	|	ПО (ВТ.Организация = КадроваяИсторияСотрудниковСрезПоследних.ГоловнаяОрганизация
	|			И ВТ.Сотрудник.Ссылка = КадроваяИсторияСотрудниковСрезПоследних.Сотрудник
	|			И ВТ.Сотрудник.ФизическоеЛицо.Ссылка = КадроваяИсторияСотрудниковСрезПоследних.ФизическоеЛицо)
	|	ЛЕВОЕ СОЕДИНЕНИЕ СвойстваКЭДО КАК СвойстваКЭДО
	|	ПО (ВТ.Сотрудник.Ссылка = СвойстваКЭДО.Сотрудник)
	|		";
	
	// Данная магия програмного добавления нужна, для того, что бы не захватывать все дополнительные справочнеики используемыве в запросе
	Список.ТекстЗапроса	 = НовыйЗапрос;
КонецПроцедуры

