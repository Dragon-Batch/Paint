# TODO

- box tool

- experimental pixel shuffle

- will shuffle every fixel within a given space around 1 point

- experimental image shuffle

- will shuffle every pixel (might not be added)

# Notes
```batch
for /f "tokens=1-2 delims=," %a in ('math.py 1 1 99 140') do ( "Paint 2.0\Core\batbox.exe" /g %a %b /c 0xcc /a 219 /c 0x0f /g 0 0 )
```
this is line drawing function for soon to be added line drawing tool