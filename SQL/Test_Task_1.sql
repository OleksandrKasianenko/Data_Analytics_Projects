## Write sql request,You have 2 tables 
#"1-st table name - bet_win_sum_by_day. bet_win_sum_by_day have fields system_id, game_id, currency, date, bet_sum, win_sum. It's grouped by system_id, game_id, currency, date."
#"2-d table name - events. Events tables is base source of data (not grouped for any field). Events table have fields date, time, user_id, system_id, currency. "
#"Your task is to write sql request to get as result table with fields month_date, system_id, game_id, bet_sum, win_sum, user_count for August and September 2022."



use analyst_junior_test_task;
CREATE TABLE bet_win_sum_by_day (
    system_id INT,
    game_id INT,
    currency INT,
    date date,
    bet_sum INT,
    win_sum INT
);

CREATE TABLE events (
    date date,
    time time,
    user_id INT,
    system_id INT,
    currency INT
);

select   bet_win_sum_by_day.system_id, 
bet_win_sum_by_day.game_id, 
bet_win_sum_by_day.bet_sum,
bet_win_sum_by_day.win_sum ,
MONTH(bet_win_sum_by_day.date),
count(events.user_id)
from  bet_win_sum_by_day

join events on bet_win_sum_by_day.system_id  = events.system_id
WHERE bet_win_sum_by_day.date between '2022-08-01' AND  '2022-09-30'

GROUP BY 
MONTH(bet_win_sum_by_day.date), 
 bet_win_sum_by_day.system_id,
 bet_win_sum_by_day.game_id