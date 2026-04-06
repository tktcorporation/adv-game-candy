// 知識タイムライン読み込み・全章一貫性チェック
//
// knowledge-timeline.jsonl からキャラの知識獲得タイムラインを読み込み、
// 全章ファイルの一貫性（状態コメント・章ヘッダーの有無）をチェックする。

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
