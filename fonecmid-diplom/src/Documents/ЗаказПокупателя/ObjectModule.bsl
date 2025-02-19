
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Ответственный = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	СуммаДокумента = Товары.Итог("Сумма") + Услуги.Итог("Сумма");
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)

	Движения.ЗадолженностьПокупателей.Записывать = Истина;
	Движения.ОбработкаЗаказов.Записывать = Истина;
	Движения.Продажи.Записывать = Истина;
	
	Движение = Движения.ОбработкаЗаказов.Добавить();
	Движение.Период = Дата;
	Движение.Контрагент = Контрагент;
	Движение.Заказ = Ссылка;
	Движение.Договор = Договор;
	Движение.СуммаЗаказа = СуммаДокумента;

	Для Каждого ТекСтрокаТовары Из Товары Цикл
		
		Движение = Движения.Продажи.Добавить();
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
		Движение.Сумма = ТекСтрокаТовары.Сумма;

// ++Красова Задача № , 12.02.2025		
		ДвижениеЗадолженность = Движения.ЗадолженностьПокупателей.Добавить();
		ДвижениеЗадолженность.ВидДвижения = ВидДвиженияНакопления.Приход;
		ДвижениеЗадолженность.Период = Дата;
		ДвижениеЗадолженность.Контрагент = Контрагент;
		ДвижениеЗадолженность.Договор = Договор;
		ДвижениеЗадолженность.Номенклатура = ТекСтрокаТовары.Номенклатура;
		ДвижениеЗадолженность.Сумма = ТекСтрокаТовары.Сумма;
// --
	КонецЦикла;
	
	Для Каждого ТекСтрокаУслуги Из Услуги Цикл
		Движение = Движения.Продажи.Добавить();
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Номенклатура = ТекСтрокаУслуги.Номенклатура;
		Движение.Сумма = ТекСтрокаУслуги.Сумма; 
		
// ++Красова Задача № , 12.02.2025
		ДвижениеЗадолженность = Движения.ЗадолженностьПокупателей.Добавить();
		ДвижениеЗадолженность.ВидДвижения = ВидДвиженияНакопления.Приход;
		ДвижениеЗадолженность.Период = Дата;
		ДвижениеЗадолженность.Контрагент = Контрагент;
		ДвижениеЗадолженность.Договор = Договор;
		ДвижениеЗадолженность.Номенклатура = ТекСтрокаУслуги.Номенклатура;
		ДвижениеЗадолженность.Сумма = ТекСтрокаУслуги.Сумма;
// --			
	КонецЦикла;
	

КонецПроцедуры

#КонецОбласти

#КонецЕсли
