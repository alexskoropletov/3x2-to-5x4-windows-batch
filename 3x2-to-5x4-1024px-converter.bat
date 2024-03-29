@echo off
setlocal
for %%f in (*.jpg) do (
	echo "%%~nf.jpg"
	
	convert ^
		%%~nf.jpg ^
		-write mpr:input ^
		-set option:distort:viewport "%%[fx:w<h&&w/2>h/3?h/3*2:w]x%%[h]" ^
		-distort SRT 0 ^
		-set option:distort:viewport "%%[fx:w>h&&w/3>h/2?h/2*3:w]x%%[h]" ^
		-distort SRT 0 ^
		-set option:distort:viewport "%%[w]x%%[fx:w<h&&w/2<h/3?w/2*3:h]" ^
		-distort SRT 0 ^
		-set option:distort:viewport "%%[w]x%%[fx:w>=h&&w/3<h/2?w/3*2:h]" ^
		-distort SRT 0 ^
		mpr:input ^
		-gravity center ^
		-composite ^
		-resize 1024x1024 ^
		-quality 100 ^
		  "%%~nf.jpg"
	
	
	identify -verbose -ping -format "%%[fx:w]" "%%~nf.jpg" > temp.txt
	find /c "1024" temp.txt && (
		convert ^
		   "%%~nf.jpg" ^
		   -gravity center ^
		   -background white ^
		   -extent 1024x768 ^
		   -quality 100 ^
			"converted\%%~nf.jpg"
	) || (
		convert ^
		   "%%~nf.jpg" ^
		   -gravity center ^
		   -background white ^
		   -extent 768x1024 ^
		   -quality 100 ^
			"converted\%%~nf.jpg"
	)	
)
del temp.txt
