Инструкция по проведению автоматизированного сценарного тестирования с помощью Vanessa Automation.
1.	Скачайте Vanessa Automation из официального гит-репозитория.
2.	Создайте информационную базу, которая будет использоваться в качестве «менеджера тестирования».
3.	У информационной базы пропишите параметры запуска: /TESTMANAGER
4.	Запустите настроенную информационную базу в режиме «1С Предприятие».
5.	Перейдите на вкладку: «Клиенты тестирования» и добавьте три базы как указано на картинке ниже, где:
    1.	Сценарий от менеджера: File="Путь к вашей базе";   /N"Менеджер"
    2.	Сценарий от специалиста: File="Путь к вашей базе";   /N"Специалист"
    3.	Сценарий от бухгалтера: File="Путь к вашей базе";   /N"Бухгалтер"
       
![изображение](https://github.com/user-attachments/assets/1975e625-da8f-4f0b-b5a4-2f0c6c8750d6)

6.	Запустите сценарий из файла Экспорт_Общий.feature на выполнение нажав в верхней панели инструментов на пиктограмму.
    Сценарии Экспорт_Диплом_1_ОбслуживаниеКлиента.feature, Экспорт_Диплом_2_ЗакрытиеОбслуживанийОтИмениСпециалиста.feature,
    Экспорт_Диплом_3_МассовогоСозданияДокументовРеализацияТоваровИУслуг, Экспорт_Диплом_4_ФормированиеОтчётаАнализВыставленныхАктов.feature являются экспортными.
 ![изображение](https://github.com/user-attachments/assets/59bfdcdd-67ef-4207-bf7e-f0dd2ddf79e5)

8.	В случае успеха все строчки сценариев будут подсвечены зеленым цветом.
 
![изображение](https://github.com/user-attachments/assets/db611bb0-823a-490f-8a1d-d9d22f88a5fd)

