setlocal list
setlocal shiftwidth=4
setlocal softtabstop=4

function! Greekify()
	substitute/\C\<a\(\d*\)\>/α\1/eg
	substitute/\C\<b\(\d*\)\>/β\1/eg
	substitute/\C\<c\(\d*\)\>/γ\1/eg
	substitute/\C\<d\(\d*\)\>/δ\1/eg
	substitute/\C\<e\(\d*\)\>/ε\1/eg
	substitute/\C\<f\(\d*\)\>/ζ\1/eg
	substitute/\C\<g\(\d*\)\>/η\1/eg
	substitute/\C\<h\(\d*\)\>/θ\1/eg
	substitute/\C\<i\(\d*\)\>/ι\1/eg
	substitute/\C\<j\(\d*\)\>/κ\1/eg
	substitute/\C\<k\(\d*\)\>/λ\1/eg
	substitute/\C\<l\(\d*\)\>/μ\1/eg
	substitute/\C\<m\(\d*\)\>/ν\1/eg
	substitute/\C\<n\(\d*\)\>/ξ\1/eg
	substitute/\C\<o\(\d*\)\>/ο\1/eg
	substitute/\C\<p\(\d*\)\>/π\1/eg
	substitute/\C\<q\(\d*\)\>/ρ\1/eg
	substitute/\C\<r\(\d*\)\>/ς\1/eg
	substitute/\C\<s\(\d*\)\>/σ\1/eg
	substitute/\C\<t\(\d*\)\>/τ\1/eg
	substitute/\C\<u\(\d*\)\>/υ\1/eg
	substitute/\C\<v\(\d*\)\>/φ\1/eg
	substitute/\C\<w\(\d*\)\>/χ\1/eg
	substitute/\C\<x\(\d*\)\>/ψ\1/eg
	substitute/\C\<y\(\d*\)\>/ω\1/eg
endfunction

function! UnGreekify()
	substitute/\Cα/a/eg
	substitute/\Cβ/b/eg
	substitute/\Cγ/c/eg
	substitute/\Cδ/d/eg
	substitute/\Cε/e/eg
	substitute/\Cζ/f/eg
	substitute/\Cη/g/eg
	substitute/\Cθ/h/eg
	substitute/\Cι/i/eg
	substitute/\Cκ/j/eg
	substitute/\Cλ/k/eg
	substitute/\Cμ/l/eg
	substitute/\Cν/m/eg
	substitute/\Cξ/n/eg
	substitute/\Cο/o/eg
	substitute/\Cπ/p/eg
	substitute/\Cρ/q/eg
	substitute/\Cς/r/eg
	substitute/\Cσ/s/eg
	substitute/\Cτ/t/eg
	substitute/\Cυ/u/eg
	substitute/\Cφ/v/eg
	substitute/\Cχ/w/eg
	substitute/\Cψ/x/eg
	substitute/\Cω/y/eg
endfunction

function! Mathify()
	substitute/\C\<a\(\d*\)\>/𝑎\1/eg | substitute/\C\<as\(\d*\)\>/𝑎𝑠\1/eg | substitute/\C\<ass\(\d*\)\>/𝑎𝑠𝑠\1/eg
	substitute/\C\<b\(\d*\)\>/𝑏\1/eg | substitute/\C\<bs\(\d*\)\>/𝑏𝑠\1/eg | substitute/\C\<bss\(\d*\)\>/𝑏𝑠𝑠\1/eg
	substitute/\C\<c\(\d*\)\>/𝑐\1/eg | substitute/\C\<cs\(\d*\)\>/𝑐𝑠\1/eg | substitute/\C\<css\(\d*\)\>/𝑐𝑠𝑠\1/eg
	substitute/\C\<d\(\d*\)\>/𝑑\1/eg | substitute/\C\<ds\(\d*\)\>/𝑑𝑠\1/eg | substitute/\C\<dss\(\d*\)\>/𝑑𝑠𝑠\1/eg
	substitute/\C\<e\(\d*\)\>/𝑒\1/eg | substitute/\C\<es\(\d*\)\>/𝑒𝑠\1/eg | substitute/\C\<ess\(\d*\)\>/𝑒𝑠𝑠\1/eg
	substitute/\C\<f\(\d*\)\>/𝑓\1/eg | substitute/\C\<fs\(\d*\)\>/𝑓𝑠\1/eg | substitute/\C\<fss\(\d*\)\>/𝑓𝑠𝑠\1/eg
	substitute/\C\<g\(\d*\)\>/𝑔\1/eg | substitute/\C\<gs\(\d*\)\>/𝑔𝑠\1/eg | substitute/\C\<gss\(\d*\)\>/𝑔𝑠𝑠\1/eg
	substitute/\C\<h\(\d*\)\>/𝑕\1/eg | substitute/\C\<hs\(\d*\)\>/𝑕𝑠\1/eg | substitute/\C\<hss\(\d*\)\>/𝑕𝑠𝑠\1/eg
	substitute/\C\<i\(\d*\)\>/𝑖\1/eg | substitute/\C\<is\(\d*\)\>/𝑖𝑠\1/eg | substitute/\C\<iss\(\d*\)\>/𝑖𝑠𝑠\1/eg
	substitute/\C\<j\(\d*\)\>/𝑗\1/eg | substitute/\C\<js\(\d*\)\>/𝑗𝑠\1/eg | substitute/\C\<jss\(\d*\)\>/𝑗𝑠𝑠\1/eg
	substitute/\C\<k\(\d*\)\>/𝑘\1/eg | substitute/\C\<ks\(\d*\)\>/𝑘𝑠\1/eg | substitute/\C\<kss\(\d*\)\>/𝑘𝑠𝑠\1/eg
	substitute/\C\<l\(\d*\)\>/𝑙\1/eg | substitute/\C\<ls\(\d*\)\>/𝑙𝑠\1/eg | substitute/\C\<lss\(\d*\)\>/𝑙𝑠𝑠\1/eg
	substitute/\C\<m\(\d*\)\>/𝑚\1/eg | substitute/\C\<ms\(\d*\)\>/𝑚𝑠\1/eg | substitute/\C\<mss\(\d*\)\>/𝑚𝑠𝑠\1/eg
	substitute/\C\<n\(\d*\)\>/𝑛\1/eg | substitute/\C\<ns\(\d*\)\>/𝑛𝑠\1/eg | substitute/\C\<nss\(\d*\)\>/𝑛𝑠𝑠\1/eg
	substitute/\C\<o\(\d*\)\>/𝑜\1/eg | substitute/\C\<os\(\d*\)\>/𝑜𝑠\1/eg | substitute/\C\<oss\(\d*\)\>/𝑜𝑠𝑠\1/eg
	substitute/\C\<p\(\d*\)\>/𝑝\1/eg | substitute/\C\<ps\(\d*\)\>/𝑝𝑠\1/eg | substitute/\C\<pss\(\d*\)\>/𝑝𝑠𝑠\1/eg
	substitute/\C\<q\(\d*\)\>/𝑞\1/eg | substitute/\C\<qs\(\d*\)\>/𝑞𝑠\1/eg | substitute/\C\<qss\(\d*\)\>/𝑞𝑠𝑠\1/eg | substitute/\C\<qr\(\d*\)\>/𝑞𝑟\1/eg
	substitute/\C\<r\(\d*\)\>/𝑟\1/eg | substitute/\C\<rs\(\d*\)\>/𝑟𝑠\1/eg | substitute/\C\<rss\(\d*\)\>/𝑟𝑠𝑠\1/eg
	substitute/\C\<s\(\d*\)\>/𝑠\1/eg | substitute/\C\<ss\(\d*\)\>/𝑠𝑠\1/eg | substitute/\C\<sss\(\d*\)\>/𝑠𝑠𝑠\1/eg
	substitute/\C\<t\(\d*\)\>/𝑡\1/eg | substitute/\C\<ts\(\d*\)\>/𝑡𝑠\1/eg | substitute/\C\<tss\(\d*\)\>/𝑡𝑠𝑠\1/eg
	substitute/\C\<u\(\d*\)\>/𝑢\1/eg | substitute/\C\<us\(\d*\)\>/𝑢𝑠\1/eg | substitute/\C\<uss\(\d*\)\>/𝑢𝑠𝑠\1/eg
	substitute/\C\<v\(\d*\)\>/𝑣\1/eg | substitute/\C\<vs\(\d*\)\>/𝑣𝑠\1/eg | substitute/\C\<vss\(\d*\)\>/𝑣𝑠𝑠\1/eg
	substitute/\C\<w\(\d*\)\>/𝑤\1/eg | substitute/\C\<ws\(\d*\)\>/𝑤𝑠\1/eg | substitute/\C\<wss\(\d*\)\>/𝑤𝑠𝑠\1/eg
	substitute/\C\<x\(\d*\)\>/𝑥\1/eg | substitute/\C\<xs\(\d*\)\>/𝑥𝑠\1/eg | substitute/\C\<xss\(\d*\)\>/𝑥𝑠𝑠\1/eg
	substitute/\C\<y\(\d*\)\>/𝑦\1/eg | substitute/\C\<ys\(\d*\)\>/𝑦𝑠\1/eg | substitute/\C\<yss\(\d*\)\>/𝑦𝑠𝑠\1/eg
	substitute/\C\<z\(\d*\)\>/𝑧\1/eg | substitute/\C\<zs\(\d*\)\>/𝑧𝑠\1/eg | substitute/\C\<zss\(\d*\)\>/𝑧𝑠𝑠\1/eg
endfunction

function! UnMathify()
	substitute/\C𝑎/a/eg
	substitute/\C𝑏/b/eg
	substitute/\C𝑐/c/eg
	substitute/\C𝑑/d/eg
	substitute/\C𝑒/e/eg
	substitute/\C𝑓/f/eg
	substitute/\C𝑔/g/eg
	substitute/\C𝑕/h/eg
	substitute/\C𝑖/i/eg
	substitute/\C𝑗/j/eg
	substitute/\C𝑘/k/eg
	substitute/\C𝑙/l/eg
	substitute/\C𝑚/m/eg
	substitute/\C𝑛/n/eg
	substitute/\C𝑜/o/eg
	substitute/\C𝑝/p/eg
	substitute/\C𝑞/q/eg
	substitute/\C𝑟/r/eg
	substitute/\C𝑠/s/eg
	substitute/\C𝑡/t/eg
	substitute/\C𝑢/u/eg
	substitute/\C𝑣/v/eg
	substitute/\C𝑤/w/eg
	substitute/\C𝑥/x/eg
	substitute/\C𝑦/y/eg
	substitute/\C𝑧/z/eg
endfunction

function! Scriptify()
	substitute/\C\<a\(\d*\)\>/𝒶\1/eg | substitute/\C\<as\(\d*\)\>/𝒶𝓈\1/eg | substitute/\C\<ass\(\d*\)\>/𝒶𝓈𝓈\1/eg
	substitute/\C\<b\(\d*\)\>/𝒷\1/eg | substitute/\C\<bs\(\d*\)\>/𝒷𝓈\1/eg | substitute/\C\<bss\(\d*\)\>/𝒷𝓈𝓈\1/eg
	substitute/\C\<c\(\d*\)\>/𝒸\1/eg | substitute/\C\<cs\(\d*\)\>/𝒸𝓈\1/eg | substitute/\C\<css\(\d*\)\>/𝒸𝓈𝓈\1/eg
	substitute/\C\<d\(\d*\)\>/𝒹\1/eg | substitute/\C\<ds\(\d*\)\>/𝒹𝓈\1/eg | substitute/\C\<dss\(\d*\)\>/𝒹𝓈𝓈\1/eg
	substitute/\C\<e\(\d*\)\>/𝒺\1/eg | substitute/\C\<es\(\d*\)\>/𝒺𝓈\1/eg | substitute/\C\<ess\(\d*\)\>/𝒺𝓈𝓈\1/eg
	substitute/\C\<f\(\d*\)\>/𝒻\1/eg | substitute/\C\<fs\(\d*\)\>/𝒻𝓈\1/eg | substitute/\C\<fss\(\d*\)\>/𝒻𝓈𝓈\1/eg
	substitute/\C\<g\(\d*\)\>/𝒼\1/eg | substitute/\C\<gs\(\d*\)\>/𝒼𝓈\1/eg | substitute/\C\<gss\(\d*\)\>/𝒼𝓈𝓈\1/eg
	substitute/\C\<h\(\d*\)\>/𝒽\1/eg | substitute/\C\<hs\(\d*\)\>/𝒽𝓈\1/eg | substitute/\C\<hss\(\d*\)\>/𝒽𝓈𝓈\1/eg
	substitute/\C\<i\(\d*\)\>/𝒾\1/eg | substitute/\C\<is\(\d*\)\>/𝒾𝓈\1/eg | substitute/\C\<iss\(\d*\)\>/𝒾𝓈𝓈\1/eg
	substitute/\C\<j\(\d*\)\>/𝒿\1/eg | substitute/\C\<js\(\d*\)\>/𝒿𝓈\1/eg | substitute/\C\<jss\(\d*\)\>/𝒿𝓈𝓈\1/eg
	substitute/\C\<k\(\d*\)\>/𝓀\1/eg | substitute/\C\<ks\(\d*\)\>/𝓀𝓈\1/eg | substitute/\C\<kss\(\d*\)\>/𝓀𝓈𝓈\1/eg
	substitute/\C\<l\(\d*\)\>/𝓁\1/eg | substitute/\C\<ls\(\d*\)\>/𝓁𝓈\1/eg | substitute/\C\<lss\(\d*\)\>/𝓁𝓈𝓈\1/eg
	substitute/\C\<m\(\d*\)\>/𝓂\1/eg | substitute/\C\<ms\(\d*\)\>/𝓂𝓈\1/eg | substitute/\C\<mss\(\d*\)\>/𝓂𝓈𝓈\1/eg
	substitute/\C\<n\(\d*\)\>/𝓃\1/eg | substitute/\C\<ns\(\d*\)\>/𝓃𝓈\1/eg | substitute/\C\<nss\(\d*\)\>/𝓃𝓈𝓈\1/eg
	substitute/\C\<o\(\d*\)\>/𝓄\1/eg | substitute/\C\<os\(\d*\)\>/𝓄𝓈\1/eg | substitute/\C\<oss\(\d*\)\>/𝓄𝓈𝓈\1/eg
	substitute/\C\<p\(\d*\)\>/𝓅\1/eg | substitute/\C\<ps\(\d*\)\>/𝓅𝓈\1/eg | substitute/\C\<pss\(\d*\)\>/𝓅𝓈𝓈\1/eg
	substitute/\C\<q\(\d*\)\>/𝓆\1/eg | substitute/\C\<qs\(\d*\)\>/𝓆𝓈\1/eg | substitute/\C\<qss\(\d*\)\>/𝓆𝓈𝓈\1/eg | substitute/\C\<qr\(\d*\)\>/𝓆𝓇\1/eg
	substitute/\C\<r\(\d*\)\>/𝓇\1/eg | substitute/\C\<rs\(\d*\)\>/𝓇𝓈\1/eg | substitute/\C\<rss\(\d*\)\>/𝓇𝓈𝓈\1/eg
	substitute/\C\<s\(\d*\)\>/𝓈\1/eg | substitute/\C\<ss\(\d*\)\>/𝓈𝓈\1/eg | substitute/\C\<sss\(\d*\)\>/𝓈𝓈𝓈\1/eg
	substitute/\C\<t\(\d*\)\>/𝓉\1/eg | substitute/\C\<ts\(\d*\)\>/𝓉𝓈\1/eg | substitute/\C\<tss\(\d*\)\>/𝓉𝓈𝓈\1/eg
	substitute/\C\<u\(\d*\)\>/𝓊\1/eg | substitute/\C\<us\(\d*\)\>/𝓊𝓈\1/eg | substitute/\C\<uss\(\d*\)\>/𝓊𝓈𝓈\1/eg
	substitute/\C\<v\(\d*\)\>/𝓋\1/eg | substitute/\C\<vs\(\d*\)\>/𝓋𝓈\1/eg | substitute/\C\<vss\(\d*\)\>/𝓋𝓈𝓈\1/eg
	substitute/\C\<w\(\d*\)\>/𝓌\1/eg | substitute/\C\<ws\(\d*\)\>/𝓌𝓈\1/eg | substitute/\C\<wss\(\d*\)\>/𝓌𝓈𝓈\1/eg
	substitute/\C\<x\(\d*\)\>/𝓍\1/eg | substitute/\C\<xs\(\d*\)\>/𝓍𝓈\1/eg | substitute/\C\<xss\(\d*\)\>/𝓍𝓈𝓈\1/eg
	substitute/\C\<y\(\d*\)\>/𝓎\1/eg | substitute/\C\<ys\(\d*\)\>/𝓎𝓈\1/eg | substitute/\C\<yss\(\d*\)\>/𝓎𝓈𝓈\1/eg
	substitute/\C\<z\(\d*\)\>/𝓏\1/eg | substitute/\C\<zs\(\d*\)\>/𝓏𝓈\1/eg | substitute/\C\<zss\(\d*\)\>/𝓏𝓈𝓈\1/eg
endfunction

function! UnScriptify()
	substitute/\C𝒶/a/eg
	substitute/\C𝒷/b/eg
	substitute/\C𝒸/c/eg
	substitute/\C𝒹/d/eg
	substitute/\C𝒺/e/eg
	substitute/\C𝒻/f/eg
	substitute/\C𝒼/g/eg
	substitute/\C𝒽/h/eg
	substitute/\C𝒾/i/eg
	substitute/\C𝒿/j/eg
	substitute/\C𝓀/k/eg
	substitute/\C𝓁/l/eg
	substitute/\C𝓂/m/eg
	substitute/\C𝓃/n/eg
	substitute/\C𝓄/o/eg
	substitute/\C𝓅/p/eg
	substitute/\C𝓆/q/eg
	substitute/\C𝓇/r/eg
	substitute/\C𝓈/s/eg
	substitute/\C𝓉/t/eg
	substitute/\C𝓊/u/eg
	substitute/\C𝓋/v/eg
	substitute/\C𝓌/w/eg
	substitute/\C𝓍/x/eg
	substitute/\C𝓎/y/eg
	substitute/\C𝓏/z/eg
endfunction
