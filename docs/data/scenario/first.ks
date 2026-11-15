*start
[cm]
[iscript]
$(".title_logo").remove();
$(".layer_free").empty().hide();
[endscript]
[layopt layer="message0" visible="true"]
[bg storage="read-meter-title.png" time="1200"]
[wait time="300"]
[iscript]
var title = $("<div class='title_logo'></div>").text("読む速度を測ろう").css({
    position: "absolute", left: "80px", top: "285px", zIndex: 2147483647,
    color: "#fff0d3", fontFamily: "sans-serif", fontSize: "70px", fontWeight: "bold",
    lineHeight: "1.25", textShadow: "2px 3px 8px #101a35", whiteSpace: "nowrap"
});
title.hide();
$("#tyrano_base").append(title);
title.fadeIn(900);
[endscript]
[wait time="950"]
[link target=*menu] > はじめる [endlink][s]

*menu
[cm]
[iscript]
$(".title_logo").remove();
[endscript]
読みたい文章を選んでください。[r]
[link target=*pick1] > ギリシャ神話 [endlink][r]
[link target=*pick2] > 経済 [endlink][r]
[link target=*pick3] > 渡辺研 [endlink][s]

*pick1
[cm]
[eval exp="f.article_id = 1; f.article_title = 'ギリシャ神話'; f.quiz_label = '*quiz1'"]
[jump target=*load_article]

*pick2
[cm]
[eval exp="f.article_id = 2; f.article_title = '経済'; f.quiz_label = '*quiz2'"]
[jump target=*load_article]

*pick3
[cm]
[eval exp="f.article_id = 3; f.article_title = '渡辺研'; f.quiz_label = '*quiz3'"]
[jump target=*load_article]

*load_article
[cm]
[iscript]
$.loadText("./data/text" + f.article_id + ".txt", function(text) {
    f.article_text = text.replace(/\r\n?/g, "\n").trim();
    f.char_count = Array.from(f.article_text.replace(/\s/g, "")).length;
    TYRANO.kag.ftag.nextOrderWithLabel("show_article");
});
[endscript stop="true"]

*show_article
[cm]
タイトル：[emb exp="f.article_title"][r]
本文：[emb exp="f.char_count"]文字です。[r]
[link target=*begin_read] > 読み始める [endlink][s]

*begin_read
[cm]
[eval exp="f.started_at = Date.now()"]
[iscript]
var host = TYRANO.kag.layer.getFreeLayer();
host.empty().show().css({"z-index": "999999", "background": "rgba(4, 10, 22, 0.92)"});

var panel = $("<div></div>").css({
    position: "absolute", left: "60px", top: "35px", width: "1160px", height: "535px",
    overflowY: "auto", boxSizing: "border-box", padding: "28px 42px",
    color: "#f6f0e6", background: "rgba(20, 29, 45, 0.96)",
    border: "1px solid rgba(224, 190, 130, 0.7)", borderRadius: "12px",
    fontFamily: "sans-serif", fontSize: "24px", lineHeight: "1.85",
    whiteSpace: "pre-wrap", overflowWrap: "anywhere",
    WebkitOverflowScrolling: "touch"
});
var heading = $("<div></div>").text(f.article_title).css({
    color: "#ffe0a6", fontSize: "32px", fontWeight: "bold", marginBottom: "12px"
});
var count = $("<div></div>").text("本文 " + f.char_count + " 文字").css({
    color: "#bdc9dc", fontSize: "16px", marginBottom: "18px"
});
var body = $("<div></div>").text(f.article_text);
panel.append(heading, count, body);

var finish = $("<button type='button'></button>").text("> 読み終わった").css({
    position: "absolute", left: "490px", top: "600px", width: "300px", height: "62px",
    border: "1px solid #f0cf8b", borderRadius: "10px", background: "#24334d",
    color: "#fff0d3", fontSize: "24px", fontWeight: "bold", cursor: "pointer"
});
finish.on("click", function() {
    host.empty().hide();
    TYRANO.kag.ftag.nextOrderWithLabel("read_done");
});
host.append(panel, finish);
[endscript]
[s]

*read_done
[cm]
[eval exp="f.elapsed_ms = Math.max(1000, Date.now() - f.started_at); f.elapsed_sec = Math.round(f.elapsed_ms / 1000); f.moji_per_min = Math.round(f.char_count * 60000 / f.elapsed_ms); f.next = f.quiz_label"]
[jump target="&f.next"]

*quiz1
[cm]
内容クイズ：ゼウスは、クロノスに飲み込まれずに済んだのは誰のおかげですか？[r]
[link target=*answer_correct] > 母レア [endlink][r]
[link target=*answer_wrong] > スパルタ王妃ヘレネ [endlink][r]
[link target=*answer_wrong] > 女神アテナ [endlink][s]

*quiz2
[cm]
内容クイズ：文章で説明されていた「比較優位」の基準は何ですか？[r]
[link target=*answer_correct] > より小さな機会費用で生産できること [endlink][r]
[link target=*answer_wrong] > どの財も相手より多く生産できること [endlink][r]
[link target=*answer_wrong] > すべての財を同じ価格で売ること [endlink][s]

*quiz3
[cm]
内容クイズ：渡辺研究室では、スパコンの計算能力を主にどの方向に使ってきましたか？[r]
[link target=*answer_correct] > 扱う粒子の数を増やす [endlink][r]
[link target=*answer_wrong] > 計算を使わず手作業だけで研究する [endlink][r]
[link target=*answer_wrong] > 計算機の台数を減らす [endlink][s]

*answer_correct
[cm]
[eval exp="f.answer_correct = true"]
[jump target=*results]

*answer_wrong
[cm]
[eval exp="f.answer_correct = false"]
[jump target=*results]

*results
[cm]
[if exp="f.answer_correct"]
内容クイズ：正解です。[r]
[else]
内容クイズ：不正解です。[r]
[endif]
タイトル：[emb exp="f.article_title"][r]
本文の文字数：[emb exp="f.char_count"]文字[r]
読了時間：[emb exp="f.elapsed_sec"]秒[r]
読書速度：[emb exp="f.moji_per_min"]文字/分[r]
[link target=*menu] > 別の文章を読む [endlink][s]
