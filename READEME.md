# インターネットTV
## 内容
好きな時間に好きな場所で話題の動画を無料で楽しめる「インターネットTVサービス」を新規に作成。データベース設計、データを取得する SQL を以下の通り作成した。

## ステップ1
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
| program_id     | integer      | NOT  |

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
| episode_id     | integer | NOT  |         |     |                |
| channel_id     | integer | NOT  |

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
| user_id             | integer | NOT  |         |     |                |
| program_schedule_id | integer | NOT  |         |     |                |
| watched_at          | date    | NOT  |

## ステップ2
実際にテーブルを構築し、データを入れる手順ドキュメントを'step2.sql'にとりまとめた。()は該当する`step2.sql`の行数を示している。

1. データベースを構築。(1行目)

```
CREATE DATABASE InternetTv;
```

2. ステップ1で設計したテーブルを構築。（３行目〜７３行目）

```
CREATE TABLE テーブル名 (
    カラム名1 データ型1　制約１..,
    カラム名2 データ型2  制約2..,   
            PRIMARY KEY (主キー),
            FOREIGN KEY (外部キー) REFERENCES programs (テーブル名)
);
```

3. サンプルデータを挿入。（75行目〜494行目）

```
INSERT INTO テーブル名 (カルム名1, カルム名2...) VALUES
(カラム値1, カラム値2...);
```

## ステップ3
以下のデータを抽出するクエリを `step3.sql`にとりまとめた。()は該当する`step3.sql`の行数を示している。

1. よく見られているエピソードを知りたい。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得。(1行目〜10行目)
2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたい。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得。(12行目〜23行目)
3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたい。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得。なお、番組の開始時刻が本日のものを本日方法される番組とみなす。(25行目〜34行目)
4. ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたい。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得。(36行目〜42行目)
5. 直近一週間で最も見られた番組が知りたい。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得。(44行目〜56行目)
6. ジャンルごとの番組の視聴数ランキングを知りたい。番組の視聴数ランキングはエピソードの平均視聴数ランキングとする。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得。(58行目〜88行目)