DROP DATABASE IF EXISTS mydb;
CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;
SET profiling = 1;

-- Hubs
CREATE TABLE ClientHub (
    client_id INT PRIMARY KEY
);

CREATE TABLE OrderHub (
    order_id INT PRIMARY KEY,
    client_id INT REFERENCES ClientHub(client_id),
    service_id INT,
    cleaning_id INT,
    payment_id INT
);

CREATE TABLE CleaningHub (
    cleaning_id INT PRIMARY KEY,
    order_id INT REFERENCES OrderHub(order_id)
);

CREATE TABLE PaymentHub (
    payment_id INT PRIMARY KEY,
    order_id INT REFERENCES OrderHub(order_id)
);

CREATE TABLE CleaningServiceHub (
    service_id INT PRIMARY KEY,
    consumables_id INT,
    employee_id INT
);

CREATE TABLE EmployeeHub (
    employee_id INT PRIMARY KEY,
    service_id INT
);

CREATE TABLE ConsumablesHub (
    consumables_id INT PRIMARY KEY,
    service_id INT
);

-- Links
CREATE TABLE ClientOrderLink (
    order_id INT REFERENCES OrderHub(order_id),
    client_id INT REFERENCES ClientHub(client_id),
    PRIMARY KEY (order_id, client_id)
);

CREATE TABLE OrderPaymentLink (
    order_id INT REFERENCES OrderHub(order_id),
    payment_id INT REFERENCES PaymentHub(payment_id),
    PRIMARY KEY (order_id, payment_id)
);

CREATE TABLE OrderCleaningLink (
    order_id INT REFERENCES OrderHub(order_id),
    cleaning_id INT REFERENCES CleaningHub(cleaning_id),
    PRIMARY KEY (order_id, cleaning_id)
);

CREATE TABLE OrderCleaningServiceLink (
    order_id INT REFERENCES OrderHub(order_id),
    service_id INT REFERENCES CleaningServiceHub(service_id),
    PRIMARY KEY (order_id, service_id)
);

CREATE TABLE CleaningServiceConsumablesLink (
    service_id INT REFERENCES CleaningServiceHub(service_id),
    consumables_id INT REFERENCES ConsumablesHub(consumables_id),
    PRIMARY KEY (service_id, consumables_id)
);

CREATE TABLE CleaningServiceEmployeeLink (
    service_id INT REFERENCES CleaningServiceHub(service_id),
    employee_id INT REFERENCES EmployeeHub(employee_id),
    PRIMARY KEY (service_id, employee_id)
);

-- Satellites
CREATE TABLE ClientSatellite (
    client_id INT REFERENCES ClientHub(client_id),
    name VARCHAR(255),
    phone_number VARCHAR(20),
    address VARCHAR(255),
    PRIMARY KEY (client_id)
);

CREATE TABLE OrderSatellite (
    order_id INT REFERENCES OrderHub(order_id),
    creation_date DATE,
    compilation_date DATE,
    PRIMARY KEY (order_id)
);

CREATE TABLE CleaningSatellite (
    cleaning_id INT REFERENCES CleaningHub(cleaning_id),
    cleaning_type VARCHAR(255),
    duration INT,
    cost DECIMAL(10, 2),
    PRIMARY KEY (cleaning_id)
);

CREATE TABLE PaymentSatellite (
    payment_id INT REFERENCES PaymentHub(payment_id),
    amount DECIMAL(10, 2),
    purchase_date DATE,
    PRIMARY KEY (payment_id)
);

CREATE TABLE CleaningServiceSatellite (
    service_id INT REFERENCES CleaningServiceHub(service_id),
    name VARCHAR(255),
    phone_number VARCHAR(20),
    location VARCHAR(255),
    website VARCHAR(255),
    PRIMARY KEY (service_id)
);

CREATE TABLE ConsumablesSatellite (
    consumables_id INT REFERENCES ConsumablesHub(consumables_id),
    category VARCHAR(255),
    name VARCHAR(255),
    stock_quantity INT,
    average_price DECIMAL(10, 2),
    PRIMARY KEY (consumables_id)
);

CREATE TABLE EmployeeSatellite (
    employee_id INT REFERENCES EmployeeHub(employee_id),
    name VARCHAR(255),
    cleaning_skills VARCHAR(255),
    phone_number VARCHAR(20),
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_id)
);
-- Примеры данных для ClientHub
INSERT INTO ClientHub (client_id) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Примеры данных для OrderHub
INSERT INTO OrderHub (order_id, client_id, service_id, cleaning_id, payment_id) VALUES
(101, 1, 201, 301, 401),
(102, 2, 202, 302, 402),
(103, 3, 203, 303, 403),
(104, 4, 204, 304, 404),
(105, 5, 205, 305, 405),
(106, 6, 206, 306, 406),
(107, 7, 207, 307, 407),
(108, 8, 208, 308, 408),
(109, 9, 209, 309, 409),
(110, 10, 210, 310, 410),
(111, 1, 201, 311, 411),
(112, 2, 202, 312, 412),
(113, 3, 203, 313, 413),
(114, 4, 203, 314, 414),
(115, 5, 205, 315, 415),
(116, 1, 201, 316, 416),
(117, 1, 202, 317, 417),
(118, 1, 203, 318, 418),
(119, 2, 204, 319, 419),
(120, 2, 205, 320, 420),
(121, 3, 206, 321, 421);

-- Примеры данных для CleaningHub
INSERT INTO CleaningHub (cleaning_id, order_id) VALUES
(301, 101),
(302, 102),
(303, 103),
(304, 104),
(305, 105),
(306, 106),
(307, 107),
(308, 108),
(309, 109),
(310, 110);

-- Примеры данных для PaymentHub
INSERT INTO PaymentHub (payment_id, order_id) VALUES
(401, 101),
(402, 102),
(403, 103),
(404, 104),
(405, 105),
(406, 106),
(407, 107),
(408, 108),
(409, 109),
(410, 110);

-- Примеры данных для CleaningServiceHub
INSERT INTO CleaningServiceHub (service_id, consumables_id, employee_id) VALUES
(201, 501, 601),
(202, 502, 602),
(203, 503, 603),
(204, 504, 604),
(205, 505, 605),
(206, 506, 606),
(207, 507, 607),
(208, 508, 608),
(209, 509, 609),
(210, 510, 610);

-- Примеры данных для EmployeeHub
INSERT INTO EmployeeHub (employee_id, service_id) VALUES
(601, 201),
(602, 202),
(603, 203),
(604, 204),
(605, 205),
(606, 206),
(607, 207),
(608, 208),
(609, 209),
(610, 210);

-- Примеры данных для ConsumablesHub
INSERT INTO ConsumablesHub (consumables_id, service_id) VALUES
(501, 201),
(502, 202),
(503, 203),
(504, 204),
(505, 205),
(506, 206),
(507, 207),
(508, 208),
(509, 209),
(510, 210);

-- Примеры данных для Client Order Link
INSERT INTO ClientOrderLink (order_id, client_id) VALUES
(101, 1),
(102, 2),
(103, 3),
(104, 4),
(105, 5),
(106, 6),
(107, 7),
(108, 8),
(109, 9),
(110, 10),
(116, 1),
(117, 1),
(118, 1),
(119, 2),
(120, 2),
(121, 3);

-- Примеры данных для Order Payment Link
INSERT INTO OrderPaymentLink (order_id, payment_id) VALUES
(101, 401),
(102, 402),
(103, 403),
(104, 404),
(105, 405),
(106, 406),
(107, 407),
(108, 408),
(109, 409),
(110, 410),
(111, 411),
(112, 412),
(113, 413),
(114, 414),
(115, 415);

-- Примеры данных для Order Cleaning Link
INSERT INTO OrderCleaningLink (order_id, cleaning_id) VALUES
(101, 301),
(102, 302),
(103, 303),
(104, 304),
(105, 305),
(106, 306),
(107, 307),
(108, 308),
(109, 309),
(110, 310),
(111, 311),
(112, 312),
(113, 313),
(114, 314),
(115, 315);

-- Примеры данных для Order Cleaning Service Link
INSERT INTO OrderCleaningServiceLink (order_id, service_id) VALUES
(101, 201),
(102, 202),
(103, 203),
(104, 204),
(105, 205),
(106, 206),
(107, 207),
(108, 208),
(109, 209),
(110, 210),
(111, 201),
(112, 202),
(113, 203),
(114, 203),
(115, 205);

-- Примеры данных для Cleaning Service Consumables Link
INSERT INTO CleaningServiceConsumablesLink (service_id, consumables_id) VALUES
(201, 501),
(202, 502),
(203, 503),
(204, 504),
(205, 505),
(206, 506),
(207, 507),
(208, 508),
(209, 509),
(210, 510);

-- Примеры данных для Cleaning Service Employee Link
INSERT INTO CleaningServiceEmployeeLink (service_id, employee_id) VALUES
(201, 601),
(202, 602),
(203, 603),
(204, 604),
(205, 605),
(206, 606),
(207, 607),
(208, 608),
(209, 609),
(210, 610);

-- Примеры данных для ClientSatellite
INSERT INTO ClientSatellite (client_id, name, phone_number, address) VALUES
(1, 'Иванов Иван', '123-456-7890', 'Улица Пушкина, дом Колотушкина'),
(2, 'Петров Петр', '987-654-3210', 'Переулок Гоголя, дом Чехова'),
(3, 'Сидорова Сидора', '555-123-4567', 'Проспект Толстого, дом Лермонтова'),
(4, 'Никитин Никита', '111-222-3333', 'Улица Чехова, дом Толстого'),
(5, 'Мария Маринова', '444-555-6666', 'Площадь Лермонтова, дом Гоголя'),
(6, 'Анна Андреева', '777-888-9999', 'Улица Гоголя, дом Пушкина'),
(7, 'Дмитрий Дмитриев', '999-111-2222', 'Площадь Лермонтова, дом Чехова'),
(8, 'Елена Еленова', '666-444-3333', 'Улица Толстого, дом Колотушкина'),
(9, 'Сергей Сергеев', '333-999-1111', 'Переулок Чехова, дом Гоголя'),
(10, 'Ольга Ольгова', '222-777-5555', 'Проспект Лермонтова, дом Пушкина');

-- Примеры данных для OrderSatellite
INSERT INTO OrderSatellite (order_id, creation_date, compilation_date) VALUES
(101, '2023-01-01', '2023-01-05'),
(102, '2023-02-01', '2023-02-10'),
(103, '2023-03-01', '2023-03-15'),
(104, '2023-04-01', '2023-04-10'),
(105, '2023-05-01', '2023-05-15'),
(106, '2023-06-01', '2023-06-10'),
(107, '2023-07-01', '2023-07-15'),
(108, '2023-08-01', '2023-08-10'),
(109, '2023-09-01', '2023-09-15'),
(110, '2023-10-01', '2023-10-10'),
(111, '2023-04-01', '2023-04-10'),
(112, '2023-04-02', '2023-04-11'),
(113, '2023-04-03', '2023-04-12'),
(114, '2023-04-04', '2023-04-13'),
(115, '2023-04-05', '2023-04-14');

-- Примеры данных для CleaningSatellite
INSERT INTO CleaningSatellite (cleaning_id, cleaning_type, duration, cost) VALUES
(301, 'Генеральная уборка', 120, 150.00),
(302, 'Мытье окон', 60, 75.00),
(303, 'Полировка мебели', 90, 120.00),
(304, 'Уборка ковров', 75, 100.00),
(305, 'Очистка вентиляции', 180, 220.00),
(306, 'Мытье посуды', 45, 50.00),
(307, 'Уборка бассейна', 150, 200.00),
(308, 'Мытье фасада', 120, 160.00),
(309, 'Чистка канализации', 60, 80.00),
(310, 'Дезинфекция помещения', 90, 110.00),
(311, 'Обычная уборка', 90, 120.00),
(312, 'Глубокая уборка', 120, 150.00),
(313, 'Специализированная уборка', 150, 180.00),
(314, 'Стандартная уборка', 100, 130.00),
(315, 'Экспресс-уборка', 60, 90.00);

-- Примеры данных для PaymentSatellite
INSERT INTO PaymentSatellite (payment_id, amount, purchase_date) VALUES
(401, 150.01, '2023-01-05'),
(402, 75.00, '2023-02-10'),
(403, 120.00, '2023-03-15'),
(404, 100.00, '2023-04-10'),
(405, 220.05, '2023-05-15'),
(406, 50.00, '2023-06-10'),
(407, 200.04, '2023-07-15'),
(408, 160.02, '2023-08-10'),
(409, 80.00, '2023-09-15'),
(410, 110.00, '2023-10-10'),
(411, 120.00, '2023-04-01'),
(412, 150.00, '2023-04-02'),
(413, 180.03, '2023-04-03'),
(414, 130.00, '2023-04-04'),
(415, 90.00, '2023-04-05');

-- Примеры данных для CleaningServiceSatellite
INSERT INTO CleaningServiceSatellite (service_id, name, phone_number, location, website) VALUES
(201, 'Чистый Дом', '123-456-789', 'Улица Уборки, дом Дезинфекции', 'www.cleanhouse.com'),
(202, 'Гланс-Сервис', '987-654-321', 'Проспект Полировки, дом Мытья', 'www.glance-service.com'),
(203, 'Эко-Чисто', '555-123-456', 'Переулок Озона, дом Экологии', 'www.ecoclean.com'),
(204, 'Бриллиант-Уборка', '111-222-333', 'Улица Чистоты, дом Блеска', 'www.brilliantcleaning.com'),
(205, 'Профи-Мойка', '444-555-666', 'Площадь Мытья, дом Отличной Мойки', 'www.profimoyka.com'),
(206, 'Мебельная Чистка', '777-888-999', 'Улица Полировки, дом Лака', 'www.furniturecleaning.com'),
(207, 'Бассейн-Уборка', '999-111-222', 'Переулок Чистой Воды, дом Бассейна', 'www.poolcleaning.com'),
(208, 'Фасад-Чисто', '666-444-333', 'Площадь Фасада, дом Сияния', 'www.facadeclean.com'),
(209, 'Канализационные Службы', '333-999-111', 'Улица Дренажа, дом Промывки', 'www.draincleaning.com'),
(210, 'Дезинфекция Про', '222-777-555', 'Проспект Стерилизации, дом Дезинфекции', 'www.dezinfekciya-pro.com');

-- Примеры данных для ConsumablesSatellite
INSERT INTO ConsumablesSatellite (consumables_id, category, name, stock_quantity, average_price) VALUES
(501, 'Уборочные средства', 'Моющее средство', 100, 5.00),
(502, 'Уборочные средства', 'Салфетки', 200, 2.50),
(503, 'Уборочные средства', 'Средство для стекол', 150, 8.00),
(504, 'Уборочные средства', 'Средство для мебели', 120, 10.00),
(505, 'Уборочные средства', 'Пылесосы', 50, 100.00),
(506, 'Уборочные средства', 'Мешки для мусора', 300, 1.50),
(507, 'Уборочные средства', 'Щетки', 100, 4.00),
(508, 'Уборочные средства', 'Ведра', 75, 6.00),
(509, 'Уборочные средства', 'Мопы', 80, 7.50),
(510, 'Уборочные средства', 'Очистители воздуха', 25, 150.00);

-- Примеры данных для EmployeeSatellite
INSERT INTO EmployeeSatellite (employee_id, name, cleaning_skills, phone_number, salary) VALUES
(601, 'Александров Александр', 'Генеральная уборка, Мытье окон', '111-222-333', 1000.00),
(602, 'Евгеньев Евгений', 'Полировка мебели, Уборка ковров', '222-333-444', 1200.00),
(603, 'Натальин Наталья', 'Очистка вентиляции, Мытье посуды', '333-444-555', 1100.00),
(604, 'Владимиров Владимир', 'Уборка бассейна, Мытье фасада', '444-555-666', 1300.00),
(605, 'Маринина Марина', 'Чистка канализации, Дезинфекция помещения', '555-666-777', 1400.00),
(606, 'Андреев Андрей', 'Мытье окон, Мытье посуды', '666-777-888', 1000.00),
(607, 'Татьянова Татьяна', 'Полировка мебели, Уборка бассейна', '777-888-999', 1200.00),
(608, 'Иванова Иванна', 'Очистка вентиляции, Уборка ковров', '888-999-111', 1100.00),
(609, 'Дмитриев Дмитрий', 'Мытье фасада, Дезинфекция помещения', '999-111-222', 1300.00),
(610, 'Ольгов Олег', 'Мытье посуды, Мытье окон', '111-222-333', 1000.00);

SHOW PROFILES;