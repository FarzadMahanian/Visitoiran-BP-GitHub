<!DOCTYPE html>
<html>
<head>
    <title>Visitoiran Package Management System</title>
</head>
<body>
    <!--<#if lan == "fa">-->
    <!--<div class="main-container" style="width:100%; height:100%; padding:0; margin:0; font-family:Verdana,sans-serif; font-size:16px; line-height:1.3em; direction:rtl; text-align:right;">-->
    <!--<#else>-->
    <div class="main-container" style="width:100%; height:100%; padding:0; margin:0; font-family:Verdana,sans-serif; font-size:16px; line-height:1.3em; direction:ltr; text-align:left;">
    <!--</#if>-->
        <div class="voucher" style="background-color: #fff;margin: 50px 100px 20px;border-radius: 5px;border: 1px solid #ccc;box-shadow: 0 0 10px #d1d1d1;overflow: hidden;">
            <div class="header-section" style="text-transform: uppercase;text-align: center;color: #1d508d;border-bottom: 1px dashed #d1d1d1;padding: 15px 0;position: relative;">
                <img class="logo" style="position: absolute;left: 15px;top: 15px;width: 100px;height: auto;"
                     src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHN2ZyBQVUJMSUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3MvU1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KPCEtLSBDcmVhdG9yOiBDb3JlbERSQVcgWDcgLS0+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWw6c3BhY2U9InByZXNlcnZlIiB3aWR0aD0iMzVtbSIgaGVpZ2h0PSIyM21tIiB2ZXJzaW9uPSIxLjEiIHN0eWxlPSJzaGFwZS1yZW5kZXJpbmc6Z2VvbWV0cmljUHJlY2lzaW9uOyB0ZXh0LXJlbmRlcmluZzpnZW9tZXRyaWNQcmVjaXNpb247IGltYWdlLXJlbmRlcmluZzpvcHRpbWl6ZVF1YWxpdHk7IGZpbGwtcnVsZTpldmVub2RkOyBjbGlwLXJ1bGU6ZXZlbm9kZCIKdmlld0JveD0iMCAwIDM1MDAgMjMwMCIKIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIj4KIDxkZWZzPgogIDxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+CiAgIDwhW0NEQVRBWwogICAgLmZpbDEge2ZpbGw6IzFENTA4RH0KICAgIC5maWwwIHtmaWxsOiMxRDUwOEQ7ZmlsbC1ydWxlOm5vbnplcm99CiAgIF1dPgogIDwvc3R5bGU+CiA8L2RlZnM+CiA8ZyBpZD0iTGF5ZXJfeDAwMjBfMSI+CiAgPG1ldGFkYXRhIGlkPSJDb3JlbENvcnBJRF8wQ29yZWwtTGF5ZXIiLz4KICA8cGF0aCBjbGFzcz0iZmlsMCIgZD0iTTE3NTAgNThjLTUyNywtMTA5IC0xMDU5LDE2MCAtMTMzNCw1MTkgLTc3LDEwNCAtMTM4LDIwNSAtMTg3LDMwMSAtMjkzLDU4MSAtOTcsMTAzOSAxNzQsMTE4NSAzODMsMjA2IDkzMiwtMzcgODk1LC02OTUgLTI5LC0zNDIgLTE4MywtNTIyIDE1LC04ODMgODYsLTE1OSAyNTYsLTMxMCA0MzcsLTQyN3ptLTQ2NiAxNzMzYy0yNjYsODE0IC0xNTAyLDUzNCAtMTIwNiwtNjc5IDQ4LC0xNjYgMTMyLC0zMzMgMjQ4LC00ODQgMzUxLC00NTcgOTQ2LC02OTAgMTUxMywtNTc1IC0xOTcsNTEgLTQyMiwyNzIgLTUyMCw0NDYgLTI2MCw0NjYgMTc0LDc0NiAtMzUsMTI5MnoiLz4KICA8cGF0aCBjbGFzcz0iZmlsMCIgZD0iTTE3NTAgNThjLTUyNywtMTA5IC0xMDU5LDE2MCAtMTMzNCw1MTkgLTc3LDEwNCAtMTM4LDIwNSAtMTg3LDMwMSAtMjkzLDU4MSAtOTcsMTAzOSAxNzQsMTE4NSAzODMsMjA2IDkzMiwtMzcgODk1LC02OTUgLTI5LC0zNDIgLTE4MywtNTIyIDE1LC04ODMgODYsLTE1OSAyNTYsLTMxMCA0MzcsLTQyN3ptLTQ2NiAxNzMzYy0yNjYsODE0IC0xNTAyLDUzNCAtMTIwNiwtNjc5IDQ4LC0xNjYgMTMyLC0zMzMgMjQ4LC00ODQgMzUxLC00NTcgOTQ2LC02OTAgMTUxMywtNTc1IC0xOTcsNTEgLTQyMiwyNzIgLTUyMCw0NDYgLTI2MCw0NjYgMTc0LDc0NiAtMzUsMTI5MnoiLz4KICA8cGF0aCBjbGFzcz0iZmlsMCIgZD0iTTcyOCAxMzMzYzQ3LDEgODksMjEgMTE5LDUyIDMwLDMxIDQ4LDc0IDQ4LDEyMSAtMSw0NyAtMjEsODkgLTUyLDExOSAtMzEsMzAgLTc0LDQ4IC0xMjEsNDcgLTQ3LDAgLTg5LC0yMCAtMTE5LC01MSAtMzAsLTMxIC00OCwtNzQgLTQ4LC0xMjEgMSwtNDcgMjEsLTg5IDUyLC0xMTkgMzEsLTMwIDc0LC00OCAxMjEsLTQ4em04NSA4NGMtMjIsLTIyIC01MiwtMzYgLTg2LC0zNyAtMzQsLTEgLTY1LDEzIC04NywzNSAtMjMsMjEgLTM3LDUyIC0zOCw4NiAwLDM0IDEzLDY1IDM1LDg3IDIxLDIzIDUyLDM3IDg2LDM4IDM0LDAgNjUsLTEzIDg3LC0zNSAyMywtMjIgMzcsLTUyIDM4LC04NiAwLC0zNCAtMTMsLTY1IC0zNSwtODh6Ii8+CiAgPGNpcmNsZSBjbGFzcz0iZmlsMSIgdHJhbnNmb3JtPSJtYXRyaXgoMC4wNzc3MDU3IDAuMDAxMzAzMTggLTAuMDAxMzAzMTggMC4wNzc3MDU3IDcyNC45ODggMTUwMi44OSkiIHI9IjEwNTAiLz4KICA8cGF0aCBjbGFzcz0iZmlsMSIgZD0iTTY4MiAxMzIxbC00NCAtMTkxYy0xNSwtNzEgNDAsLTEwMiA5NSwtMTAxIDU1LDEgMTA5LDM0IDkyLDEwNGwtNTEgMTkwYy0xNSwtNCAtMzAsLTcgLTQ2LC03IC0xNiwwIC0zMSwxIC00Niw1eiIvPgogIDxwYXRoIGNsYXNzPSJmaWwxIiBkPSJNOTA1IDE1NTJsMTkwIDUxYzcwLDE3IDEwMywtMzcgMTA0LC05MiAxLC01NSAtMzAsLTExMSAtMTAxLC05NWwtMTkxIDQ0YzMsMTUgNSwzMCA1LDQ2IDAsMTYgLTMsMzEgLTcsNDZ6Ii8+CiAgPHBhdGggY2xhc3M9ImZpbDEiIGQ9Ik04NTggMTM3MmwxMzkgLTEzOWM1MCwtNTIgMTksLTEwNyAtMjgsLTEzNiAtNDgsLTI4IC0xMTEsLTI4IC0xMzMsNDBsLTU3IDE4N2MzMSw5IDU4LDI2IDc5LDQ4eiIvPgogIDxwYXRoIGNsYXNzPSJmaWwxIiBkPSJNOTA2IDE0NTZsMTg5IC01MWM3MCwtMTkgNzEsLTgzIDQ1LC0xMzEgLTI4LC00OCAtODIsLTgwIC0xMzUsLTMybC0xNDQgMTMzYzIyLDIzIDM3LDUxIDQ1LDgxeiIvPgogIDxwYXRoIGNsYXNzPSJmaWwxIiBkPSJNNTQzIDE1NDZsLTE5MSA0NGMtNzEsMTUgLTEwMiwtNDAgLTEwMSwtOTUgMSwtNTUgMzQsLTEwOSAxMDQsLTkybDE5MCA1MWMtNCwxNCAtNywzMCAtNyw0NiAwLDE2IDIsMzEgNSw0NnoiLz4KICA8cGF0aCBjbGFzcz0iZmlsMSIgZD0iTTU5NiAxMzY4bC0xMzMgLTE0NGMtNDksLTUzIC0xNiwtMTA4IDMyLC0xMzUgNDgsLTI2IDExMiwtMjUgMTMxLDQ1bDUxIDE4OGMtMzEsOCAtNTksMjQgLTgxLDQ2eiIvPgogIDxwYXRoIGNsYXNzPSJmaWwxIiBkPSJNNTQ2IDE0NTBsLTE4OCAtNTdjLTY4LC0yMiAtNjcsLTg1IC00MCwtMTMzIDI5LC00NyA4NSwtNzcgMTM2LC0yN2wxMzkgMTM4Yy0yMiwyMiAtMzksNDkgLTQ3LDc5eiIvPgogIDxwYXRoIGNsYXNzPSJmaWwxIiBkPSJNNjc2IDE2ODNsLTUxIDE5MGMtMTcsNzAgMzcsMTAzIDkyLDEwNCA1NSwxIDExMCwtMzAgOTUsLTEwMWwtNDQgLTE5MWMtMTUsMyAtMzAsNSAtNDYsNSAtMTYsMCAtMzIsLTMgLTQ2LC03eiIvPgogIDxwYXRoIGNsYXNzPSJmaWwxIiBkPSJNODU0IDE2MzhsMTMzIDE0NGM0OSw1MyAxNiwxMDcgLTMyLDEzNSAtNDgsMjYgLTExMiwyNSAtMTMxLC00NWwtNTEgLTE4OGMzMSwtOSA1OSwtMjQgODEsLTQ2eiIvPgogIDxwYXRoIGNsYXNzPSJm
aWwxIiBkPSJNOTA0IDE1NTVsMTg4IDU4YzY4LDIyIDY3LDg1IDQwLDEzMyAtMjksNDcgLTg1LDc3IC0xMzYsMjdsLTEzOSAtMTM4YzIyLC0yMiAzOCwtNDkgNDcsLTgweiIvPgogIDxwYXRoIGNsYXNzPSJmaWwxIiBkPSJNNTkyIDE2MzRsLTEzOSAxMzljLTUwLDUyIC0xOSwxMDcgMjgsMTM2IDQ4LDI3IDExMSwyOCAxMzMsLTQwbDU3IC0xODdjLTMxLC05IC01OCwtMjYgLTc5LC00OHoiLz4KICA8cGF0aCBjbGFzcz0iZmlsMSIgZD0iTTU0NCAxNTQ5bC0xODkgNTFjLTcwLDIwIC03MSw4MyAtNDUsMTMyIDI4LDQ4IDgyLDgwIDEzNSwzMmwxNDQgLTEzM2MtMjIsLTIzIC0zNywtNTEgLTQ1LC04MnoiLz4KICA8cGF0aCBjbGFzcz0iZmlsMCIgZD0iTTE4NyAxMTEzYzk1LC0yNDggMjkyLC00NzYgNTM1LC02NDIgMjM5LC0xNjQgNTIzLC0yNjggNzk3LC0yNzFsMCAwYy0yNzEsMyAtNTUyLDExOSAtNzkwLDI4MSAtMjQwLDE2NSAtNDQ4LDM4NyAtNTQyLDYzMmwwIDB6Ii8+CiAgPHBhdGggY2xhc3M9ImZpbDAiIGQ9Ik0yMDAgMTI5NmMxMTMsLTI2MiAzMTgsLTM2NSA1MzMsLTQ2MyAyMTYsLTk3IDQzMSwtMTk1IDUzOCwtNDU3bDAgMGMtMTA5LDI2NyAtMzE0LDM3MSAtNTMyLDQ2OSAtMjE0LDk3IC00MjgsMTkzIC01MzksNDUxbDAgMHoiLz4KICA8cGF0aCBjbGFzcz0iZmlsMCIgZD0iTTE2NiAxMjI2YzE5NCwtNTA0IDU3NSwtNzUyIDEwNjcsLTg0OWwwIDBjLTQ0MCw4OCAtODgzLDM3MiAtMTA2Nyw4NDlsMCAweiIvPgogIDxwYXRoIGNsYXNzPSJmaWwwIiBkPSJNMTY4IDEzMzZjMjMyLC01MzYgNTg5LC00NzMgOTAzLC03MjBsMCAwYy0zNTAsMjMyIC02ODEsMjA3IC05MDMsNzIwbDAgMHoiLz4KICA8cGF0aCBjbGFzcz0iZmlsMCIgZD0iTTEzNSAxMzM4YzEyNiwtMjg5IDI2MiwtNDU2IDQ2OSwtNTg5IDE2NSwtMTA2IDQ1OCwtMTgwIDU0NywtMjc2bDAgMGMtMTA2LDEwNiAtMzYzLDE4MyAtNTUzLDMwMiAtMjA5LDEzMiAtMzU1LDMxMiAtNDYzLDU2M2wwIDB6Ii8+CiAgPHBhdGggY2xhc3M9ImZpbDAiIGQ9Ik0xOTMwIDEzMDZjMjgsLTMzIDU1LC02NyA4MywtMTAwIDI3LC0zMyA1NSwtNjYgODMsLTk5IDQwLC00NyA3NywtODggMTEyLC0xMjMgMzUsLTM1IDY4LC02NSA5OCwtOTAgODEsLTY3IDE1MCwtMTAxIDIwNSwtMTAxIDUsMCA5LDEgMTQsMSA1LDEgMTAsMSAxNSwzIDcsMSAxMCwxIDEwLC0yIDAsLTEgLTMsLTQgLTEwLC03IC0xMiwtNCAtMjYsLTYgLTQwLC02IC03NiwwIC0xNzUsNjEgLTI5NiwxODIgLTM2LDM3IC03OCw4MyAtMTI2LDEzOSAtNDcsNTUgLTk5LDEyMCAtMTU3LDE5NSAtNyw5IC0xMiwxMyAtMTcsMTMgLTUsMCAtOCwtNSAtMTAsLTE0IC0xLC04IC0xLC0xNSAwLC0yMyA3LC0zOCAzOCwtMTI1IDk0LC0yNTggMjUsLTYzIDQ1LC0xMTUgNTgsLTE1NSAxNCwtNDEgMjEsLTcxIDIxLC04OSAxLC0yMiAtNywtNDEgLTI0LC01NyAtMTYsLTE1IC0zNSwtMjEgLTU3LC0yMCAtNjIsOCAtMTI1LDQ0IC0xODksMTA4IC02Niw2NSAtMTAyLDEyOSAtMTEwLDE5MiAtMSwxMCAzLDIyIDEwLDM1IDQsNyA4LDEyIDEyLDE1IDMsNCA2LDYgOSw3IDUsNCAxMCw3IDE2LDcgOCwtMiAxMiwtNSAxMiwtMTAgMCwtMyAtMywtNSAtOCwtNiAtNSwtMSAtOCwtMSAtMTIsLTIgLTMsMCAtNSwtMSAtNywtMiAtMTEsLTYgLTE2LC0yMSAtMTUsLTQyIDUsLTUwIDM3LC0xMDYgOTYsLTE2OSA2MywtNjcgMTI4LC0xMDUgMTk1LC0xMTQgMiwtMSA1LC0xIDgsLTEgMiwwIDUsMCA3LDAgMjMsMCAzNSwxMiAzNSwzNWwwIDExYy0xLDMgLTEsNSAtMSw2IDAsMSAwLDIgMCwzIC0xLDM2IC0zMCwxMTggLTg2LDI0NiAtMjgsNjYgLTUwLDEyMCAtNjUsMTY0IC0xNSw0MyAtMjMsNzYgLTI1LDk4IDAsNSAxLDEwIDMsMTUgMSw1IDMsMTAgNiwxNSAzLDQgNyw4IDExLDExIDQsMyA5LDQgMTQsNCAxMCwwIDE5LC01IDI4LC0xNXptMTAxOSA1MWM1MSwwIDEwOSwtMjkgMTc2LC04OCAzMywtMzAgNTcsLTU4IDc0LC04NSAxNywtMjcgMjcsLTUzIDMxLC03OSAwLC00IDAsLTkgLTEsLTE1IC0yLC02IC01LC0xNCAtMTEsLTIyIC0xMSwtMTcgLTIzLC0yNiAtMzUsLTI2IC0zLDAgLTUsMSAtNywxIC0xMCw0IC0xOCw5IC0yNCwxMyAtNSw1IC05LDkgLTEwLDEyIDAsMSAxLDEgMywxIDMsLTEgNSwtMSA3LC0xIDIsMCA1LC0yIDksLTUgNSwtMyAxMCwtNSAxNSwtNSAyNiwtNSAzOSwxMCAzOSw0NiAtNCwyMCAtMTIsNDIgLTI1LDY1IC0xNCwyMyAtMzQsNDggLTU5LDc0IC0yNCwyNiAtNDksNDcgLTcyLDYzIC0yNCwxNSAtNDgsMjcgLTcyLDM0IC0xNiw2IC0zMSw4IC00NSw4IC0xNywwIC0zMiwtNSAtNDQsLTE2bC03IC04Yy03LC05IC0xMywtMjEgLTE4LC0zNCAtNiwtMTQgLTksLTI5IC05LC00NyAwLC00IDAsLTYgLTEsLTUgMCwwIDAsLTIgMSwtNyA2LC0zNCAxOCwtNzQgMzYsLTEyMiAxOCwtNDcgNDAsLTk4IDY3LC0xNTMgMTcsLTM0IDM0LC02NyA1MCwtOTggMTcsLTMyIDM2LC02MiA1NiwtOTEgMywtNSA4LC04IDE1LC05IDY5LC01IDEyNiwtOCAxNzEsLTkgNywtMiAxMSwtMyAxMSwtNCAtMSwtMSAtNCwtMiAtNywtMiAtMywwIC0xMSwwIC0yMywwIC0xMywtMSAtMzAsLTEgLTUyLC0xbC04NSAwYy05LDAgLTEwLC00IC0zLC0xMyA4MiwtMTEyIDE0MiwtMTcxIDE3OCwtMTc5IDIsMCA0LC0xIDUsLTMgMSwtMiAxLC00IDEsLTUgMCwtMSAwLC0yIC0xLC0xIC0xLDEgLTMsMSAtNSwxIC0xMCwwIC0yMywzIC00MCw5IC0xOSw2IC0zMCwxMSAtMzMsMTUgLTI2LDMwIC01MCw2MCAtNzIsODggLTIyLDI5IC00Miw1NiAtNjEsODMgLTIsNCAtNCw1IC02LDUgLTk2LDAgLTE1OSwxIC0xOTcsMSAtNjEsMiAtNjIsNCAtMzQsMTAgOCwxIDE4LDIgMzAsMiA2OSw0IDE5MCw0IDE5MCw3IDAsMiAtMiw1IC00LDkgLTMsNCAtNiw5IC05LDEzIC0zLDUgLTYsOSAtOSwxMyAtMyw0IC01LDcgLTYsOCAtMjEsMjggLTQxLDU4IC02MCw5MiAtMjAsMzQgLTQwLDcyIC01OSwxMTYgLTIyLDUwIC0zOSw5NCAtNDksMTMyIC03LDI1IC0xMiw0NyAtMTQsNjggLTcsNSAtMTUsMTEgLTI1LDE4IC0xMywxMCAtMjgsMjEgLTQ0LDMxIC0xNiwxMCAtMzIsMTkgLTQ3LDI3IC0xNSw4
IC0yOCwxMyAtMzgsMTUgLTUsMSAtMTAsMiAtMTYsMiAtNiwwIC0xMCwtMSAtMTQsLTUgLTQsLTMgLTUsLTggLTUsLTE1IDAsLTcgMywtMTcgMTAsLTMxIDYsLTEzIDEwLC0yMiAxMiwtMjYgMiwtNCAzLC03IDQsLTkgMCwtMSAxLC0zIDIsLTUgMSwtMiAzLC03IDcsLTE1IDUsLTkgMTIsLTIyIDIxLC00MSAxMCwtMTggMjQsLTQ0IDQyLC03OCA1LC0xMCA2LC0xNyA0LC0yMyAtMiwtNiAtNSwtMTAgLTEwLC0xMSAtNSwtMiAtMTAsLTIgLTE1LDEgLTYsMiAtOSw3IC0xMCwxMyAwLDIgLTMsOCAtNywxNyAtNCw5IC0xMCwyMCAtMTYsMzQgLTYsMTMgLTEzLDI3IC0yMSw0MyAtNywxNSAtMTQsMzEgLTIwLDQ2IC03LDE1IC0xMiwyOSAtMTYsNDMgLTQsMTMgLTcsMjQgLTcsMzMgMCw5IDMsMTcgOCwyNCA1LDcgMTEsMTIgMTcsMTYgNyw0IDE0LDYgMjAsOCA3LDEgMTIsMSAxNSwwIDEyLC02IDI2LC0xMyA0MiwtMjMgMTUsLTkgMzEsLTIwIDQ3LC0zMCAxNiwtMTEgMzAsLTIyIDQzLC0zMiA2LC00IDExLC04IDE1LC0xMiAwLDUgMCwxMCAwLDE1IDAsMTYgMywzMiAxMCw0NyA2LDE2IDE1LDI5IDI2LDQwbDggOWM5LDcgMTgsMTIgMjgsMTQgOSwzIDIxLDQgMzQsNHptMjU0IC0yNWM0NywtNiAxMDIsLTM3IDE2NCwtOTAgMzIsLTI3IDU1LC01MiA3MSwtNzYgMTYsLTIzIDI0LC00NCAyNiwtNjQgMCwtMiAwLC0zIC0xLC00IDAsLTIgLTEsLTQgLTIsLTUgLTEsLTIgLTEsLTMgMCwtNSA1LC02IDE2LC0xMCAzMiwtMTAgOCwwIDEyLC0xIDEyLC00IDAsLTEgLTQsLTIgLTEyLC00IC0yMiwwIC00MiwtMSAtNTksLTEgLTE3LC0xIC0zMiwtMSAtNDQsLTIgLTEsMCAtMiwtMSAtMywtMSAtMSwtMSAtMiwtMSAtMywtMiAtMTUsLTEwIC0yNywtMTUgLTM2LC0xNCAtMTEsMCAtMjMsNiAtMzUsMTcgLTMsMiAtNiwzIC04LDMgLTEsMCAtMTEsMSAtMzEsMSAtMTIsMSAtMTksMiAtMjAsNSAtMiwzIC0zLDUgLTMsNiAwLDQgMyw3IDcsMTAgNSw0IDEwLDcgMTUsMTAgMywxIDMsMyAxLDcgLTcwLDg2IC0xMDUsMTUxIC0xMDYsMTk1IDAsNCAxLDggMywxMiAzLDMgNiw3IDksOSAzLDMgNyw1IDEyLDYgNCwyIDgsMiAxMSwxem0tMTEgLTQyYzMxLC03MyA3NSwtMTM2IDEzMiwtMTg4IDgsLTYgMTIsLTggMTMsLTggMTAsLTMgMjAsLTYgMzEsLTcgMTEsLTIgMjMsLTEgMzYsMCAyNCwzIDM0LDEyIDMwLDI4IC04LDM5IC0zOCw4MiAtOTEsMTI5IC01MSw0NiAtOTQsNzIgLTEzMCw3OCAtMTcsMyAtMjUsLTEgLTI1LC0xNCAwLC02IDEsLTEyIDQsLTE4em0tODA3IC03NWMzLC0yIDYsLTUgNywtOCAyLC00IDMsLTYgMiwtNyAwLC0yIC0xLC0zIC0zLC0yIC0yLDAgLTYsMyAtMTEsOCAtNyw3IC0xOCwxNSAtMzEsMjUgLTE0LDEwIC0yOSwyMSAtNDUsMzEgLTE2LDEwIC0zMSwxOSAtNDcsMjcgLTE1LDggLTI3LDEzIC0zNywxNSAtNiwxIC0xMSwyIC0xNywyIC01LDAgLTEwLC0xIC0xNCwtNSAtMywtMyAtNSwtOCAtNSwtMTUgMCwtNyA0LC0xNyAxMCwtMzEgNiwtMTMgMTEsLTIyIDEyLC0yNiAyLC00IDMsLTcgNCwtOSAxLC0xIDEsLTMgMiwtNSAxLC0yIDMsLTcgOCwtMTUgNCwtOSAxMSwtMjIgMjEsLTQxIDksLTE4IDIzLC00NCA0MSwtNzggNSwtMTAgNywtMTcgNCwtMjMgLTIsLTYgLTUsLTEwIC0xMCwtMTEgLTUsLTIgLTEwLC0yIC0xNSwxIC01LDIgLTksNyAtMTAsMTMgMCwyIC0zLDggLTcsMTcgLTQsOSAtOSwyMCAtMTYsMzQgLTYsMTMgLTEzLDI3IC0yMCw0MyAtOCwxNSAtMTUsMzEgLTIxLDQ2IC02LDE1IC0xMiwyOSAtMTYsNDMgLTQsMTMgLTYsMjQgLTYsMzMgMCw5IDIsMTcgNywyNCA1LDcgMTEsMTIgMTgsMTYgNiw0IDEzLDYgMjAsOCA2LDEgMTEsMSAxNCwwIDEyLC02IDI2LC0xMyA0MiwtMjMgMTYsLTkgMzEsLTIwIDQ3LC0zMCAxNiwtMTEgMzAsLTIyIDQzLC0zMiAxMywtMTAgMjMsLTE4IDI5LC0yNXptLTUwIC0yNDZjMiwtNCAwLC05IC01LC0xNCAtNSwtNCAtMTEsLTYgLTE2LC01IC04LDIgLTE4LDkgLTMwLDIyIC0xMiwxMiAtMTgsMjIgLTE4LDI5IDAsNyA2LDEyIDE3LDE0IDgsMSAxOCwtMyAzMCwtMTUgMTMsLTExIDIwLC0yMiAyMiwtMzF6bTg5IDI2NmMtNywtNCAtMTYsLTE0IC0yNywtMzAgLTExLC0xNiAtMTYsLTMwIC0xOCwtNDEgLTQsLTI2IDIwLC01NiA3MCwtOTAgNDAsLTI4IDc1LC00NiAxMDUsLTU0IDMsMCA2LC0xIDksLTEgMiwwIDYsMCA5LDAgNiwwIDEzLDEgMjEsMiA5LDIgMTksNSAzMSw5IDQsMSAxMCwtMSAxOCwtNiA4LC02IDE0LC0xMSAxOCwtMTYgMiwtMyAyLC02IDAsLTExIC0zLC0zIC01LC01IC05LC01IC0yOSwwIC02MSw1IC05NSwxNiAtMzQsMTEgLTcwLDI4IC0xMDgsNTEgLTc2LDQ0IC0xMTIsODQgLTEwOCwxMjAgMSw3IDMsMTQgNiwyMSAzLDcgNywxNCAxMywyMmwyNiAzNGMtNjMsNDQgLTk5LDcxIC0xMDgsODIgLTQsNiAtMiwxMCA1LDEwIDIsMSA2LDEgMTEsMCA0LC0xIDEwLC0yIDE3LC0zIDUsMiAxMSwzIDE3LDMgMTksMCA0MywtNyA3MywtMjAgMzUsLTE1IDUyLC0zMCA1MiwtNDUgMCwtNCAtMSwtOSAtNCwtMTUgLTMsLTYgLTgsLTEzIC0xNSwtMjIgNDMsLTI1IDgzLC00NSAxMjIsLTYwIDM5LC0xNiA3OCwtMjggMTE1LC0zNWwtMSAtMWMtNDAsNyAtODAsMTcgLTEyMCwzMCAtNDEsMTIgLTgyLDMxIC0xMjUsNTV6bS0xMDYgOTVjMiwtNCA3LC05IDEzLC0xNCA3LC02IDE1LC0xMiAyNiwtMTkgMTcsLTEzIDMwLC0yMiAzOSwtMjcgMTIsMTEgMTgsMjEgMTgsMjkgMCwzIC0xLDYgLTMsOSAtMyw0IC04LDggLTE1LDExIC03LDMgLTE2LDcgLTI3LDExIC0yMiw4IC0zOSwxMSAtNDgsOSAtNywtMSAtOCwtNCAtMywtOXptNDg5IC0zNjFjMSwtNCAwLC05IC01LC0xNCAtNSwtNCAtMTEsLTYgLTE3LC01IC03LDIgLTE3LDkgLTI5LDIyIC0xMiwxMiAtMTgsMjIgLTE4LDI5IDAsNyA1LDEyIDE3LDE0IDgsMSAxOCwtMyAzMCwtMTUgMTMsLTExIDIwLC0yMiAyMiwtMzF6Ii8+CiAgPHBhdGggY2xhc3M9ImZpbDAiIGQ9Ik0xODE2IDIwMDdsLTExNCAwIDAgLTU1NiAxMTQgMCAwIDU1NnptMjgyIC0yMjlsLTM4IDAgMCAyMjkgLTExNCAwIDAgLTU1NWMxMSwtMSAyMywtMSAzNywtMiAxMywtMSAyNiwtMSA0MCwt
MiAxNCwtMSAyOSwtMSA0MywtMSAxNCwtMSAyOCwtMSA0MSwtMSA2NywwIDExOCwxMiAxNTMsMzcgMzUsMjUgNTIsNjMgNTIsMTE1IDAsMjMgLTMsNDMgLTksNjEgLTYsMTcgLTE0LDMyIC0yNCw0NSAtOSwxMyAtMjEsMjQgLTMzLDMyIC0xMyw5IC0yNiwxNiAtNDAsMjMgMTcsMjggMzMsNTUgNDgsODAgMTUsMjUgMjksNDcgNDQsNjYgMTUsMTkgMzAsMzQgNDYsNDUgMTYsMTEgMzIsMTcgNTAsMTdsNCAwIDAgMzVjLTksMyAtMjAsNiAtMzEsOCAtMTIsMSAtMjUsMiAtMzksMiAtMTQsMCAtMjcsMCAtMzgsLTIgLTEyLC0xIC0yMiwtNCAtMzIsLTggLTEwLC00IC0yMCwtMTAgLTI5LC0xOCAtMTAsLTggLTIwLC0xOSAtMzAsLTMyIC0xMCwtMTMgLTIxLC0yOSAtMzIsLTQ4IC0xMiwtMTkgLTI1LC00MSAtMzksLTY4bC0zMCAtNTh6bS0xOSAtNTVjMTYsMCAzMSwtMiA0NiwtNiAxNSwtMyAyNiwtOCAzNCwtMTQgNSwtMyA5LC02IDEzLC0xMCA1LC01IDksLTExIDEyLC0xOCAzLC03IDYsLTE3IDgsLTI4IDIsLTExIDMsLTI1IDMsLTQyIDAsLTE5IC0yLC0zNSAtNywtNDggLTQsLTEzIC0xMSwtMjMgLTIwLC0zMSAtOSwtOCAtMTksLTE0IC0zMiwtMTcgLTEzLC0zIC0yOSwtNSAtNDYsLTUgLTQsMCAtOSwwIC0xNSwxIC01LDAgLTExLDAgLTE1LDFsMCAyMTcgMTkgMHptNzA4IDI4NGwtNjUgLTE4OCAtMjA5IDMgLTY4IDE4NSAtNzEgMCAyMjAgLTU1MiAxMTAgLTE5IDIwNSA1NzEgLTEyMiAwem0tODMgLTI0MWwtODMgLTI0MCAtODkgMjQwIDE3MiAwem03MjggMjQzbC0zOTIgLTM4OSAtMiAwYzEsMzIgMiw2MiAyLDkwIDEsMTEgMSwyMyAxLDM1IDAsMTIgMSwyMiAxLDMyIDAsMTAgMCwxOSAwLDI2IDEsOCAxLDEzIDEsMTdsMCAxODcgLTY3IDAgMCAtNTYwIDUwIDAgMzkzIDM4OCAwIDBjLTEsLTMwIC0xLC01OCAtMiwtODQgMCwtMTEgMCwtMjIgMCwtMzQgMCwtMTEgMCwtMjIgLTEsLTMyIDAsLTEwIDAsLTIwIDAsLTI5IDAsLTggMCwtMTUgMCwtMjFsMCAtMTg0IDY3IDAgMCA1NTggLTUxIDB6Ii8+CiAgPHBhdGggY2xhc3M9ImZpbDAiIGQ9Ik0xMDA0IDE5MDNjLTczLDYzIC0xODgsMTI0IC0zMjksMTEzIC01MzMsLTQ0IC02NTcsLTcyMyAtMjAwLC0xMDA0IDE2MCwtOTggMzg4LC0xNTAgNTY3LC0yMjAgNTcsLTIyIDExNSwtNjggMTUzLC0xMjQgMzUsLTUzIDY4LC0xNDEgMTA3LC0yMjMgMzQsLTczIDcyLC0xNDUgMTE5LC0yMDhsLTQ5IDc2Yy0xNTgsMjg2IC0xMjYsNDE3IC0zNzUsNTA4IC0yNTEsOTEgLTU2MywxNzQgLTY5OSw0MTMgLTQ5LDg3IC03MiwxODMgLTcwLDI3NSA5LDM3NCA0MzcsNjQzIDc3NiwzOTR6Ii8+CiAgPHBhdGggY2xhc3M9ImZpbDEiIGQ9Ik0xMDQ0IDI1OWMtOTg0LDM3OSAtMTI4MywxNjg1IC00ODYsMTkyMCAyNzgsODMgNTI2LC0yIDY4MiwtMjMzIDIxLC0zMSA0MCwtNjUgNTgsLTEwMiAxMjIsLTI1NSA1NSwtNDkxIC0xNiwtNzQwIC02NCwtMjI3IDMsLTQ0NyAxNTYsLTYzN2wwIDBjLTI3LDMzIC00OSw2OCAtNzEsMTA0IC05OCwxNjEgLTEzMiwzNDEgLTc5LDUzMSA3MSwyNTEgMTM4LDQ4OCAxNSw3NDVsMCAwYy0xNywzNyAtMzcsNzEgLTU4LDEwMyAtMTU3LDIzMyAtNDA4LDMxOSAtNjg5LDIzNiAtNjIzLC0xODUgLTU3OSwtMTAxNiAtNzEsLTE1NTkgMTY1LC0xNzYgMzMyLC0yODEgNTU5LC0zNjhsMCAweiIvPgogPC9nPgo8L3N2Zz4K">
                <h2 class="title">${translator.translate("voucher", lan)}</h2>
            </div>

            <div class="content-section" style="padding: 15px;font-size: 0.8em;">
                <div class="row" style="width: 100%;clear: both;overflow: hidden;position: relative; border-bottom: 1px solid #ccc; margin-bottom: 15px; padding-bottom: 30px;">
                    <#if lan == "fa">
                    <div class="column" style="width: 40%;float: right;">
                    <#else>
                    <div class="column" style="width: 40%;float: left;">
                    </#if>
                        <h4 class="header" style="text-align:center;font-size: 1.4em;position: relative; margin-top: 0;">
                            <span style="border-bottom: 1px solid #1d508d;padding: 0 30px 10px 30px;"> ${translator.translate("tourInformation", lan)} </span>
                        </h4>
                        <table style="width: 100%;" cellspacing="0" cellpadding="0">
                            <tbody>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("tourName", lan)}</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p>${data.name}</p>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("startDate", lan)}</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <#if lan == "fa">
                                        <p>${method.convertToShamsi(data.hotelPackageDate.hotelPackageStartDate)}</p>
                                        <#else>
                                            <p>${data.hotelPackageDate.hotelPackageStartDate ?string('dd.MM.yyyy HH:mm:ss')}</p>
                                    </#if>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("duration", lan)}</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p>
                                        ${ data.duration }
                                        <#if data.duration gt 1 >
                                            <span> ${translator.translate("days", lan)} </span>
                                            <#else>
                                                <span> ${translator.translate("day", lan)} </span>
                                        </#if>
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("packageCode", lan)}</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p>${ data.packageCode }</p>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("destinations", lan)}</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p>
                                        <#list data.itineraries as itinerary >
                                            <span class="destination">${ itinerary.city.name }</span>
                                        </#list>
                                    </p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <#if lan == "fa">
                    <div class="column" style="width: 40%;float: left;">
                    <#else>
                    <div class="column" style="width: 40%;float: right;">
                    </#if>
                    <h4 class="header" style="text-align:center;font-size: 1.4em;position: relative; margin-top: 0;">
                        <span style="border-bottom: 1px solid #1d508d;padding: 0 30px 10px 30px;">${translator.translate("hotelInformation", lan)} </span>
                    </h4>
                    <table style="width: 100%;" cellspacing="0" cellpadding="0">
                        <tbody>
                        <tr>
                            <td style="border-bottom: 1px dashed #1d508d;">
                                <p><strong>${translator.translate("name", lan)}</strong></p>
                            </td>
                            <td style="border-bottom: 1px dashed #1d508d;">
                                <p>
                                    <#list data.hotelPackageDate.hotelPackage.hotels as hotel >
                                        <span class="hotel">${ hotel.name }</span>
                                    </#list>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td style="border-bottom: 1px dashed #1d508d;">
                                <p><strong>${translator.translate("type", lan)}</strong></p>
                            </td>
                            <td style="border-bottom: 1px dashed #1d508d;">
                                <p>${ data.hotelPackageDate.hotelPackage.boardType }</p>
                            </td>
                        </tr>
                        <tr>
                            <td style="border-bottom: 1px dashed #1d508d;">
                                <p><strong>${translator.translate("stars", lan)}</strong></p>
                            </td>
                            <td style="border-bottom: 1px dashed #1d508d;">
                                <p>
                                    <#assign x= data.hotelPackageDate.hotelPackage.star>
                                        <#list 1..x as i>
                                            <span class="star" style="display: inline-block;font-size: 15px;color: gold;">&#9733;</span>
                                        </#list>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td style="border-bottom: 1px dashed #1d508d;">
                                <p><strong>${translator.translate("rooms", lan)} </strong></p>
                            </td>
                            <td style="border-bottom: 1px dashed #1d508d;">
                                <#list data.rooms as room >
                                    <#if room.numberOfRooms gt 0 >
                                        <p>${ room.romeType.name } x ${ room.numberOfRooms }</p>
                                    </#if >
                                </#list >
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    </div>
                </div>

                <div class="row" style="width: 100%;clear: both;overflow: hidden;position: relative; border-bottom: 1px solid #ccc; margin-bottom: 15px; padding-bottom: 30px;">
                    <#if lan == "fa">
                    <div class="column" style="width: 40%;float: right;">
                    <#else>
                    <div class="column" style="width: 40%;float: left;">
                    </#if>
                        <h4 class="header" style="text-align:center;font-size: 1.4em;position: relative; margin-top: 0;">
                            <span style="border-bottom: 1px solid #1d508d;padding: 0 30px 10px 30px;">${translator.translate("passengersInformation", lan)}</span>
                        </h4>
                        <table style="width: 100%;" cellspacing="0" cellpadding="0">
                            <tbody>
                            <#list data.passengerInfo as passenger >
                                <tr>
                                    <td class="six wide">
                                        <p><strong>${translator.translate("passenger", lan)} ${ passenger?index+1 }</strong></p>
                                    </td>
                                    <td class="ten wide">
                                        <p>${ passenger.firstName } ${ passenger.surName }</p>
                                    </td>
                                </tr>
                            </#list >
                            </tbody>
                        </table>
                    </div>

                    <#if lan == "fa">
                    <div class="column" style="width: 40%;float: left;">
                    <#else>
                    <div class="column" style="width: 40%;float: right;">
                    </#if>
                        <h4 class="header" style="text-align:center;font-size: 1.4em;position: relative; margin-top: 0;">
                            <span style="border-bottom: 1px solid #1d508d;padding: 0 30px 10px 30px;">${translator.translate("contactInformation", lan)} </span>
                        </h4>
                        <table style="width: 100%;" cellspacing="0" cellpadding="0">
                            <tbody>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("name", lan)} Name</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p>${ data.leaderInfo.firstName } ${ data.leaderInfo.surName }</p>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("email", lan)}</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p>${ data.leaderInfo.email }</p>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("mobile", lan)}</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p>${ data.leaderInfo.mobile }</p>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="row" style="width: 100%;clear: both;overflow: hidden;position: relative; border-bottom: 1px solid #ccc; margin-bottom: 15px; padding-bottom: 30px;">
                    <#if lan == "fa">
                    <div class="column" style="width: 40%;float: right;">
                    <#else>
                    <div class="column" style="width: 40%;float: left;">
                    </#if>
                        <h4 class="header" style="text-align:center;font-size: 1.4em;position: relative; margin-top: 0;">
                            <span style="border-bottom: 1px solid #1d508d;padding: 0 30px 10px 30px;">${translator.translate("paymentInformation", lan)} </span>
                        </h4>
                        <table style="width: 100%;" cellspacing="0" cellpadding="0">
                            <tbody>

                            <#list data.paymentInfo as payment >
                                <tr>
                                    <td style="border-bottom: 1px dashed #1d508d;">
                                        <p><strong>${translator.translate("status", lan)} </strong></p>
                                    </td>
                                    <td style="border-bottom: 1px dashed #1d508d;">
                                        <p>${ translator.translate(payment.paymentStatus, lan) }</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border-bottom: 1px dashed #1d508d;">
                                        <p><strong>${translator.translate("totalPrice", lan)}</strong></p>
                                    </td>
                                    <td style="border-bottom: 1px dashed #1d508d;">
                                        <p>${ payment.totalPrice }</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border-bottom: 1px dashed #1d508d;">
                                        <p><strong>${translator.translate("paymentDate", lan)}</strong></p>
                                    </td>
                                    <td style="border-bottom: 1px dashed #1d508d;">
                                        <#if lan == "fa">
                                            <p>${method.convertToShamsi(payment.paymentDate)}</p>
                                            <#else>
                                                <p>${data.hotelPackageDate.hotelPackageStartDate ?string('dd.MM.yyyy HH:mm:ss')}</p>
                                        </#if>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="border-bottom: 1px dashed #1d508d;">
                                        <p><strong>${translator.translate("referenceCode", lan)}</strong></p>
                                    </td>
                                    <td style="border-bottom: 1px dashed #1d508d;">
                                        <p>${payment.referenceCode }</p>
                                    </td>
                                </tr>
                            </#list>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("paymentId", lan)} </strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p>${ paymentId }</p>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                    </div>

                    <#if lan == "fa">
                    <div class="column" style="width: 40%;float: left;">
                    <#else>
                    <div class="column" style="width: 40%;float: right;">
                    </#if>
                        <h4 class="header" style="text-align:center;font-size: 1.4em;position: relative; margin-top: 0;">
                            <span style="border-bottom: 1px solid #1d508d;padding: 0 30px 10px 30px;">${translator.translate("agencyInformation", lan)}</span>
                        </h4>
                        <table style="width: 100%;" cellspacing="0" cellpadding="0">
                            <tbody>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("name", lan)}</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p>${ data.agencyName }</p>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("tell", lan)}</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p>

                                        <#if data.agencyTell??> ${ data.agencyTell}
                                            <#else>${translator.translate("notPresent", lan)}</#if>
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("fax", lan)} </strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <#if data.agencyFax??> ${data.agencyFax}
                                        <#else>${translator.translate("notPresent", lan)}</#if>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("email", lan)}</strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <#if data.agencyEmail??> ${ data.agencyEmail}
                                        <#else>${translator.translate("notPresent", lan)}</#if>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <p><strong>${translator.translate("address", lan)} </strong></p>
                                </td>
                                <td style="border-bottom: 1px dashed #1d508d;">
                                    <#if data.agencyAddress??> ${data.agencyAddress}
                                        <#else>${translator.translate("notPresent", lan)}</#if>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="row cancellation-policy" style="clear: both;overflow: hidden;position: relative; padding: 0 30px;">
                    <h4 class="header" style="text-align:center;font-size: 1.4em;position: relative; margin-top: 0;">
                        <span style="border-bottom: 1px solid #1d508d;padding: 0 30px 10px 30px;">${translator.translate("cancellationPolicy", lan)}</span>
                    </h4>
                    <p>
                        ${ data.cancellationPolicy }
                    </p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>