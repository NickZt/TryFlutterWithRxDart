# nbu_currency

## TryFlutterWithRxDart


## Хочу создать приложение для отображения курса валют.

### Зачем

* изучить  dart & flutter
* сравнить разработку на dart & flutter с Java Android 
* попробовать разные виджеты и способы построения программы
* запустить на iOS и Android


### Функциональность:

приложение раз в час в фоновом режиме синхронизирует внутренние данные с данными, расположенными по адресу: https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange- 
приложение будет хранить внутренние данные в БД (sqllite).
Структура бд и маппинг на исходный xml:
Таблица валют:
currency{        currency_id (r030)        name (txt)        code (cc)}

Таблица курсов:
exchange{        currency_id (внешний ключ на таблицу currency) (r030)        exchange_date(exchangedate)        exchange_rate(rate)}

приложение будет уметь отображать данные в портретной и альбомной ориентации. 


В портретной ориентации будет два экрана (список валют и детализация). В списке валют каждый элемент содержит название и код.  При нажатии на элемент списка, должен отобразиться экран детализации,который содержит дату, текущий курс, цифровой код (currency_id).

В альбомной ориентации 1/3 экрана от левого края занимает список валют.  При выборе валюты, на оставшейся части экрана, отображается детализация, таким же образом, как и в портретной.

Добавить возможность выбора даты для отображения курсов. предложенная схема БД позволяет хранить данные курсов по датам.

Добавить возможность сохранения в базу только изменившихся курсов

### в планах -  развернуть в Интернете как сайт, ну и написать статью об этом.


## I want to create an application to display exchange rates.

### Goals

* learn dart & flutter
* evaluate dart & flutter vs my Android experience
* try out different architectures, widgets, etc.
* deploy on both iOS and Android

### Functionality:

the application once per hour in the background to synchronize internal data with the data located at: https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange-
The application will store internal data in a database (sqllite).
DB structure and mapping to source xml:
Currency table:
currency {currency_id (r030) name (txt) code (cc)}

Exchange rate Table:
exchange {currency_id (foreign key to currency table) (r030) exchange_date (exchangedate) exchange_rate (rate)}

The application will be able to display data in portrait and landscape orientation.


In portrait orientation there will be two screens (a list of currencies and detail). In the list of currencies, each item contains a name and code. When you click on the list item, a detail screen should appear that contains the date, current rate, digital code (currency_id).

In landscape orientation, 1/3 of the screen from the left edge takes a list of currencies. When you select a currency, the rest of the screen displays the detail in the same way as in portrait.

Add the ability to select dates to display courses. The proposed database scheme allows you to store exchange rates data by date.
Add the ability to save to the database only the changed exchange rate.

### Stretch Goals : deploy on the Internet as a site, well, write an article about it.



For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
