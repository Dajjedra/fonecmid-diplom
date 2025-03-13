#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПрограммныйИнтерфейс

Процедура ВыполнитьМассовоеСозданиеАктов(Период, Знач Договоры) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВКМ_ОбслуживаниеКлиента.Договор КАК Договор,
	|	ЗаказПокупателя.Ссылка КАК ЗаказПокупателя,
	|	РеализацияТоваровУслуг.Ссылка КАК СсылкаРеализация,
	|	ЗаказПокупателя.Дата КАК Дата
	|ИЗ
	|	Документ.ВКМ_ОбслуживаниеКлиента КАК ВКМ_ОбслуживаниеКлиента
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ЗаказПокупателя КАК ЗаказПокупателя
	|			ЛЕВОЕ СОЕДИНЕНИЕ Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	|			ПО (РеализацияТоваровУслуг.Основание = ЗаказПокупателя.Ссылка)
	|		ПО ВКМ_ОбслуживаниеКлиента.Договор = ЗаказПокупателя.Договор
	|			И (МЕСЯЦ(ВКМ_ОбслуживаниеКлиента.Дата) = МЕСЯЦ(ЗаказПокупателя.Дата))
	|ГДЕ
	|	ВКМ_ОбслуживаниеКлиента.Дата МЕЖДУ &ДатаНачала И &ДатаОкончания";
	
	Запрос.УстановитьПараметр("ДатаНачала", Период.ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", Период.ДатаОкончания);

	Выборка =  Запрос.Выполнить().Выбрать();
  	ДоговорыТЧ = Договоры;
	
	Пока Выборка.Следующий() Цикл
		СтрокаТЧ = ДоговорыТЧ.Добавить();
		СтрокаТЧ.ДоговорКонтрагента = Выборка.Договор;
		СтрокаТЧ.РеализацияПоДоговору = Выборка.СсылкаРеализация;
		Если Не ЗначениеЗаполнено(СтрокаТЧ.РеализацияПоДоговору) Тогда 
			Если Не ЗначениеЗаполнено(Выборка.ЗаказПокупателя) Тогда
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Текст = СтрШаблон("За этот период нет заказов покупателя по договору %1, документ ""Реализация товаров и услуг"" не создан", Выборка.Договор);
				Сообщение.Сообщить(); 
			Иначе
				НоваяРеализация = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
				НоваяРеализация.Дата = Выборка.Дата;
				НоваяРеализация.Договор = Выборка.Договор;
				НоваяРеализация.Заполнить(Выборка.ЗаказПокупателя);
				НоваяРеализация.ВыполнитьАвтозаполнение();
				НоваяРеализация.ПроверитьЗаполнение();
				НоваяРеализация.Записать();
				СтрокаТЧ.РеализацияПоДоговору = НоваяРеализация.Ссылка;
				НоваяРеализация.Записать(РежимЗаписиДокумента.Проведение);
			КонецЕсли;
		КонецЕсли;	
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#КонецЕсли