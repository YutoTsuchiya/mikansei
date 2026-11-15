*start

[eval exp="f.low = 1; f.high = 1000; f.turn = 0; f.guess = 0"]
[cm]
数字当てゲーム[p]
1から1000までの整数をひとつ、心の中で決めてください。[l]
こちらが10回以内に当てます。[l]
予想に対して「もっと大きい」「もっと小さい」「正解！」で答えてください。[l]
[link target=*guess]ゲーム開始[endlink][s]

*guess
[eval exp="f.turn += 1; f.guess = Math.floor((f.low + f.high) / 2)"]
[cm]
第&f.turn 回目の予想です。[l]
あなたの数字は「&f.guess」ですか？[l]
[link target=*correct]正解！[endlink][r]
[link target=*too_high]もっと大きい[endlink][r]
[link target=*too_low]もっと小さい[endlink][s]

*too_high
[eval exp="f.low = f.guess + 1; f.next = (f.low > f.high) ? '*inconsistent' : (f.turn >= 10 ? '*failed' : '*guess')"]
[jump target="&f.next"]

*too_low
[eval exp="f.high = f.guess - 1; f.next = (f.low > f.high) ? '*inconsistent' : (f.turn >= 10 ? '*failed' : '*guess')"]
[jump target="&f.next"]

*correct
[cm]
やった！&f.turn 回で当たりました。[p]
二分法なら、1000個の候補も10回以内で絞り込めます。[l]
[link target=*start]もう一度遊ぶ[endlink][s]

*failed
[cm]
10回以内に当てられませんでした。[p]
答えは&f.low から&f.high のどこかだったはずです。[l]
[link target=*start]もう一度遊ぶ[endlink][s]

*inconsistent
[cm]
答えが候補の範囲から外れてしまいました。[p]
「もっと大きい／もっと小さい」の答えが途中で食い違ったようです。[l]
[link target=*start]もう一度遊ぶ[endlink][s]
