*start
[cm]
[iscript]
$(".title_logo").remove();
$(".layer_free").empty().hide();
$(".reader_screen").remove();
window.showReaderChoices = function(titleText, choices) {
    var screen = $("<div class='reader_screen'></div>").css({
        position: "fixed", inset: "0", width: "100vw", height: "100vh", zIndex: 2147483647,
        display: "flex", flexDirection: "column", justifyContent: "center", alignItems: "center",
        boxSizing: "border-box", gap: "16px", padding: "24px",
        background: "linear-gradient(145deg, #101a2d, #263c56)", color: "#fff0d3", fontFamily: "sans-serif"
    });
    var heading = $("<h1></h1>").text(titleText).css({
        width: "min(90vw, 760px)", margin: "0 0 12px", textAlign: "center",
        fontSize: "clamp(1.4rem, 5vw, 2.3rem)", lineHeight: "1.5", whiteSpace: "pre-line"
    });
    screen.append(heading);
    choices.forEach(function(choice) {
        var button = $("<button type='button'></button>").text("> " + choice[0]).css({
            width: "min(90vw, 760px)", minHeight: "58px", padding: "12px 18px",
            border: "1px solid #f0cf8b", borderRadius: "10px", background: "#24334d",
            color: "#fff0d3", fontSize: "clamp(1.1rem, 4vw, 1.4rem)", lineHeight: "1.4", cursor: "pointer"
        });
        button.on("click", function() { screen.remove(); TYRANO.kag.ftag.nextOrderWithLabel(choice[1]); });
        screen.append(button);
    });
    screen.appendTo("body");
};
[endscript]
[iscript]
var titleScreen = $("<div class='reader_screen'></div>").css({
    position: "fixed", inset: "0", width: "100vw", height: "100vh", zIndex: 2147483647,
    display: "flex", flexDirection: "column", justifyContent: "center", alignItems: "center",
    boxSizing: "border-box", padding: "24px", textAlign: "center",
    background: "linear-gradient(rgba(5,12,28,.28), rgba(5,12,28,.68)), url('./data/bgimage/read-meter-title.png') center / cover no-repeat",
    fontFamily: "sans-serif"
});
var title = $("<h1></h1>").text("読む速度を測ろう").css({
    margin: "0 0 36px", color: "#fff0d3", fontSize: "clamp(2.2rem, 8vw, 4.6rem)",
    fontWeight: "bold", lineHeight: "1.35", textShadow: "2px 3px 8px #101a35"
});
var startButton = $("<button type='button'></button>").text("> はじめる").css({
    minWidth: "min(72vw, 320px)", minHeight: "64px", padding: "14px 28px",
    border: "2px solid #f0cf8b", borderRadius: "12px", background: "rgba(36,51,77,.94)",
    color: "#fff0d3", fontSize: "clamp(1.25rem, 4vw, 1.7rem)", fontWeight: "bold", cursor: "pointer"
});
startButton.on("click", function() { titleScreen.remove(); TYRANO.kag.ftag.nextOrderWithLabel("menu"); });
titleScreen.append(title, startButton).appendTo("body");
[endscript]
[s]

*menu
[cm]
[iscript]
$(".reader_screen").remove();
var menuScreen = $("<div class='reader_screen'></div>").css({
    position: "fixed", inset: "0", width: "100vw", height: "100vh", zIndex: 2147483647,
    display: "flex", flexDirection: "column", justifyContent: "center", alignItems: "center",
    boxSizing: "border-box", gap: "18px", padding: "24px",
    background: "linear-gradient(145deg, #101a2d, #263c56)", color: "#fff0d3", fontFamily: "sans-serif"
});
var menuTitle = $("<h1></h1>").text("読みたい文章を選んでください").css({
    margin: "0 0 12px", textAlign: "center", fontSize: "clamp(1.5rem, 6vw, 2.5rem)", lineHeight: "1.4"
});
menuScreen.append(menuTitle);
[["ギリシャ神話", "pick1"], ["経済", "pick2"], ["渡辺研", "pick3"]].forEach(function(item) {
    var button = $("<button type='button'></button>").text("> " + item[0]).css({
        width: "min(88vw, 420px)", minHeight: "60px", padding: "12px 20px",
        border: "1px solid #f0cf8b", borderRadius: "10px", background: "#24334d",
        color: "#fff0d3", fontSize: "clamp(1.2rem, 4vw, 1.5rem)", cursor: "pointer"
    });
    button.on("click", function() { menuScreen.remove(); TYRANO.kag.ftag.nextOrderWithLabel(item[1]); });
    menuScreen.append(button);
});
menuScreen.appendTo("body");
[endscript]
[s]

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
[iscript]
window.showReaderChoices(f.article_title + " ・ 本文 " + f.char_count + " 文字", [["読み始める", "begin_read"]]);
[endscript]
[s]

*begin_read
[cm]
[eval exp="f.started_at = Date.now()"]
[iscript]
var host = TYRANO.kag.layer.getFreeLayer();
host.empty().hide();
var readingScreen = $("<div class='reader_screen'></div>").css({
    position: "fixed", inset: "0", width: "100vw", height: "100vh", zIndex: 2147483647,
    display: "flex", flexDirection: "column", boxSizing: "border-box", gap: "12px",
    padding: "max(14px, env(safe-area-inset-top)) max(14px, env(safe-area-inset-right)) max(14px, env(safe-area-inset-bottom)) max(14px, env(safe-area-inset-left))",
    background: "rgba(4, 10, 22, 0.97)", fontFamily: "sans-serif"
}).appendTo("body");
readingScreen.css("height", "100dvh");

var panel = $("<div class='reader_article_panel'></div>").css({
    position: "relative", width: "100%", flex: "1 1 auto", minHeight: "0",
    overflowY: "scroll", overscrollBehavior: "contain", touchAction: "pan-y",
    boxSizing: "border-box", padding: "clamp(16px, 4vw, 32px)", paddingBottom: "90px",
    color: "#f6f0e6", background: "rgba(20, 29, 45, 0.96)",
    border: "1px solid rgba(224, 190, 130, 0.7)", borderRadius: "12px",
    fontFamily: "sans-serif", fontSize: "clamp(18px, 2.5vh, 24px)", lineHeight: "1.8",
    whiteSpace: "pre-wrap", overflowWrap: "anywhere",
    WebkitOverflowScrolling: "touch", WebkitTouchCallout: "none"
});
// TyranoScript が document/body の touchmove を preventDefault するため、
// 本文内のスワイプだけは祖先へ伝えず、ブラウザ標準のスクロールを残す。
panel.on("touchmove", function(event) { event.stopPropagation(); });
var heading = $("<div></div>").text(f.article_title).css({
    color: "#ffe0a6", fontSize: "clamp(24px, 4vh, 32px)", fontWeight: "bold", marginBottom: "12px"
});
var count = $("<div></div>").text("本文 " + f.char_count + " 文字").css({
    color: "#bdc9dc", fontSize: "16px", marginBottom: "18px"
});
var body = $("<div></div>").text(f.article_text);
panel.append(heading, count, body);

var finish = $("<button type='button'></button>").text("> 読み終わった").css({
    display: "block", position: "fixed", zIndex: 2147483647,
    left: "50%", bottom: "max(14px, env(safe-area-inset-bottom))", transform: "translateX(-50%)",
    width: "min(90vw, 360px)", minHeight: "60px",
    border: "1px solid #f0cf8b", borderRadius: "10px", background: "#24334d",
    color: "#fff0d3", fontSize: "clamp(18px, 3vh, 24px)", fontWeight: "bold", cursor: "pointer"
});
finish.on("click", function() {
    readingScreen.remove();
    TYRANO.kag.ftag.nextOrderWithLabel("read_done");
});
readingScreen.append(panel, finish);
[endscript]
[s]

*read_done
[cm]
[eval exp="f.elapsed_ms = Math.max(1000, Date.now() - f.started_at); f.elapsed_sec = Math.round(f.elapsed_ms / 1000); f.moji_per_min = Math.round(f.char_count * 60000 / f.elapsed_ms); f.next = f.quiz_label"]
[jump target="&f.next"]

*quiz1
[cm]
[iscript]
window.showReaderChoices("ゼウスは、クロノスに飲み込まれずに済んだのは誰のおかげですか？", [["母レア", "answer_correct"], ["スパルタ王妃ヘレネ", "answer_wrong"], ["女神アテナ", "answer_wrong"]]);
[endscript]
[s]

*quiz2
[cm]
[iscript]
window.showReaderChoices("文章で説明されていた「比較優位」の基準は何ですか？", [["より小さな機会費用で生産できること", "answer_correct"], ["どの財も相手より多く生産できること", "answer_wrong"], ["すべての財を同じ価格で売ること", "answer_wrong"]]);
[endscript]
[s]

*quiz3
[cm]
[iscript]
window.showReaderChoices("渡辺研究室では、スパコンの計算能力を主にどの方向に使ってきましたか？", [["扱う粒子の数を増やす", "answer_correct"], ["計算を使わず手作業だけで研究する", "answer_wrong"], ["計算機の台数を減らす", "answer_wrong"]]);
[endscript]
[s]

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
[iscript]
var resultText = f.answer_correct ? "正解です" : "不正解です";
var resultSummary = resultText + "\n\n" + f.article_title + "\n本文 " + f.char_count + " 文字\n読了時間 " + f.elapsed_sec + " 秒\n読書速度 " + f.moji_per_min + " 文字/分";
window.showReaderChoices(resultSummary, [["別の文章を読む", "menu"]]);
[endscript]
[s]
