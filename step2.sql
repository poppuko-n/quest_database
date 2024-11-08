CREATE DATABASE InternetTv;

USE InternetTv;

CREATE TABLE programs (
    id             INTEGER      NOT NULL,
    program_title  VARCHAR(50)  NOT NULL,
    program_detail VARCHAR(255) NOT NULL,
                   PRIMARY KEY (id)
);

CREATE TABLE episodes (
    id             INTEGER      NOT NULL,
    seasons_number INTEGER      NOT NULL,
    episode_number INTEGER      NOT NULL,
    episode_title  VARCHAR(50)  NOT NULL,
    episode_detail VARCHAR(255) NOT NULL,
    video_duration TIME         NOT NULL,
    release_date   DATE         NOT NULL,
    program_id     INTEGER      NOT NULL,
                   PRIMARY KEY (id),
                   FOREIGN KEY (program_id) REFERENCES programs (id)
);

CREATE TABLE channels (
    id           INTEGER     NOT NULL,
    channel_name VARCHAR(20) NOT NULL,
                 PRIMARY KEY (id)
);

CREATE TABLE genres (
    id         INTEGER     NOT NULL,
    genre_name VARCHAR(20) NOT NULL,
               PRIMARY KEY (id)
);

CREATE TABLE programs_genres (
    program_id INTEGER NOT NULL,
    genre_id   INTEGER NOT NULL,
               PRIMARY KEY (program_id, genre_id),
               FOREIGN KEY (program_id) REFERENCES programs (id),
               FOREIGN KEY (genre_id) REFERENCES genres (id)
);

CREATE TABLE program_schedules (
    id             INTEGER NOT NULL,
    month_and_date DATE    NOT NULL,
    start_time     TIME    NOT NULL,
    end_time       TIME    NOT NULL,
    episode_id     INTEGER NOT NULL,
    channel_id     INTEGER NOT NULL,
                   PRIMARY KEY (id),
                   FOREIGN KEY (episode_id) REFERENCES episodes (id),
                   FOREIGN KEY (channel_id) REFERENCES channels (id)
);

CREATE TABLE users (
    id        INTEGER     NOT NULL,
    user_name VARCHAR(50) NOT NULL,
    age       INTEGER     NOT NULL,
    gender    INTEGER     NOT NULL,
              PRIMARY KEY (id)
);

CREATE TABLE view_histories (
    id                  INTEGER  NOT NULL,
    user_id             INTEGER  NOT NULL,
    program_schedule_id INTEGER  NOT NULL,
    watched_at          DATE     NOT NULL,
                        PRIMARY KEY (id),
                        FOREIGN KEY (user_id) REFERENCES users (id),
                        FOREIGN KEY (program_schedule_id) REFERENCES program_schedules (id)
);

-- チャンネルデータを挿入
INSERT INTO channels (id, channel_name) VALUES
(1, 'ドラマ1'),
(2, 'ドラマ2'),
(3, 'アニメ1'),
(4, 'アニメ2'),
(5, 'スポーツ'),
(6, 'ペット');

-- ジャンルデータを挿入
INSERT INTO genres (id, genre_name) VALUES
(1, 'ドラマ'),
(2, 'アニメ'),
(3, 'ファンタジー'),
(4, 'サスペンス'),
(5, 'スポーツ'),
(6, 'ドキュメンタリー'),
(7, 'ペット'),
(8, '自然'),
(9, 'SF'),
(10, '歴史'),
(11, 'アクション'),
(12, '教育'),
(13, '科学'),
(14, '子供向け'),
(15, '恋愛'),
(16, '社会'),
(17, '特番'),
(18, '社会問題');

-- programsデータを挿入
INSERT INTO programs (id, program_title, program_detail) VALUES
(1, 'ドラマシリーズA', 'ヒューマンドラマを描く感動の作品'),
(2, 'アニメシリーズB', 'ファンタジーの世界へ誘う冒険ストーリー'),
(3, '映画シリーズC', 'サスペンスが際立つ映画シリーズ'),
(4, 'スポーツシリーズD', 'スポーツの世界を追体験できる番組'),
(5, 'ニュース特番E', '最新ニュースを速報でお届け'),
(6, 'ドキュメンタリーF', '実際の事件や話題を取り上げるドキュメンタリー'),
(7, 'ペット番組G', 'ペットの可愛らしさを伝える番組'),
(8, 'ドキュメンタリーH', '自然界の不思議を探索するドキュメンタリー'),
(9, 'アニメシリーズI', 'SF世界を描いた冒険アニメ'),
(10, 'ドラマシリーズJ', '時代背景を反映した歴史ドラマ'),
(11, 'スポーツシリーズK', 'サッカーの名シーンを振り返る番組'),
(12, '映画シリーズL', 'アクション映画の新シリーズ'),
(13, 'ニュース特集M', '国内外の最新ニュースを配信'),
(14, '教育番組N', '科学の基本を学べる教育番組'),
(15, 'アニメシリーズO', '子供向けのアニメシリーズ'),
(16, 'ドラマシリーズP', '恋愛模様を描いたラブストーリー'),
(17, 'スポーツドキュメンタリーQ', 'アスリートたちの人生を追った番組'),
(18, 'ニュース解説R', 'ニュースを深堀り解説する番組'),
-- 単発番組（シリーズなし）としてのデータ
(19, '単発特番S', '一夜限りの特別放送'),
(20, '単発ドキュメンタリーT', '特定のテーマに焦点を当てた一話完結ドキュメンタリー');

-- programs_genresデータを挿入
INSERT INTO programs_genres (program_id, genre_id) VALUES
-- ドラマシリーズA (ドラマ)
(1, 1),
-- アニメシリーズB (アニメ, ファンタジー)
(2, 2),
(2, 3),
-- 映画シリーズC (映画, サスペンス)
(3, 3),
(3, 4),
-- スポーツシリーズD (スポーツ, ドキュメンタリー)
(4, 5),
(4, 6),
-- ニュース特番E (ニュース, ドキュメンタリー)
(5, 4),
(5, 6),
-- ドキュメンタリーF (ドキュメンタリー)
(6, 6),
-- ペット番組G (ペット, ドキュメンタリー)
(7, 7),
(7, 6),
-- ドキュメンタリーH (ドキュメンタリー, 自然)
(8, 6),
(8, 8),
-- アニメシリーズI (アニメ, SF)
(9, 2),
(9, 9),
-- ドラマシリーズJ (ドラマ, 歴史)
(10, 1),
(10, 10),
-- スポーツシリーズK (スポーツ, ドキュメンタリー)
(11, 5),
(11, 6),
-- 映画シリーズL (映画, アクション)
(12, 3),
(12, 11),
-- ニュース特集M (ニュース)
(13, 4),
-- 教育番組N (教育, 科学)
(14, 12),
(14, 13),
-- アニメシリーズO (アニメ, 子供向け)
(15, 2),
(15, 14),
-- ドラマシリーズP (ドラマ, 恋愛)
(16, 1),
(16, 15),
-- スポーツドキュメンタリーQ (スポーツ, ドキュメンタリー)
(17, 5),
(17, 6),
-- ニュース解説R (ニュース, 社会)
(18, 4),
(18, 16),
-- 単発特番S (特番, ドキュメンタリー)
(19, 17),
(19, 6),
-- 単発ドキュメンタリーT (ドキュメンタリー, 社会問題)
(20, 6),
(20, 18);

-- episodesデータを挿入
INSERT INTO episodes (id, seasons_number, episode_number, episode_title, episode_detail, video_duration, release_date, program_id) VALUES
-- ドラマシリーズAのエピソード
(1, 1, 1, 'ドラマA-エピソード1', 'シーズン1の第1話', '00:30:00', '2024-10-26', 1),
(2, 1, 2, 'ドラマA-エピソード2', 'シーズン1の第2話', '00:30:00', '2024-10-27', 1),
(3, 2, 1, 'ドラマA-エピソード3', 'シーズン2の第1話', '00:30:00', '2024-10-28', 1),
-- アニメシリーズBのエピソード
(4, 1, 1, 'アニメB-エピソード1', '冒険の始まり', '00:25:00', '2024-10-29', 2),
(5, 1, 2, 'アニメB-エピソード2', '新たな仲間', '00:25:00', '2024-10-30', 2),
(6, 2, 1, 'アニメB-エピソード3', '新たな敵', '00:25:00', '2024-10-31', 2),
-- 映画シリーズCのエピソード
(7, 1, 1, '映画C-エピソード1', '事件の始まり', '01:30:00', '2024-11-01', 3),
(8, 1, 2, '映画C-エピソード2', '真相に迫る', '01:30:00', '2024-11-02', 3),
(9, 2, 1, '映画C-エピソード3', '解決編', '01:30:00', '2024-11-03', 3),
-- スポーツシリーズDのエピソード
(10, 1, 1, 'スポーツD-エピソード1', '試合ハイライト', '00:45:00', '2024-10-26', 4),
(11, 1, 2, 'スポーツD-エピソード2', '選手インタビュー', '00:45:00', '2024-10-27', 4),
-- ドキュメンタリーFのエピソード
(12, 0, 1, 'ドキュメンタリーF-エピソード1', '事件の裏側', '00:50:00', '2024-11-04', 6),
-- ペット番組Gのエピソード
(13, 1, 1, 'ペットG-エピソード1', 'かわいい犬特集', '00:20:00', '2024-10-28', 7),
(14, 1, 2, 'ペットG-エピソード2', '猫の魅力', '00:20:00', '2024-10-29', 7),
-- ドラマシリーズJのエピソード
(15, 1, 1, 'ドラマJ-エピソード1', '歴史の始まり', '00:40:00', '2024-10-30', 10),
(16, 1, 2, 'ドラマJ-エピソード2', '時代の波', '00:40:00', '2024-10-31', 10),
-- ニュース特番Eのエピソード (単発番組)
(17, 0, 1, 'ニュース特番E-エピソード', '最新ニュース速報', '01:00:00', '2024-11-04', 5),
-- 単発特番Sのエピソード (単発番組)
(18, 0, 1, '単発特番S-エピソード', '一夜限りの特別放送', '01:00:00', '2024-11-05', 19),
-- 単発ドキュメンタリーTのエピソード (単発番組)
(19, 0, 1, '単発ドキュメンタリーT-エピソード', '特定テーマのドキュメンタリー', '01:00:00', '2024-11-06', 20),
-- ドラマシリーズPのエピソード
(20, 1, 1, 'ドラマP-エピソード1', 'ラブストーリーの始まり', '00:45:00', '2024-10-27', 16),
(21, 1, 2, 'ドラマP-エピソード2', '恋の展開', '00:45:00', '2024-10-28', 16),
(22, 2, 1, 'ドラマP-エピソード3', '新しい出会い', '00:45:00', '2024-10-29', 16),
-- アニメシリーズOのエピソード
(23, 1, 1, 'アニメO-エピソード1', '冒険の始まり', '00:30:00', '2024-10-30', 15),
(24, 1, 2, 'アニメO-エピソード2', '友情の絆', '00:30:00', '2024-10-31', 15),
(25, 2, 1, 'アニメO-エピソード3', '新しい冒険', '00:30:00', '2024-11-01', 15),
-- ニュース解説Rのエピソード
(26, 1, 1, 'ニュース解説R-エピソード1', '注目ニュースを深掘り', '00:50:00', '2024-11-02', 18),
(27, 1, 2, 'ニュース解説R-エピソード2', '経済ニュース解説', '00:50:00', '2024-11-03', 18),
-- ドキュメンタリーHのエピソード
(28, 1, 1, 'ドキュメンタリーH-エピソード1', '自然界の不思議', '00:55:00', '2024-10-28', 8),
(29, 1, 2, 'ドキュメンタリーH-エピソード2', '動物の生態', '00:55:00', '2024-10-29', 8),
-- スポーツシリーズKのエピソード
(30, 1, 1, 'スポーツK-エピソード1', 'サッカーの名シーン集', '00:40:00', '2024-10-30', 11),
(31, 1, 2, 'スポーツK-エピソード2', '選手の軌跡', '00:40:00', '2024-10-31', 11),
-- 映画シリーズLのエピソード
(32, 1, 1, '映画L-エピソード1', 'アクションの幕開け', '01:45:00', '2024-11-02', 12),
(33, 1, 2, '映画L-エピソード2', '新たな敵との対決', '01:45:00', '2024-11-03', 12),
(34, 2, 1, '映画L-エピソード3', 'クライマックス', '01:45:00', '2024-11-04', 12),
-- 教育番組Nのエピソード
(35, 1, 1, '教育N-エピソード1', '科学の基本', '00:30:00', '2024-10-26', 14),
(36, 1, 2, '教育N-エピソード2', '宇宙の不思議', '00:30:00', '2024-10-27', 14),
-- その他のエピソード
(37, 1, 3, 'アニメB-エピソード4', '旅の続き', '00:25:00', '2024-11-02', 2),
(38, 2, 2, 'アニメB-エピソード5', '新たなライバル', '00:25:00', '2024-11-03', 2),
(39, 2, 2, 'ドラマA-エピソード4', 'クライマックスへ', '00:30:00', '2024-11-04', 1),
(40, 1, 3, 'ペットG-エピソード3', '珍しいペット特集', '00:20:00', '2024-11-05', 7),
(41, 2, 2, 'ドラマJ-エピソード3', '歴史の新章', '00:40:00', '2024-11-06', 10),
-- シリーズPおよびOのエピソードを追加して合計50エピソードに到達
(42, 2, 2, 'ドラマP-エピソード4', '感動の結末', '00:45:00', '2024-11-07', 16),
(43, 2, 2, 'アニメO-エピソード4', '最終決戦', '00:30:00', '2024-11-08', 15),
-- ニュース特集Mのエピソード (単発番組)
(44, 0, 1, 'ニュース特集M-特別編', '特別放送の特集', '01:00:00', '2024-10-30', 13),
-- 残りのエピソード
(45, 2, 1, 'ドキュメンタリーH-エピソード3', '世界の不思議', '00:55:00', '2024-11-09', 8),
(46, 1, 3, '映画C-エピソード4', '最後の謎', '01:30:00', '2024-11-10', 3),
(47, 1, 4, '教育N-エピソード3', '地球環境について', '00:30:00', '2024-11-04', 14),
(48, 2, 3, 'アニメB-エピソード6', '過去との対面', '00:25:00', '2024-11-05', 2),
(49, 2, 2, 'ペットG-エピソード4', '保護された動物たち', '00:20:00', '2024-11-06', 7),
(50, 1, 3, '映画L-エピソード4', '終わりの戦い', '01:45:00', '2024-11-07', 12);

-- programs_genresデータを挿入
INSERT INTO program_schedules (id, month_and_date, start_time, end_time, episode_id, channel_id) VALUES
-- ドラマシリーズAのエピソードスケジュール (episode_id 1〜3)
(1, '2024-10-26', '13:00:00', '13:30:00', 1, 1),
(2, '2024-10-27', '13:00:00', '13:30:00', 2, 1),
(3, '2024-10-28', '13:00:00', '13:30:00', 3, 1),
-- 再放送
(4, '2024-10-27', '15:00:00', '15:30:00', 1, 1),
(5, '2024-10-28', '15:00:00', '15:30:00', 2, 1),
(6, '2024-10-29', '15:00:00', '15:30:00', 3, 1),
-- アニメシリーズBのエピソードスケジュール (episode_id 4〜6)
(7, '2024-10-29', '14:00:00', '14:25:00', 4, 3),
(8, '2024-10-30', '14:00:00', '14:25:00', 5, 3),
(9, '2024-10-31', '14:00:00', '14:25:00', 6, 3),
-- 再放送
(10, '2024-10-30', '18:00:00', '18:25:00', 4, 3),
(11, '2024-10-31', '18:00:00', '18:25:00', 5, 3),
(12, '2024-11-01', '18:00:00', '18:25:00', 6, 3),
-- 映画シリーズCのエピソードスケジュール (episode_id 7〜9)
(13, '2024-11-01', '16:00:00', '17:30:00', 7, 2),
(14, '2024-11-02', '16:00:00', '17:30:00', 8, 2),
(15, '2024-11-03', '16:00:00', '17:30:00', 9, 2),
-- 再放送
(16, '2024-11-02', '20:00:00', '21:30:00', 7, 2),
(17, '2024-11-03', '20:00:00', '21:30:00', 8, 2),
(18, '2024-11-04', '20:00:00', '21:30:00', 9, 2),
-- ドラマシリーズPのエピソードスケジュール (episode_id 20〜22)
(19, '2024-10-27', '16:00:00', '16:45:00', 20, 1),
(20, '2024-10-28', '16:00:00', '16:45:00', 21, 1),
(21, '2024-10-29', '16:00:00', '16:45:00', 22, 1),
-- 再放送
(22, '2024-10-28', '20:00:00', '20:45:00', 20, 1),
(23, '2024-10-29', '20:00:00', '20:45:00', 21, 1),
(24, '2024-10-30', '20:00:00', '20:45:00', 22, 1),
-- ペット番組Gのエピソードスケジュール (episode_id 13〜14)
(25, '2024-10-28', '15:00:00', '15:20:00', 13, 6),
(26, '2024-10-29', '15:00:00', '15:20:00', 14, 6),
-- 再放送
(27, '2024-10-29', '19:00:00', '19:20:00', 13, 6),
(28, '2024-10-30', '19:00:00', '19:20:00', 14, 6),
-- ドキュメンタリーFのエピソードスケジュール (episode_id 12)
(29, '2024-11-04', '14:00:00', '14:50:00', 12, 4),
-- 再放送
(30, '2024-11-05', '17:00:00', '17:50:00', 12, 4),
-- ドラマシリーズJのエピソードスケジュール (episode_id 15〜16)
(31, '2024-10-30', '15:00:00', '15:40:00', 15, 1),
(32, '2024-10-31', '15:00:00', '15:40:00', 16, 1),
-- 再放送
(33, '2024-11-01', '19:00:00', '19:40:00', 15, 1),
(34, '2024-11-02', '19:00:00', '19:40:00', 16, 1),
-- ニュース特番Eのスケジュール (episode_id 17)
(35, '2024-11-04', '13:00:00', '14:00:00', 17, 5),
-- 再放送
(36, '2024-11-05', '17:00:00', '18:00:00', 17, 5),
-- 単発特番Sのスケジュール (episode_id 18)
(37, '2024-11-05', '14:00:00', '15:00:00', 18, 2),
-- 再放送
(38, '2024-11-06', '18:00:00', '19:00:00', 18, 2),
-- アニメシリーズOのエピソードスケジュール (episode_id 23〜24)
(39, '2024-10-30', '16:00:00', '16:30:00', 23, 3),
(40, '2024-10-31', '16:00:00', '16:30:00', 24, 3),
-- 再放送
(41, '2024-11-01', '20:00:00', '20:30:00', 23, 3),
(42, '2024-11-02', '20:00:00', '20:30:00', 24, 3),
-- ドキュメンタリーHのエピソードスケジュール (episode_id 28〜29)
(43, '2024-10-28', '12:00:00', '12:55:00', 28, 4),
(44, '2024-10-29', '12:00:00', '12:55:00', 29, 4),
-- 再放送
(45, '2024-10-30', '14:00:00', '14:55:00', 28, 4),
(46, '2024-10-31', '14:00:00', '14:55:00', 29, 4),
-- 残りのエピソードのスケジュール (episode_id 30〜50)
(47, '2024-10-28', '17:00:00', '17:30:00', 30, 2),
(48, '2024-10-29', '17:00:00', '17:30:00', 31, 2),
(49, '2024-10-30', '17:00:00', '17:30:00', 32, 2),
(50, '2024-10-31', '17:00:00', '17:30:00', 33, 2),
(51, '2024-11-01', '17:00:00', '17:30:00', 34, 2),
(52, '2024-11-02', '17:00:00', '17:30:00', 35, 2),
(53, '2024-11-03', '17:00:00', '17:30:00', 36, 2),
(54, '2024-11-04', '17:00:00', '17:30:00', 37, 2),
(55, '2024-10-26', '15:00:00', '15:30:00', 38, 5),
(56, '2024-10-27', '15:00:00', '15:30:00', 39, 5),
(57, '2024-10-28', '15:00:00', '15:30:00', 40, 5),
(58, '2024-10-29', '15:00:00', '15:30:00', 41, 5),
(59, '2024-10-30', '15:00:00', '15:30:00', 42, 5),
(60, '2024-10-31', '15:00:00', '15:30:00', 43, 5),
(61, '2024-11-01', '15:00:00', '15:30:00', 44, 5),
(62, '2024-11-02', '15:00:00', '15:30:00', 45, 5),
(63, '2024-11-03', '15:00:00', '15:30:00', 46, 5),
(64, '2024-11-04', '15:00:00', '15:30:00', 47, 5),
(65, '2024-11-05', '15:00:00', '15:30:00', 48, 5),
(66, '2024-11-06', '15:00:00', '15:30:00', 49, 5),
(67, '2024-11-07', '15:00:00', '15:30:00', 50, 5),
-- 再放送
(68, '2024-10-27', '19:00:00', '19:30:00', 38, 5),
(69, '2024-10-28', '19:00:00', '19:30:00', 39, 5),
(70, '2024-10-29', '19:00:00', '19:30:00', 40, 5),
(71, '2024-10-30', '19:00:00', '19:30:00', 41, 5),
(72, '2024-10-31', '19:00:00', '19:30:00', 42, 5),
(73, '2024-11-01', '19:00:00', '19:30:00', 43, 5),
(74, '2024-11-02', '19:00:00', '19:30:00', 44, 5),
(75, '2024-11-03', '19:00:00', '19:30:00', 45, 5),
(76, '2024-11-04', '19:00:00', '19:30:00', 46, 5),
(77, '2024-11-05', '19:00:00', '19:30:00', 47, 5),
(78, '2024-11-06', '19:00:00', '19:30:00', 48, 5),
(79, '2024-11-07', '19:00:00', '19:30:00', 49, 5),
(80, '2024-11-08', '19:00:00', '19:30:00', 50, 5);

-- usersデータを挿入
INSERT INTO users (id, user_name, age, gender) VALUES
(1, 'ユーザー1', 25, 1),
(2, 'ユーザー2', 30, 0),
(3, 'ユーザー3', 45, 1),
(4, 'ユーザー4', 28, 0),
(5, 'ユーザー5', 33, 1),
(6, 'ユーザー6', 22, 1),
(7, 'ユーザー7', 34, 0),
(8, 'ユーザー8', 29, 1),
(9, 'ユーザー9', 41, 0),
(10, 'ユーザー10', 27, 1),
(11, 'ユーザー11', 36, 0),
(12, 'ユーザー12', 23, 1),
(13, 'ユーザー13', 48, 0),
(14, 'ユーザー14', 32, 1),
(15, 'ユーザー15', 26, 0),
(16, 'ユーザー16', 39, 1),
(17, 'ユーザー17', 45, 0),
(18, 'ユーザー18', 31, 1),
(19, 'ユーザー19', 28, 0),
(20, 'ユーザー20', 37, 1);

-- view_historiesデータを挿入
INSERT INTO view_histories (id, user_id, program_schedule_id, watched_at) VALUES
(1, 1, 5, '2024-10-26'),
(2, 3, 12, '2024-10-27'),
(3, 2, 8, '2024-10-28'),
(4, 4, 6, '2024-10-27'),
(5, 1, 7, '2024-10-28'),
(6, 5, 3, '2024-10-29'),
(7, 6, 11, '2024-10-29'),
(8, 2, 15, '2024-10-30'),
(9, 7, 1, '2024-10-31'),
(10, 8, 14, '2024-10-30'),
(11, 9, 4, '2024-10-31'),
(12, 10, 9, '2024-11-01'),
(13, 4, 10, '2024-11-01'),
(14, 5, 13, '2024-11-02'),
(15, 1, 2, '2024-11-02'),
(16, 3, 16, '2024-11-03'),
(17, 7, 18, '2024-11-03'),
(18, 8, 17, '2024-11-04'),
(19, 9, 19, '2024-10-27'),
(20, 10, 20, '2024-10-28'),
(21, 6, 5, '2024-10-29'),
(22, 11, 7, '2024-10-28'),
(23, 12, 9, '2024-10-29'),
(24, 2, 4, '2024-10-30'),
(25, 5, 8, '2024-10-28'),
(26, 13, 6, '2024-10-29'),
(27, 14, 15, '2024-10-29'),
(28, 3, 10, '2024-10-30'),
(29, 6, 1, '2024-10-31'),
(30, 1, 12, '2024-10-30'),
(31, 8, 11, '2024-10-31'),
(32, 13, 3, '2024-11-01'),
(33, 9, 2, '2024-11-01'),
(34, 10, 5, '2024-11-02'),
(35, 2, 14, '2024-11-02'),
(36, 11, 13, '2024-11-03'),
(37, 12, 4, '2024-11-03'),
(38, 14, 6, '2024-11-04'),
(39, 15, 8, '2024-10-27'),
(40, 16, 11, '2024-10-28'),
(41, 17, 15, '2024-10-30'),
(42, 5, 14, '2024-10-31'),
(43, 10, 7, '2024-11-01'),
(44, 18, 9, '2024-11-02'),
(45, 20, 13, '2024-11-03'),
(46, 4, 17, '2024-11-04'),
(47, 3, 5, '2024-11-05'),
(48, 6, 10, '2024-11-06'),
(49, 8, 8, '2024-11-07'),
(50, 12, 12, '2024-11-08'),
(51, 11, 2, '2024-10-29'),
(52, 19, 4, '2024-10-30'),
(53, 7, 16, '2024-10-31'),
(54, 13, 14, '2024-11-01'),
(55, 6, 6, '2024-11-02'),
(56, 9, 3, '2024-11-03'),
(57, 1, 15, '2024-11-04'),
(58, 2, 18, '2024-11-05'),
(59, 4, 19, '2024-11-06'),
(60, 20, 13, '2024-11-07'),
(61, 14, 5, '2024-11-08'),
(62, 15, 1, '2024-11-09'),
(63, 16, 3, '2024-11-10'),
(64, 17, 10, '2024-11-01'),
(65, 18, 6, '2024-11-02'),
(66, 19, 14, '2024-11-03'),
(67, 20, 12, '2024-11-04'),
(68, 3, 17, '2024-11-05'),
(69, 5, 8, '2024-11-06'),
(70, 8, 13, '2024-11-07'),
(71, 2, 11, '2024-11-08'),
(72, 6, 9, '2024-11-09'),
(73, 9, 16, '2024-11-10'),
(74, 10, 7, '2024-11-01'),
(75, 15, 14, '2024-11-02'),
(76, 17, 12, '2024-11-03'),
(77, 12, 4, '2024-11-04'),
(78, 13, 5, '2024-11-05'),
(79, 11, 8, '2024-11-06'),
(80, 20, 3, '2024-11-07'),
(81, 14, 13, '2024-11-08'),
(82, 4, 6, '2024-11-09'),
(83, 8, 2, '2024-11-10'),
(84, 1, 1, '2024-11-02'),
(85, 6, 16, '2024-11-03'),
(86, 5, 7, '2024-11-04'),
(87, 2, 11, '2024-11-05'),
(88, 3, 18, '2024-11-06'),
(89, 19, 10, '2024-11-07'),
(90, 18, 15, '2024-11-08'),
(91, 7, 9, '2024-11-09'),
(92, 10, 12, '2024-11-10'),
(93, 14, 3, '2024-11-02'),
(94, 15, 4, '2024-11-03'),
(95, 11, 8, '2024-11-04'),
(96, 12, 13, '2024-11-05'),
(97, 8, 6, '2024-11-06'),
(98, 9, 14, '2024-11-07'),
(99, 13, 5, '2024-11-08'),
(100, 16, 2, '2024-11-09');