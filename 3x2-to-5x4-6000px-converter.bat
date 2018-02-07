@echo off
setlocal
for %%f in (*.jpg) do (
	echo "%%~nf.jpg"	
	identify -verbose -ping -format "%%[fx:w]" "%%~nf.jpg" > temp.txt
	find /c "6000" temp.txt && (
		convert ^
		   "%%~nf.jpg" ^
		   -gravity center ^
		   -background white ^
		   -extent 6000x4800 ^
		   -quality 100 ^
			"converted\%%~nf.jpg"
	) || (
		convert ^
		   "%%~nf.jpg" ^
		   -gravity center ^
		   -background white ^
		   -extent 4800x6000 ^
		   -quality 100 ^
			"converted\%%~nf.jpg"
	)	
)
del temp.txt
