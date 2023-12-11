
create database jooble;

use jooble;

CREATE TABLE events (
    Id_session VARCHAR(255),
    Id INT,
    Event_type VARCHAR(255)
);

INSERT INTO events (Id_session, Id, Event_type)
VALUES
    ('48374834385734', 7382382, 'click'),
    ('48374834385734', 7382367, 'apply'),
     ('48374834385734', 3738234, 'sales');
;

CREATE TABLE sales (
    Id_session VARCHAR(255),
    Purchase DECIMAL(10,2)
);

INSERT INTO sales (Id_session, Purchase)
VALUES
    ('48374834385734', 10.1),
    ('48374834385734', 5.1);
    
  CREATE TABLE session (
    Id_session VARCHAR(255),
    Id_test INT,
    Grou_p INT
);

INSERT INTO session (Id_session, Id_test, Grou_p)
VALUES
    ('48374834385734', 1, 1),
    ('83923923734374', 1, 2);


select  Id_test, session.Grou_p, Event_type,

CASE
        WHEN events.Event_type = 'apply' THEN SUM(sales.Purchase)
        ELSE COUNT(events.Event_type)
    END AS amount_of_purchase_in_USD

 from session

left join sales on sales.Id_session = session.Id_session
left join events on events.Id_session = session.Id_session
group by Id_test, session.Grou_p, Event_type

