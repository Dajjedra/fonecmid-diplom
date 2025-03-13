#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбновитьПланировщикНаСервере();
	
КонецПроцедуры 

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_ОбслуживаниеКлиента" Тогда
		 ОбновитьПланировщикНаСервере();
	 КонецЕсли;
	 
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьПланировщик(Команда)
	ОбновитьПланировщикНаСервере();		
КонецПроцедуры
	
&НаСервере
Процедура ОбновитьПланировщикНаСервере()
	
	НачалоПериода = НачалоНедели(ТекущаяДатаСеанса());
	КонецПериода = КонецНедели(ТекущаяДатаСеанса());
	Планировщик.ТекущиеПериодыОтображения.Добавить(НачалоПериода, КонецПериода);
	
	Планировщик.ОтображениеВремениЭлементов = ОтображениеВремениЭлементовПланировщика.ВремяНачалаИКонца;
	Планировщик.ПоведениеЭлементовПриНедостаткеМеста = ПоведениеЭлементовПланировщикаПриНедостаткеМеста.ОтображатьВсеЭлементы;
	
	Планировщик.ЦветФона = WebЦвета.Серебряный;
	Планировщик.ЦветТекста = WebЦвета.Черный;
	
	ИзмеренияПланировщика = Планировщик.Измерения; 
	ИзмеренияПланировщика.Очистить();
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_ФизическиеЛица.Ссылка КАК Ссылка,
		|	ВКМ_ФизическиеЛица.Представление КАК Представление
		|ИЗ
		|	Справочник.ВКМ_ФизическиеЛица КАК ВКМ_ФизическиеЛица";
	
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать(); 
	
	ИзмеренияСпециалисты = ИзмеренияПланировщика.Добавить("Специалисты");

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		НовыйСпециалист = ИзмеренияСпециалисты.Элементы.Добавить(ВыборкаДетальныеЗаписи.Ссылка);
		НовыйСпециалист.Текст = ВыборкаДетальныеЗаписи.Представление; 
		
	КонецЦикла;
	
	Планировщик.Элементы.Очистить();

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ВКМ_ОбслуживаниеКлиента.ДатаПроведенияРабот КАК ДатаПроведенияРабот,
		|	ВКМ_ОбслуживаниеКлиента.ВремяНачалаРабот КАК ВремяНачалаРабот,
		|	ВКМ_ОбслуживаниеКлиента.ВремяОкончанияРабот КАК ВремяОкончанияРабот,
		|	ВКМ_ОбслуживаниеКлиента.Ссылка КАК Ссылка,
		|	ВКМ_ОбслуживаниеКлиента.Специалист КАК Специалист,
		|	ВКМ_ОбслуживаниеКлиента.Клиент КАК Клиент
		|ИЗ
		|	Документ.ВКМ_ОбслуживаниеКлиента КАК ВКМ_ОбслуживаниеКлиента";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		СтрокаДатаНачала = Формат(Выборка.ДатаПроведенияРабот,"ДФ=dd.MM.yyyy") + " " + Формат(Выборка.ВремяНачалаРабот, "ДЛФ=T");
		НачалоРабот = Дата(СтрокаДатаНачала);
		
		СтрокаДатаОкончания = Формат(Выборка.ДатаПроведенияРабот,"ДФ=dd.MM.yyyy") + " " + Формат(Выборка.ВремяОкончанияРабот, "ДЛФ=T");
		ОкончаниеРабот = Дата(СтрокаДатаОкончания); 
		
		СоответствиеЗначений = Новый Соответствие;
		СоответствиеЗначений.Вставить("Специалисты",Выборка.Специалист);
		
		ЭлементыПланировщика = Планировщик.Элементы.Добавить(НачалоРабот, ОкончаниеРабот);
		ЭлементыПланировщика.ЗначенияИзмерений = Новый ФиксированноеСоответствие(СоответствиеЗначений);
		ЭлементыПланировщика.ЦветФона = WebЦвета.НейтральноБирюзовый;

		ЭлементыПланировщика.Значение = Выборка.Ссылка;
		ЭлементыПланировщика.Текст = Выборка.Клиент;
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПланировщикПередСозданием(Элемент, Начало, Конец, ЗначенияИзмерений, Текст, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь; 
	
	Специалист = ЗначенияИзмерений.Получить("Специалисты");
	
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("Дата", ТекущаяДата());
	ЗначенияЗаполнения.Вставить("ДатаПроведенияРабот", НачалоДня(Начало));
	ЗначенияЗаполнения.Вставить("ВремяНачалаРабот", Начало);
	ЗначенияЗаполнения.Вставить("ВремяОкончанияРабот", Конец); 
	ЗначенияЗаполнения.Вставить("Специалист", Специалист);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	
	ОткрытьФорму("Документ.ВКМ_ОбслуживаниеКлиента.Форма.ФормаДокумента", ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти
#КонецЕсли