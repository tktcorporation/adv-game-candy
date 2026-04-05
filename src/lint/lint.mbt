///|
/// シナリオリンター — scenario_ch*.mbt の構造的整合性を検証する（MoonBit版）
///
/// 使い方:
///   moon build --target js && node target/js/release/build/lint/lint.js src/data/scenario_ch*.mbt

// ---------------------------------------------------------------------------
// 型定義
// ---------------------------------------------------------------------------

///|
struct Violation {
  file : String
  line : Int  // 0 = ファイル全体
  level : String  // "ERROR" or "WARN"
  message : String
}

///|
struct KnowledgeEntry {
  info : String
  chapter : String
  scene : String
  keywords : Array[String]
}

// ---------------------------------------------------------------------------
// ユーティリティ
// ---------------------------------------------------------------------------

///|
fn format_violation(v : Violation) -> String {
  let loc = if v.line > 0 {
    v.file + ":" + v.line.to_string()
  } else {
    v.file
  }
  "[" + v.level + "] " + loc + " — " + v.message
}

///|
fn chapter_num_from_name(name : String) -> Int {
  match name.find("ch") {
    None => -1
    Some(start) => {
      let after_ch = start + 2
      let mut end = after_ch
      let chars = name.to_array()
      while end < chars.length() && chars[end] >= '0' && chars[end] <= '9' {
        end = end + 1
      }
      if end == after_ch {
        return -1
      }
      let num_str = name[after_ch:end]
      try {
        @string.parse_int(num_str)
      } catch {
        _ => -1
      }
    }
  }
}

///|
fn str_find(haystack : String, needle : String) -> Int {
  match haystack.find(needle) {
    Some(i) => i
    None => -1
  }
}

///|
fn str_rfind(haystack : String, needle : String) -> Int {
  match haystack.rev_find(needle) {
    Some(i) => i
    None => -1
  }
}

///|
/// split の結果を Array[String] に変換
fn split_to_array(s : String, sep : String) -> Array[String] {
  s.split(sep).map(fn(sv) { sv.to_string() }).collect()
}

///|
fn read_file(path : String) -> String {
  try {
    @fs.read_file_sync_string(path, "utf-8")
  } catch {
    _ => ""
  }
}

// ---------------------------------------------------------------------------
// ルール: シーン状態コメント
// ---------------------------------------------------------------------------

///|
/// 全シーンに前提/変化/結果コメントがあること。
///
/// 根拠: commit a3c8f50 — ch0にだけ適用してch1-8を忘れた
fn rule_scene_state_comments(
  file_path : String,
  lines : Array[String],
) -> Array[Violation] {
  let violations : Array[Violation] = []
  let name = @path.basename(file_path)
  let required = ["前提:", "変化:", "結果:"]
  for i, line in lines {
    if !line.contains("// --- Scene") {
      continue
    }
    let line_num = i + 1
    let mut block = ""
    for j = i; j < lines.length(); j = j + 1 {
      block = block + lines[j] + "\n"
      if j > i && lines[j].contains("id:") && lines[j].contains("\"ch") {
        break
      }
    }
    for _, req in required {
      if !block.contains(req) {
        violations.push({
          file: name,
          line: line_num,
          level: "WARN",
          message: "「// " + req + "」がありません（シーン状態コメント必須）",
        })
      }
    }
  }
  violations
}

// ---------------------------------------------------------------------------
// ルール: 章ヘッダー状態差分
// ---------------------------------------------------------------------------

///|
/// 章ヘッダーに「章の状態差分」セクションがあること。
///
/// 根拠: commit a3c8f50 — 章レベルの状態管理がなかった
fn rule_chapter_state_diff(
  file_path : String,
  content : String,
) -> Array[Violation] {
  let violations : Array[Violation] = []
  let name = @path.basename(file_path)
  if !content.contains("章の状態差分") {
    violations.push({
      file: name, line: 0, level: "WARN",
      message: "章ヘッダーに「章の状態差分」がありません",
    })
    return violations
  }
  if !content.contains("開始状態:") {
    violations.push({
      file: name, line: 0, level: "WARN",
      message: "章の状態差分に「開始状態:」がありません",
    })
  }
  if !content.contains("終了状態:") {
    violations.push({
      file: name, line: 0, level: "WARN",
      message: "章の状態差分に「終了状態:」がありません",
    })
  }
  violations
}

// ---------------------------------------------------------------------------
// ルール: 知識の先取り
// ---------------------------------------------------------------------------

///|
/// キャラクターが入手前の知識を使っていないこと。
///
/// 根拠: commit a3c8f50 — ch4で主人公が未入手の「15年」を使っていた
fn rule_knowledge_no_premature_use(
  file_path : String,
  lines : Array[String],
  timeline : Array[KnowledgeEntry],
) -> Array[Violation] {
  let violations : Array[Violation] = []
  let name = @path.basename(file_path)
  let ch_num = chapter_num_from_name(name)
  if ch_num < 0 {
    return violations
  }
  // テキスト行を抽出（コメント行を除外）
  let text_lines : Array[(Int, String)] = []
  for i, line in lines {
    let trimmed = line.trim().to_string()
    if trimmed.has_prefix("//") {
      continue
    }
    let text_start = str_find(line, "text: \"")
    if text_start >= 0 {
      let after_quote = text_start + 7
      let remaining = line[after_quote:].to_string()
      let end_quote = str_rfind(remaining, "\"")
      if end_quote > 0 {
        let text = remaining[:end_quote].to_string()
        text_lines.push((i + 1, text))
      }
    }
  }
  for _, entry in timeline {
    if entry.keywords.is_empty() {
      continue
    }
    let entry_ch = chapter_num_from_name("scenario_" + entry.chapter + ".mbt")
    if ch_num >= entry_ch {
      continue
    }
    for _, keyword in entry.keywords {
      for _, item in text_lines {
        let (line_num, text) = item
        if text.contains(keyword) {
          violations.push({
            file: name,
            line: line_num,
            level: "ERROR",
            message: "知識先取り: 「" + keyword + "」は " + entry.chapter + "_" +
              entry.scene + " で入手する情報。ch" + ch_num.to_string() +
              " では使用不可（" + entry.info + "）",
          })
        }
      }
    }
  }
  violations
}

// ---------------------------------------------------------------------------
// 知識タイムライン読み込み
// ---------------------------------------------------------------------------

///|
fn load_timeline(timeline_path : String) -> Array[KnowledgeEntry] {
  let entries : Array[KnowledgeEntry] = []
  if !@fs.existsSync(timeline_path) {
    return entries
  }
  let content = read_file(timeline_path)
  if content.is_empty() {
    return entries
  }
  let raw_lines = split_to_array(content, "\n")
  for _, line in raw_lines {
    let trimmed = line.trim().to_string()
    if trimmed.is_empty() || trimmed.has_prefix("#") {
      continue
    }
    let info = extract_json_string(trimmed, "info")
    let chapter = extract_json_string(trimmed, "chapter")
    let scene = extract_json_string(trimmed, "scene")
    let keywords = extract_json_string_array(trimmed, "keywords")
    if !chapter.is_empty() {
      entries.push({ info, chapter, scene, keywords })
    }
  }
  entries
}

///|
fn extract_json_string(json : String, key : String) -> String {
  let needle = "\"" + key + "\":\""
  let start = str_find(json, needle)
  if start < 0 {
    return ""
  }
  let val_start = start + needle.length()
  let remaining = json[val_start:].to_string()
  let end = str_find(remaining, "\"")
  if end < 0 {
    return ""
  }
  remaining[:end].to_string()
}

///|
fn extract_json_string_array(json : String, key : String) -> Array[String] {
  let result : Array[String] = []
  let needle = "\"" + key + "\":["
  let start = str_find(json, needle)
  if start < 0 {
    return result
  }
  let arr_start = start + needle.length()
  let remaining = json[arr_start:].to_string()
  let end = str_find(remaining, "]")
  if end < 0 {
    return result
  }
  let arr_content = remaining[:end].to_string()
  let parts = split_to_array(arr_content, ",")
  for _, part in parts {
    let trimmed = part.trim().to_string().trim(chars="\"").to_string()
    if !trimmed.is_empty() {
      result.push(trimmed)
    }
  }
  result
}

// ---------------------------------------------------------------------------
// 全章一貫性チェック
// ---------------------------------------------------------------------------

///|
fn lint_uniformity(all_paths : Array[String]) -> Array[Violation] {
  let violations : Array[Violation] = []
  let without_state : Array[String] = []
  let mut has_any_state = false
  let without_diff : Array[String] = []
  let mut has_any_diff = false
  for _, p in all_paths {
    let content = read_file(p)
    if content.is_empty() {
      continue
    }
    let name = @path.basename(p)
    let has_scenes = content.contains("// --- Scene")
    if has_scenes && content.contains("// 前提:") {
      has_any_state = true
    } else if has_scenes {
      without_state.push(name)
    }
    if content.contains("章の状態差分") {
      has_any_diff = true
    } else {
      without_diff.push(name)
    }
  }
  if has_any_state && !without_state.is_empty() {
    violations.push({
      file: "(全体)",
      line: 0,
      level: "WARN",
      message: "シーン状態コメントが不統一。以下の章に「// 前提:」がない: " +
        without_state.join(", "),
    })
  }
  if has_any_diff && !without_diff.is_empty() {
    violations.push({
      file: "(全体)",
      line: 0,
      level: "WARN",
      message: "章ヘッダーが不統一。以下の章に「章の状態差分」がない: " +
        without_diff.join(", "),
    })
  }
  violations
}

// ---------------------------------------------------------------------------
// ルール: 会話密度
// ---------------------------------------------------------------------------

///|
/// シーンごとの会話比率が目標値（55%以上）を満たしているか。
///
/// 根拠: ADVリサーチ — 現状15-20%で小説寄り。ADV標準65-75%に合わせ、
/// 目標70%。文学的にしすぎず、キャラの会話で魅力を見せる。
/// 参考: 葵せきな 85-90%, 丸戸史明 65-70%, ADV標準 65-75%
fn rule_dialogue_ratio(
  file_path : String,
  lines : Array[String],
) -> Array[Violation] {
  let violations : Array[Violation] = []
  let name = @path.basename(file_path)
  // text行のうち speaker が空でないもの = 会話行
  let mut total_text = 0
  let mut dialogue_text = 0
  for _, line in lines {
    let trimmed = line.trim().to_string()
    if trimmed.has_prefix("//") {
      continue
    }
    // text: "..." を含む行 = テキストブロック
    if !line.contains("text:") {
      continue
    }
    total_text = total_text + 1
    // speaker: "" 以外（= 空でない speaker）が会話
    // speaker: "主人公" や speaker: "佐倉美月" 等
    if line.contains("speaker:") && !line.contains("speaker: \"\"") {
      dialogue_text = dialogue_text + 1
    }
  }
  if total_text >= 10 {
    // 10行未満のシーンは比率チェックしない（ch0_s0のようなプロローグ）
    let ratio = dialogue_text * 100 / total_text
    if ratio < 65 {
      violations.push({
        file: name,
        line: 0,
        level: "WARN",
        message: "会話比率が低い: " + ratio.to_string() + "% （目標70%、最低65%）。" +
          "会話行" + dialogue_text.to_string() + "/" + total_text.to_string() +
          "行。キャラの掛け合いを追加して魅力を見せること",
      })
    }
  }
  violations
}

// ---------------------------------------------------------------------------
// ルール: 登場キャラの無言検出
// ---------------------------------------------------------------------------

///|
/// 章のコメントに登場キャラとして記載されているのにセリフが0行のキャラを検出。
///
/// 根拠: ADVリサーチ — 佐倉がch2/ch3/ch5/ch7で完全に無言。
/// 登場するならセリフか非言語リアクションを最低1つ入れるべき。
fn rule_silent_characters(
  file_path : String,
  lines : Array[String],
  content : String,
) -> Array[Violation] {
  let violations : Array[Violation] = []
  let name = @path.basename(file_path)
  // 既知のキャラクター名リスト（定食屋「灯」版）
  // speaker名「ひより」とテキスト中の「椎名」両方で検出する
  let characters = [
    "ひより", "椎名",
  ]
  for _, chara in characters {
    // このキャラがテキスト行（ナレーション含む）に名前で言及されているか
    let mentioned_in_text = content.contains(chara)
    if !mentioned_in_text {
      continue
    }
    // このキャラがspeakerとしてセリフを持っているか
    let has_dialogue = content.contains("speaker: \"" + chara)
    // ？？？としてのセリフもチェック（ch0の佐倉）
    let has_mystery_dialogue = content.contains("speaker: \"？？？\"")
    if !has_dialogue && !has_mystery_dialogue {
      // ナレーション内で名前が出ているが、セリフがない
      violations.push({
        file: name,
        line: 0,
        level: "WARN",
        message: "「" + chara + "」が登場しているがセリフが0行。" +
          "小さな一言（感想、注文、相槌）か非言語リアクション描写を追加すること",
      })
    }
  }
  // 主人公のセリフが少なすぎる場合もチェック
  // 主人公の speaker 名は「主人公」ま��は「悠」（デフォルト名）
  let mut protagonist_lines = 0
  for _, line in lines {
    if line.contains("speaker: \"主人公\"") || line.contains("speaker: \"晴\"") {
      protagonist_lines = protagonist_lines + 1
    }
  }
  if protagonist_lines == 0 {
    violations.push({
      file: name,
      line: 0,
      level: "WARN",
      message: "主人公のセリフが0行。主人公にも会話参加させること",
    })
  }
  violations
}

// ---------------------------------------------------------------------------
// ルール: キャラ好感度キラー検出
// ---------------------------------------------------------------------------

///|
/// 同一キャラによるマイナス評価語の集中使用を検出。
/// 3回以上のマイナス評価語が行動プラスのフォローなしに使われていると警告。
///
/// 根拠: character-appealスキル — 読者はキャラのマイナス言動が蓄積すると好感を持てない。
/// 「まずい」路線をやめて「無反応」に変更した設計判断もこのルールから生まれた。
fn rule_negative_evaluation_density(
  file_path : String,
  lines : Array[String],
) -> Array[Violation] {
  let violations : Array[Violation] = []
  let name = @path.basename(file_path)
  // マイナス評価語リスト
  let negative_words = [
    "まずい", "ダメ", "下手", "つまらない", "ひどい", "最悪", "嫌い", "無理",
    "才能ない", "向いてない", "やめたら",
  ]
  // キャラごとのマイナス評価カウント
  let characters = ["ひより", "椎名"]
  for _, chara in characters {
    let mut neg_count = 0
    for _, line in lines {
      // このキャラのセリフ行か確認
      if !line.contains("speaker: \"" + chara) {
        continue
      }
      // テキスト内容を抽出
      let text_start = str_find(line, "text: \"")
      if text_start < 0 {
        continue
      }
      let after_quote = text_start + 7
      let remaining = line[after_quote:].to_string()
      let end_quote = str_rfind(remaining, "\"")
      if end_quote <= 0 {
        continue
      }
      let text = remaining[:end_quote].to_string()
      // マイナス評価語を含むか
      for _, neg in negative_words {
        if text.contains(neg) {
          neg_count = neg_count + 1
        }
      }
    }
    if neg_count >= 3 {
      violations.push({
        file: name,
        line: 0,
        level: "WARN",
        message: "「" + chara + "」のマイナス評価語が" + neg_count.to_string() +
          "回。読者の好感度が下がるリスク。行動のプラス（助ける、来続ける等）でフォローすること",
      })
    }
  }
  violations
}

// ---------------------------------------------------------------------------
// ルール: ナレーション連続検出
// ---------------------------------------------------------------------------

///|
/// speaker:"" のナレーション行が N行以上連続していたら警告。
/// ADVは会話中心。長いナレーション連続は読者のテンポを落とす。
///
/// 根拠: scenario-writingスキル — 会話比率70%目標。
/// ナレーション連続は「小説寄り」の兆候。5行以上で読者が飽きるリスク。
fn rule_narration_streak(
  file_path : String,
  lines : Array[String],
) -> Array[Violation] {
  let violations : Array[Violation] = []
  let name = @path.basename(file_path)
  let threshold = 5
  let mut streak = 0
  let mut streak_start = 0
  for i, line in lines {
    let trimmed = line.trim().to_string()
    if trimmed.has_prefix("//") || !line.contains("text:") {
      continue
    }
    // speaker: "" = ナレーション行
    if line.contains("speaker: \"\"") {
      if streak == 0 {
        streak_start = i + 1
      }
      streak = streak + 1
    } else {
      if streak >= threshold {
        violations.push({
          file: name,
          line: streak_start,
          level: "WARN",
          message: "ナレーションが" + streak.to_string() + "行連続（L" +
            streak_start.to_string() + "〜）。会話や仕草の挿入でテンポを改善すること",
        })
      }
      streak = 0
    }
  }
  // ファイル末尾での連続もチェック
  if streak >= threshold {
    violations.push({
      file: name,
      line: streak_start,
      level: "WARN",
      message: "ナレーションが" + streak.to_string() + "行連続（L" +
        streak_start.to_string() + "〜）。会話や仕草の挿入でテンポを改善すること",
    })
  }
  violations
}

// ---------------------------------------------------------------------------
// ルール: モノローグ連続検出
// ---------------------------------------------------------------------------

///|
/// 主人公の内心モノローグ（（）で囲まれたテキスト）が3行以上連続していたら警告。
/// CLAUDE.md方針:「重い内省を減らし、掛け合い中心で」に基づく。
///
/// 根拠: 主人公は明るいツッコミ型。長い内省はキャラ性に合わない。
/// 3行以上の連続モノローグは掛け合いに置き換えるべき。
fn rule_monologue_streak(
  file_path : String,
  lines : Array[String],
) -> Array[Violation] {
  let violations : Array[Violation] = []
  let name = @path.basename(file_path)
  let threshold = 3
  let mut streak = 0
  let mut streak_start = 0
  for i, line in lines {
    let trimmed = line.trim().to_string()
    if trimmed.has_prefix("//") || !line.contains("text:") {
      continue
    }
    // 主人公のセリフかつ（）で囲まれたモノローグ
    // 主人公の speaker 名は「主人公」または「晴」（デフォルト名: 高瀬晴）
    let is_protagonist = line.contains("speaker: \"主人公\"") || line.contains(
        "speaker: \"晴\"",
      )
    let is_monologue = line.contains("text: \"（") || line.contains("text: \"(")
    if is_protagonist && is_monologue {
      if streak == 0 {
        streak_start = i + 1
      }
      streak = streak + 1
    } else {
      if streak >= threshold {
        violations.push({
          file: name,
          line: streak_start,
          level: "WARN",
          message: "主人公モノローグが" + streak.to_string() + "行連続（L" +
            streak_start.to_string() + "〜）。掛け合い中心の方針に合わせ、" +
            "会話や行動に置き換えること",
        })
      }
      streak = 0
    }
  }
  if streak >= threshold {
    violations.push({
      file: name,
      line: streak_start,
      level: "WARN",
      message: "主人公モノローグが" + streak.to_string() + "行連続（L" +
        streak_start.to_string() + "〜）。掛け合い中心の方針に合わせ、" +
        "会話や行動に置き換えること",
    })
  }
  violations
}

// ---------------------------------------------------------------------------
// メイン
// ---------------------------------------------------------------------------

///|
fn lint_file(
  file_path : String,
  timeline : Array[KnowledgeEntry],
) -> Array[Violation] {
  let content = read_file(file_path)
  if content.is_empty() {
    return []
  }
  let lines = split_to_array(content, "\n")
  let violations : Array[Violation] = []
  violations.append(rule_scene_state_comments(file_path, lines))
  violations.append(rule_chapter_state_diff(file_path, content))
  violations.append(rule_knowledge_no_premature_use(file_path, lines, timeline))
  violations.append(rule_dialogue_ratio(file_path, lines))
  violations.append(rule_silent_characters(file_path, lines, content))
  violations.append(rule_negative_evaluation_density(file_path, lines))
  violations.append(rule_narration_streak(file_path, lines))
  violations.append(rule_monologue_streak(file_path, lines))
  violations
}

///|
fn main {
  let args = @process.argv()
  if args.length() < 3 {
    println("Usage: node lint.js <scenario_ch*.mbt ...>")
    @process.exit(1)
  }
  let script_dir = @path.dirname(args[1])
  let project_root = @path.resolve([script_dir, "../../.."])
  let timeline_path = @path.join([project_root, "src/data/knowledge-timeline.jsonl"])
  let timeline = load_timeline(timeline_path)
  let paths : Array[String] = []
  for i = 2; i < args.length(); i = i + 1 {
    let arg = args[i]
    if arg.contains("scenario_ch") && arg.contains(".mbt") {
      paths.push(@path.resolve([arg]))
    }
  }
  if paths.is_empty() {
    println("No scenario_ch*.mbt files specified.")
    @process.exit(1)
  }
  let scenario_dir = @path.dirname(paths[0])
  let all_files : Array[String] = try {
    @fs.readdirSync(scenario_dir)
  } catch {
    _ => []
  }
  let all_paths : Array[String] = []
  for _, f in all_files {
    if f.contains("scenario_ch") && f.contains(".mbt") {
      all_paths.push(@path.join([scenario_dir, f]))
    }
  }
  all_paths.sort()
  let all_violations : Array[Violation] = []
  let ok_files : Array[String] = []
  for _, file_path in paths {
    let violations = lint_file(file_path, timeline)
    if !violations.is_empty() {
      for _, v in violations {
        println(format_violation(v))
      }
      all_violations.append(violations)
    } else {
      ok_files.push(@path.basename(file_path))
    }
  }
  let uniformity_violations = lint_uniformity(all_paths)
  for _, v in uniformity_violations {
    println(format_violation(v))
  }
  all_violations.append(uniformity_violations)
  for _, name in ok_files {
    println("[OK] " + name + " — 全チェック通過")
  }
  println("")
  println("--- リント結果サマリー ---")
  println("ファイル数: " + paths.length().to_string())
  println("ルール数: 9")
  let mut error_count = 0
  let mut warn_count = 0
  for _, v in all_violations {
    if v.level == "ERROR" {
      error_count = error_count + 1
    } else {
      warn_count = warn_count + 1
    }
  }
  if !all_violations.is_empty() {
    println(
      "違反: " + error_count.to_string() + " ERROR, " + warn_count.to_string() +
      " WARN",
    )
    println("")
    println("修正後に再度実行: npm run lint:scenario")
    @process.exit(1)
  } else {
    println("違反: 0件")
  }
}
