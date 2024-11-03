-- １の課題
   SELECT e.episode_title AS 'エピソードタイトル', COUNT(*) AS '視聴数'
     FROM view_histories AS vh
LEFT JOIN program_schedules AS ps
       ON vh.program_schedule_id = ps.id
LEFT JOIN episodes AS e
       ON ps.episode_id = e.id
 GROUP BY e.episode_title
 ORDER BY COUNT(*) DESC
    LIMIT 3;

-- ２の課題
   SELECT p.program_title AS '番組タイトル', e.seasons_number AS 'シーズン数', e.episode_number AS 'エピソード数', e.episode_title AS 'エピソードタイトル', COUNT(*) AS '視聴数'
     FROM view_histories AS vh
LEFT JOIN program_schedules AS ps
       ON vh.program_schedule_id = ps.id
LEFT JOIN episodes AS e
       ON ps.episode_id = e.id
LEFT JOIN programs AS p 
       ON e.program_id = p.id
 GROUP BY p.program_title, e.seasons_number, e.episode_number, e.episode_title
 ORDER BY COUNT(*) DESC
    LIMIT 3;

-- 3の課題
   SELECT c.channel_name AS 'チャンネル名', concat(month_and_date, ' ', start_time) AS '放送開始時刻', ps.end_time AS '放送終了時刻', e.seasons_number AS 'シーズン数', e.episode_number AS 'エピソード数', e.episode_title AS 'エピソードタイトル', e.episode_detail AS 'エピソード詳細'
     FROM program_schedules AS ps
LEFT JOIN episodes AS e
       ON ps.episode_id = e.id
LEFT JOIN channels AS c
       ON ps.channel_id = c.id
    WHERE month_and_date = (
   SELECT current_date
);

-- 4の課題
   SELECT concat(month_and_date, ' ', start_time) AS '放送開始時刻', ps.end_time AS '放送終了時刻', e.seasons_number AS 'シーズン数', e.episode_number AS 'エピソード数', e.episode_title AS 'エピソードタイトル', e.episode_detail AS 'エピソード詳細'
     FROM program_schedules AS ps
LEFT JOIN episodes AS e
       ON ps.episode_id = e.id
    WHERE ps.month_and_date BETWEEN (SELECT current_date)  AND (SELECT current_date + interval 7 DAY)
      AND ps.channel_id = 1;

-- 5の課題
   SELECT p.program_title AS '番組タイトル', COUNT(*) AS '視聴数'
     FROM view_histories AS vh
LEFT JOIN program_schedules AS ps
       ON vh.program_schedule_id = ps.id
LEFT JOIN episodes AS e
       ON ps.episode_id = e.id
LEFT JOIN programs AS p
       ON e.program_id = p.id
    WHERE watched_at BETWEEN (SELECT current_date - interval 7 DAY) AND (SELECT current_date)
 GROUP BY p.program_title
 ORDER BY COUNT(*) DESC
    LIMIT 2;

-- 6の課題
-- エピソード毎の合計視聴数を表示するテーブルを仮作成
     WITH episode_total_view AS(
   SELECT e.id, COUNT(vh.user_id) AS 'episode_total_view', e.program_id
     FROM episodes AS e
LEFT JOIN program_schedules AS ps
       ON e.id = ps.episode_id
LEFT JOIN view_histories AS vh
       ON ps.id = vh.program_schedule_id
 GROUP BY e.id, e.program_id
 ORDER BY e.id ASC
),
-- 番組毎の平均視聴数を表示するテーブルを仮作成
program_avg_view AS(
   SELECT p.id, p.program_title, AVG(etv.episode_total_view) AS program_avg_view
     FROM programs AS p
LEFT JOIN episode_total_view AS etv
       ON p.id = etv.program_id
 GROUP BY p.id, p.program_title
),
-- ウィンドウ関数を共通テーブルで表示
rank_program AS (
   SELECT pg.genre_id, pav.program_title,pav.program_avg_view, RANK() OVER(PARTITION BY pg.genre_id ORDER BY pav.program_avg_view DESC) AS program_rank
     FROM programs_genres AS pg
LEFT JOIN program_avg_view AS pav
       ON pg.program_id = pav.id
)

   SELECT genre_id AS "ジャンル名", program_title AS '番組タイトル', program_avg_view AS 'エピソード平均視聴数'
     FROM rank_program
    WHERE program_rank = 1;

