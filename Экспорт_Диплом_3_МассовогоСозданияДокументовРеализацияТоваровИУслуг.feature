﻿#language: ru

@tree
@exportscenarios
@ТипШага: Диплом. Работа с документами
@Описание: Сценарий массового создания документов Реализация товаров и услуг от имени Бухгалтера
@ПримерИспользования: И Я проверяю корректность массового создания документов Реализация товаров и услуг

Функционал: Массовое создание документов Реализация товаров и услуг от имени Бухгалтера

Как Студент я хочу
Автоматизировать процесс массового создания документов Реализация товаров и услуг от имени Бухгалтера 
чтобы сократить время на ручное регрессионное тестирование и оперативно обнаруживать ошибки в данном процессе   

Сценарий: Я проверяю корректность массового создания документов Реализация товаров и услуг
	И Я подключаю клиент тестирования "Сценарий от бухгалтера" из таблицы клиентов тестирования
	И я закрываю все окна клиентского приложения
	И В командном интерфейсе я выбираю "Обслуживание клиентов" "Массовое создание актов"
	Тогда открылось окно "Массовое создание актов"
	И я нажимаю кнопку выбора у поля с именем 'Период'
	Тогда открылось окно "Выберите период"
	И я выполняю код встроенного языка на сервере с передачей переменных
	"""bsl
	DateBegin = НачалоМесяца(ТекущаяДата());
	Контекст.Вставить("DateBegin", DateBegin);
	"""
	И в поле с именем 'DateBegin' я ввожу текст "$DateBegin$"
	И я выполняю код встроенного языка на сервере с передачей переменных
	"""bsl
	DateEnd = КонецМесяца(ТекущаяДата());
	Контекст.Вставить("DateEnd", DateEnd);
	"""
	И в поле с именем 'DateEnd'я ввожу текст "$DateEnd$"
	И я запоминаю значение поля с именем 'PeriodValue' как 'ПериодДокумента'
	И я нажимаю на кнопку с именем 'Select'
	Тогда открылось окно "Массовое создание актов"
	И в таблице 'Договоры' я нажимаю на кнопку с именем 'ФормаЗаполнить'




