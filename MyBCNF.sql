DROP DATABASE IF EXISTS mydb;
CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;
SET profiling = 1;

CREATE TABLE Clients (
  client_id INT PRIMARY KEY,
  name VARCHAR(255),
  phone_number VARCHAR(20),
  address VARCHAR(255)
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  client_id INT,
  service_id INT,
  cleaning_id INT,
  payment_id INT,
  creation_date DATETIME,
  completion_date DATETIME,
  FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

CREATE TABLE Cleaning (
  cleaning_id INT,
  order_id INT,
  cleaning_type VARCHAR(255),
  duration TIME,
  cost FLOAT,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  PRIMARY KEY (cleaning_id, order_id)
);

CREATE TABLE Payment (
  payment_id INT,
  order_id INT,
  amount FLOAT,
  purchase_date DATE,
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  PRIMARY KEY(payment_id, order_id)
);

CREATE TABLE Cleaning_Service (
  service_id INT,
  consumables_id INT,
  employee_id INT,
  order_id INT,
  name VARCHAR(255),
  phone_number VARCHAR(20),
  location VARCHAR(255),
  website VARCHAR(255),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  PRIMARY KEY (service_id, order_id)
);

CREATE TABLE Employee (
  employee_id INT,
  service_id INT,
  name VARCHAR(255),
  cleaning_skills VARCHAR(255),
  phone_number VARCHAR(20),
  salary FLOAT,
  FOREIGN KEY (service_id) REFERENCES Cleaning_Service(service_id),
  PRIMARY KEY (employee_id, service_id)
);

CREATE TABLE Consumables (
  consumables_id INT,
  supplier_id INT,
  service_id INT,
  category INT,
  name VARCHAR(255),
  stock_quantity INT,
  avg_price FLOAT,
  FOREIGN KEY (service_id) REFERENCES Cleaning_Service(service_id),
  PRIMARY KEY (consumables_id, service_id)
);

CREATE TABLE Supplier (
  supplier_id INT,
  consumables_id INT,
  name VARCHAR(255),
  phone_number VARCHAR(20),
  address VARCHAR(255),
  delivery_time DATETIME,
  PRIMARY KEY (supplier_id, consumables_id)
);
#создали таблицы

-- Пример добавления клиентов
INSERT INTO Clients (client_id, name, phone_number, address)
VALUES
  (1, 'Иванов Иван', '+79123456789', 'ул. Первая, д. 1'),
  (2, 'Петров Петр', '+79234567890', 'пр. Второй, д. 2'),
  (3, 'Сидорова Сидора', '+79345678901', 'ул. Третья, д. 3'),
  (4, 'Никитин Никита', '+79456789012', 'пер. Четвертый, д. 4'),
  (5, 'Мария Маринова', '+79567890123', 'ул. Пятая, д. 5'),
  (6, 'Анна Петрова', '+79678901234', 'пр. Шестой, д. 6'),
  (7, 'Владимир Сидоров', '+79789012345', 'ул. Седьмая, д. 7'),
  (8, 'Ольга Иванова', '+79890123456', 'пер. Восьмой, д. 8'),
  (9, 'Никита Петров', '+79901234567', 'ул. Девятая, д. 9'),
  (10, 'Светлана Сидорова', '+79912345678', 'пр. Десятый, д. 10');

-- Пример добавления заказов
INSERT INTO Orders (order_id, client_id, service_id, cleaning_id, payment_id, creation_date, completion_date)
VALUES
  (1, 1, 1, 1, 1, '2023-01-01 10:00:00', '2023-01-01 14:00:00'),
  (2, 2, 2, 2, 2, '2023-01-02 12:00:00', '2023-01-02 16:00:00'),
  (3, 3, 3, 3, 3, '2023-01-03 14:00:00', '2023-01-03 18:00:00'),
  (4, 4, 4, 4, 4, '2023-01-04 16:00:00', '2023-01-04 20:00:00'),
  (5, 5, 5, 5, 5, '2023-01-05 18:00:00', '2023-01-05 22:00:00'),
  (6, 6, 1, 6, 6, '2023-01-06 20:00:00', '2023-01-06 23:00:00'),
  (7, 7, 2, 7, 7, '2023-01-07 09:00:00', '2023-01-07 12:00:00'),
  (8, 8, 3, 8, 8, '2023-01-08 15:00:00', '2023-01-08 18:00:00'),
  (9, 9, 4, 9, 9, '2023-01-09 11:00:00', '2023-01-09 15:00:00'),
  (10, 10, 5, 10, 10, '2023-01-10 13:00:00', '2023-01-10 17:00:00'),
  (11, 1, 1, 11, 11, '2023-02-01 10:00:00', '2023-02-01 14:00:00'),
  (12, 1, 1, 12, 12, '2023-02-02 12:00:00', '2023-02-02 16:00:00'),
  (13, 2, 2, 13, 13, '2023-02-04 16:00:00', '2023-02-04 20:00:00'),
  (14, 2, 2, 14, 14, '2023-02-06 20:00:00', '2023-02-06 23:00:00'),
  (15, 1, 1, 15, 15, '2023-02-08 15:00:00', '2023-02-08 18:00:00'),
  (16, 3, 3, 16, 16, '2023-02-08 15:00:00', '2023-02-08 18:00:00');

-- Пример добавления уборок
INSERT INTO Cleaning (cleaning_id, order_id, cleaning_type, duration, cost)
VALUES
  (1, 1, 'Генеральная уборка', '03:00:00', 80.00),
  (2, 2, 'Мытье фасада', '05:00:00', 120.00),
  (3, 3, 'Специализированная уборка', '02:30:00', 60.00),
  (4, 4, 'Уборка бассейна', '04:00:00', 90.00),
  (5, 5, 'Очистка вентиляции', '06:00:00', 150.00),
  (6, 6, 'Регулярная уборка', '02:00:00', 50.00),
  (7, 7, 'Глубокая уборка', '03:30:00', 100.00),
  (8, 8, 'Экспресс-уборка', '05:30:00', 130.00),
  (9, 9, 'Стандартная уборка', '03:00:00', 70.00),
  (10, 10, 'Чистка канализации', '04:30:00', 120.00);

-- Пример добавления оплат
INSERT INTO Payment (payment_id, order_id, amount, purchase_date)
VALUES
  (1, 1, 150.01, '2023-01-01'),
  (2, 2, 160.02, '2023-01-02'),
  (3, 3, 180.03, '2023-01-03'),
  (4, 4, 200.04, '2023-01-04'),
  (5, 5, 220.05, '2023-01-05'),
  (6, 6, 50.00, '2023-01-06'),
  (7, 7, 100.00, '2023-01-07'),
  (8, 8, 130.00, '2023-01-08'),
  (9, 9, 70.00, '2023-01-09'),
  (10, 10, 120.00, '2023-01-10');

-- Пример добавления клининг сервисов
INSERT INTO Cleaning_Service (service_id, consumables_id, employee_id, order_id, name, phone_number, location, website)
VALUES
  (1, 1, 1, 1, 'Эко-Чисто', '+79005556677', 'ул. Уборочная, д. 10', 'http://cleaning-service1.ru'),
  (2, 2, 2, 2, 'Чистый Дом', '+79006667788', 'пр. Блеск, д. 20', 'http://cleaning-service2.ru'),
  (3, 3, 3, 3, 'Гланс-Сервис', '+79007778899', 'ул. Профи, д. 30', 'http://cleaning-service3.ru'),
  (4, 4, 4, 4, 'Профи-Мойка', '+79008889900', 'пер. Стандартный, д. 40', 'http://cleaning-service4.ru'),
  (5, 5, 5, 5, 'Бриллиант-Уборка', '+79009990011', 'ул. Уютовая, д. 50', 'http://cleaning-service5.ru'),
  (6, 6, 1, 6, 'Чисто и Светло', '+79001010122', 'пр. Светлый, д. 60', 'http://cleaning-service6.ru'),
  (7, 7, 2, 7, 'Экспресс-Чистка', '+79001111233', 'ул. Экспрессивная, д. 70', 'http://cleaning-service7.ru'),
  (8, 8, 3, 8, 'Супер-Уборка', '+79002222344', 'пер. Суперский, д. 80', 'http://cleaning-service8.ru'),
  (9, 9, 4, 9, 'Уборка-Профи', '+79003333455', 'ул. Профессиональная, д. 90', 'http://cleaning-service9.ru'),
  (10, 10, 5, 10, 'Бригада-Уборщиков', '+79004444566', 'пр. Бригадный, д. 100', 'http://cleaning-service10.ru'),
  (1, 1, 1, 11, 'Эко-Чисто', '+79005556677', 'ул. Уборочная, д. 10', 'http://cleaning-service1.ru'),
  (1, 1, 1, 12, 'Эко-Чисто', '+79005556677', 'ул. Уборочная, д. 10', 'http://cleaning-service1.ru'),
  (2, 2, 2, 13, 'Чистый Дом', '+79006667788', 'пр. Блеск, д. 20', 'http://cleaning-service2.ru'),
  (3, 3, 3, 14, 'Гланс-Сервис', '+79007778899', 'ул. Профи, д. 30', 'http://cleaning-service3.ru'),
  (10, 10, 5, 15, 'Профи-Мойка', '+79004444566', 'пр. Бригадный, д. 100', 'http://cleaning-service10.ru');
  
-- Пример добавления сотрудников
INSERT INTO Employee (employee_id, service_id, name, cleaning_skills, phone_number, salary)
VALUES
  (1, 1, 'Анна Уборова', 'Регулярная уборка', '+79005550001', 25.00),
  (2, 2, 'Борис Глубоков', 'Глубокая уборка', '+79006660002', 30.00),
  (3, 3, 'Светлана Профессионалова', 'Экспресс-уборка', '+79007770003', 20.00),
  (4, 4, 'Артур Оперативников', 'Глубокая уборка', '+79007770004', 20.00),
  (5, 5, 'Артемий Чистолюбов', 'Глубокая уборка', '+79007770005', 40.00),
  (6, 6, 'Анна Метелкина', 'Экспресс-уборка', '+79007770006', 10.00),
  (7, 7, 'Дмитрий Пылесосов', 'Экспресс-уборка', '+79007770007', 15.00),
  (8, 8, 'Екатерина Шваброва', 'Регулярная уборка', '+79007770008', 45.00),
  (9, 9, 'Александр Мусорин', 'Регулярная уборка', '+79007770009', 35.00),
  (10, 10, 'Ольга Пыльникова', 'Регулярная уборка', '+79007770010', 10.00);
  
-- Пример добавления расходных материалов
INSERT INTO Consumables (consumables_id, supplier_id, service_id, category, name, stock_quantity, avg_price)
VALUES
  (1, 1, 1, 1, 'Моющее средство', 100, 8.00),
  (2, 2, 2, 2, 'Салфетки для уборки', 50, 5.00),
  (3, 3, 3, 1, 'Чистящий порошок', 75, 10.00),
  (4, 4, 3, 4, 'Сливной механизм', 10, 100.00),
  (6, 4, 4, 1, 'Ведро', 100, 12.00),
  (7, 4, 5, 1, 'Швабра', 100, 13.00),
  (8, 5, 9, 3, 'Химическое средство', 15, 75.00),
  (9, 4, 1, 1, 'Контейнер', 65, 20.00),
  (10, 4, 2, 1, 'Тележка', 20, 80.00);


-- Пример добавления поставщиков
INSERT INTO Supplier (supplier_id, consumables_id, name, phone_number, address, delivery_time)
VALUES
  (1, 1, 'Поставщик Моющих Средств', '+79001112233', 'ул. Чистая, д. 1', '2023-02-01'),
  (2, 2, 'Поставщик Салфеток', '+79002223344', 'пр. Белый, д. 2', '2023-02-05'),
  (3, 3, 'Поставщик Чистящего Порошка', '+79003334455', 'ул. Зеленая, д. 3', '2023-02-10'),
  (4, 4,'Универсальный Поставщик', '+79003434325', 'ул. Добрая, д. 60', '2023-02-10'),
  (4, 5,'Универсальный Поставщик', '+79003434325', 'ул. Добрая, д. 60', '2023-02-10'),
  (4, 6,'Универсальный Поставщик', '+79003434325', 'ул. Добрая, д. 60', '2023-02-10'),
  (4, 7,'Универсальный Поставщик', '+79003434325', 'ул. Добрая, д. 60', '2023-02-10'),
  (4, 9,'Универсальный Поставщик', '+79003434325', 'ул. Добрая, д. 60', '2023-02-10'),
  (4, 10,'Универсальный Поставщик', '+79003434325', 'ул. Добрая, д. 60', '2023-02-10'),
  (5, 8, 'Химический Завод', '+79006665533', 'ул. Люлькова, д. 7', '2023-02-15');


SHOW PROFILES;
