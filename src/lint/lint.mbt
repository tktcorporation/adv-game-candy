///|
/// シナリオリンター — scenario_ch*.mbt の構造的整合性を検証する（MoonBit版）
///
/// 使い方:
///   moon build --target js && node target/js/release/build/lint/lint.js src/data/scenario_ch*.mbt
///
/// ファイル構成:
///   lint.mbt          — 型定義・ユーティリティ・メイン
///   lint_rules.mbt    — 各ルール関数の実装
///   lint_timeline.mbt — 知識タイムライン読込・全章一貫性チェック

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
// ファイル単位リント
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

// ---------------------------------------------------------------------------
// メイン
// ---------------------------------------------------------------------------

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
