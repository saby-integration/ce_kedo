
#Область include_base_CommonModule_ИмяМодуляCore
#КонецОбласти

&Перед("ПриНачалеРаботыСистемы")
Процедура Integration_ПриНачалеРаботыСистемы(Знач ОповещениеЗавершения, НепрерывноеВыполнение)
	МодульCore().ПриНачалеРаботыСистемыНаСервере();
КонецПроцедуры
