// リントルール — 各ルール関数の実装
//
// ルール一覧:
//   rule_scene_state_comments      — シーン状態コメント必須
//   rule_chapter_state_diff        — 章ヘッダー状態差分必須
//   rule_knowledge_no_premature_use — 知識の先取り検出
//   rule_dialogue_ratio            — 会話密度チェック
//   rule_silent_characters         — 登場キャラの無言検出
//   rule_negative_evaluation_density — キャラ好感度キラー検出
//   rule_narration_streak          — ナレーション連続検出
//   rule_monologue_streak          — モノローグ連続検出

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
  let characters = [
    "ひより",
  ]
  for _, chara in characters {
    let mentioned_in_text = content.contains(chara)
    if !mentioned_in_text {
      continue
    }
    let has_dialogue = content.contains("speaker: \"" + chara)
    let has_mystery_dialogue = content.contains("speaker: \"？？？\"")
    if !has_dialogue && !has_mystery_dialogue {
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
fn rule_negative_evaluation_density(
  file_path : String,
  lines : Array[String],
) -> Array[Violation] {
  let violations : Array[Violation] = []
  let name = @path.basename(file_path)
  let negative_words = [
    "まずい", "ダメ", "下手", "つまらない", "ひどい", "最悪", "嫌い", "無理",
    "才能ない", "向いてない", "やめたら",
  ]
  let characters = ["ひより"]
  for _, chara in characters {
    let mut neg_count = 0
    for _, line in lines {
      if !line.contains("speaker: \"" + chara) {
        continue
      }
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
///
/// 根拠: scenario-writingスキル — 会話比率70%目標。
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
