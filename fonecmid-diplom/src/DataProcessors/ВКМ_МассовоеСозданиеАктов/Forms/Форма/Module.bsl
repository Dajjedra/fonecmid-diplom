&НаКлиенте
Процедура Заполнить(Команда)
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	
	ОповещениеОЗавершении = Новый ОписаниеОповещения("ОповещениеОЗавершении", ЭтотОбъект);
	ДлительнаяОперация = ЗаполнитьНаСервере();
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания); 
	
КонецПроцедуры 

&НаСервере
Функция ЗаполнитьНаСервере()
	
	СтруктураПериодМассивАктов = Новый Структура;
	СтруктураПериодМассивАктов.Вставить("Период", Объект.Период); 
	
	ДлительнаяОперация = ДлительныеОперации.ВыполнитьФункцию(УникальныйИдентификатор, "Обработки.ВКМ_МассовоеСозданиеАктов.ВыполнитьМассовоеСозданиеАктов", СтруктураПериодМассивАктов);
	
	ТЗВыборка = Обработки.ВКМ_МассовоеСозданиеАктов.ВыполнитьМассовоеСозданиеАктов(СтруктураПериодМассивАктов);
	Для каждого Строка Из ТЗВыборка Цикл
		СтрокаТЧ = Объект.Договоры.Добавить();
		СтрокаТЧ.ДоговорКонтрагента = Строка.Договор;
		СтрокаТЧ.РеализацияПоДоговору = Строка.СсылкаРеализация;
		Если Не ЗначениеЗаполнено(СтрокаТЧ.РеализацияПоДоговору) Тогда
			НоваяРеализация = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
			НоваяРеализация.Дата = Строка.Дата;
			НоваяРеализация.Договор = Строка.Договор;
			НоваяРеализация.Заполнить(Строка.ЗаказПокупателя);
			НоваяРеализация.ВыполнитьАвтозаполнение();
			НоваяРеализация.ПроверитьЗаполнение();
			НоваяРеализация.Записать();
			СтрокаТЧ.РеализацияПоДоговору = НоваяРеализация.Ссылка;
			НоваяРеализация.Записать(РежимЗаписиДокумента.Проведение);
		КонецЕсли;	
	КонецЦикла;
	
	Возврат ДлительнаяОперация;
	
КонецФункции 

&НаКлиенте
Процедура ОповещениеОЗавершении(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат.Статус = "Выполнено" Тогда		
		Сообщить("Загрузка завершена."); 	
	КонецЕсли
	
КонецПроцедуры

