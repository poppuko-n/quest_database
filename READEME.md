# インターネットTV
## 内容
好きな時間に好きな場所で話題の動画を無料で楽しめる「インターネットTVサービス」を作成。仕様をもとに、下記ステップ毎に手順をとりまとめた。

`ステップ1`: テーブル設計  
`ステップ2`: テーブルの作成・データの挿入  
`ステップ3`: データ分析


### 仕様
- ドラマ1、ドラマ2、アニメ1、アニメ2、スポーツ、ペットの複数のチャンネルがある。
- 各チャンネルの下では時間帯ごとに番組枠が1つ設定されており、番組が放映される。
- 番組はシリーズになっているものと単発ものがある。シリーズになっているものはシーズンが1つものと、シーズン1、シーズン2のように複数シーズンのものがある。各シーズンの下では各エピソードが設定されている
- 再放送もあるため、ある番組が複数チャンネルの異なる番組枠で放映されることはある。
- 番組の情報として、タイトル、番組詳細、ジャンルが画面上に表示される。
- 各エピソードの情報として、シーズン数、エピソード数、タイトル、エピソード詳細、動画時間、公開日、視聴数が画面上に表示される。単発のエピソードの場合はシーズン数、エピソード数は表示されない。
- ジャンルとしてアニメ、映画、ドラマ、ニュースなどがある。各番組は1つ以上のジャンルに属する。
- KPIとして、チャンネルの番組枠のエピソードごとに視聴数を記録する。なお、一つのエピソードは複数の異なるチャンネル及び番組枠で放送されることがあるので、属するチャンネルの番組枠ごとに視聴数がどうだったかも追えるようにする。

## ステップ1（テーブル設計）
以下の点に留意し、テーブル設計を実施。

- アプリケーションとして成立すること(プログラムを組んだ際に仕様を満たして動作すること)
- 正規化されていること

テーブル:`programs`
| カラム名           | データ型         | NULL | キー      | 初期値 | AUTO INCREMENT |
|----------------|--------------|------|---------|-----|----------------|
| id             | integer      | NOT  | PRIMARY |     | YES            |
| program_title  | varchar(50)  | NOT  |         |     |                |
| program_detail | varchar(255) | NOT  |

テーブル:`episodes`
| カラム名           | データ型         | NULL | キー      | 初期値 | AUTO INCREMENT |
|----------------|--------------|------|---------|-----|----------------|
| id             | integer      | NOT  | PRIMARY |     | YES            |
| seasons_number | integer      | NOT  |         |     |                |
| episode_number | integer      | NOT  |         |     |                |
| episode_title  | varchar(50)  | NOT  |         |     |                |
| episode_detail | varchar(255) | NOT  |         |     |                |
| video_duration | time         | NOT  |         |     |                |
| release_date   | date         | NOT  |         |     |                |
| program_id     | integer      | NOT  |FOREIGN 

テーブル:`channels`
| カラム名         | データ型        | NULL | キー      | 初期値 | AUTO INCREMENT |
|--------------|-------------|------|---------|-----|----------------|
| id           | integer     | NOT  | PRIMARY |     | YES            |
| channel_name | varchar(20) | NOT  |

テーブル:`genres`
| カラム名       | データ型        | NULL | キー      | 初期値 | AUTO INCREMENT |
|------------|-------------|------|---------|-----|----------------|
| id         | integer     | NOT  | PRIMARY |     | YES            |
| genre_name | varchar(20) | NOT  |

テーブル:`programs_genres`
| カラム名       | データ型    | NULL | キー      | 初期値 | AUTO INCREMENT |
|------------|---------|------|---------|-----|----------------|
| program_id | integer | NOT  | PRIMARY |     |                |
| genre_id   | integer | NOT  | PRIMARY |

テーブル:`program_schedules`
| カラム名           | データ型    | NULL | キー      | 初期値 | AUTO INCREMENT |
|----------------|---------|------|---------|-----|----------------|
| id             | integer | NOT  | PRIMARY |     | YES            |
| month_and_date | date    | NOT  |         |     |                |
| start_time     | time    | NOT  |         |     |                |
| end_time       | time    | NOT  |         |     |                |
| episode_id     | integer | NOT  | FOREIGN |     |                |
| channel_id     | integer | NOT  | FOREIGN 

テーブル:`users`
| カラム名      | データ型        | NULL | キー      | 初期値 | AUTO INCREMENT |
|-----------|-------------|------|---------|-----|----------------|
| id        | integer     | NOT  | PRIMARY |     | YES            |
| user_name | varchar(50) | NOT  |         |     |                |
| age       | integer     | NOT  |         |     |                |
| gender    | integer     | NOT  |

テーブル:`view_histories`
| カラム名                | データ型    | NULL | キー      | 初期値 | AUTO INCREMENT |
|---------------------|---------|------|---------|-----|----------------|
| id                  | integer | NOT  | PRIMARY |     | YES            |
| user_id             | integer | NOT  | FOREIGN |     |                |
| program_schedule_id | integer | NOT  |         |     |                |
| watched_at          | date    | NOT  |

## ステップ2（テーブルの作成・データの挿入）
ステップ１のテーブル設計をもとに、実際にテーブルを作成し、サンプルデータを挿入するまでのSQLステートメントを`step2.sql`にて構築した。セミコロン毎に`DBMS`へ実行することで期待通りの結果が得られるようになっている。なお、各手順の基本構文は下記の通りである。()は`step2.sql`の該当する行数を示している。

1. データベースを構築。(1行目)

```sql
CREATE DATABASE InternetTv;
```

2. ステップ1で設計したテーブルを構築。（３行目〜７３行目）

```sql
CREATE TABLE テーブル名 (
    カラム名1 データ型1　制約１..,
    カラム名2 データ型2  制約2..,   
            PRIMARY KEY (主キー),
            FOREIGN KEY (外部キー) REFERENCES programs (テーブル名)
);
```

3. サンプルデータを挿入。（75行目〜494行目）

```sql
INSERT INTO テーブル名 (カルム名1, カルム名2...) VALUES
(カラム値1, カラム値2...);
```

## ステップ3（データ分析）
各データを抽出するSQLステートメントを `step3.sql`に構築した。()は該当する`step3.sql`の行数を示している。

1. よく見られているエピソードを知りたい。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得。(1行目〜10行目)
```sql
   SELECT e.episode_title AS 'エピソードタイトル', COUNT(*) AS '視聴数'
     FROM view_histories AS vh
LEFT JOIN program_schedules AS ps
       ON vh.program_schedule_id = ps.id
LEFT JOIN episodes AS e
       ON ps.episode_id = e.id
 GROUP BY e.episode_title
 ORDER BY COUNT(*) DESC
    LIMIT 3;
```

2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたい。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得。(12行目〜23行目)
```sql
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
```

3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたい。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得。なお、番組の開始時刻が本日のものを本日方法される番組とみなす。(25行目〜34行目)
```sql
   SELECT c.channel_name AS 'チャンネル名', concat(month_and_date, ' ', start_time) AS '放送開始時刻', ps.end_time AS '放送終了時刻', e.seasons_number AS 'シーズン数', e.episode_number AS 'エピソード数', e.episode_title AS 'エピソードタイトル', e.episode_detail AS 'エピソード詳細'
     FROM program_schedules AS ps
LEFT JOIN episodes AS e
       ON ps.episode_id = e.id
LEFT JOIN channels AS c
       ON ps.channel_id = c.id
    WHERE month_and_date = (
   SELECT current_date
);
```

4. ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたい。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得。(36行目〜42行目)
```sql
   SELECT concat(month_and_date, ' ', start_time) AS '放送開始時刻', ps.end_time AS '放送終了時刻', e.seasons_number AS 'シーズン数', e.episode_number AS 'エピソード数', e.episode_title AS 'エピソードタイトル', e.episode_detail AS 'エピソード詳細'
     FROM program_schedules AS ps
LEFT JOIN episodes AS e
       ON ps.episode_id = e.id
    WHERE ps.month_and_date BETWEEN (SELECT current_date)  AND (SELECT current_date + interval 7 DAY)
      AND ps.channel_id = 1;
```

5. 直近一週間で最も見られた番組が知りたい。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得。(44行目〜56行目)
```sql
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
```

6. ジャンルごとの番組の視聴数ランキングを知りたい。番組の視聴数ランキングはエピソードの平均視聴数ランキングとする。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得。(58行目〜88行目)
```sql
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
   SELECT pg.genre_id, pav.program_title, RANK() OVER(PARTITION BY pg.genre_id ORDER BY pav.program_avg_view DESC) AS program_rank
     FROM programs_genres AS pg
LEFT JOIN program_avg_view AS pav
       ON pg.program_id = pav.id
)

   SELECT genre_id, program_title
     FROM rank_program
    WHERE program_rank = 1;
```