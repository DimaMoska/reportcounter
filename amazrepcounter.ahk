#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

;~ начало секции настроек

yournickname := ""
chatlog := "C:\Amazing Games\Amazing Russia\amazing\chatlog.txt"
logfile := "C:\Amazing Games\Amazing Russia\amazing\replog.txt"

;~ yournickname - Ваш ник в игре
;~ chatlog - путь к чатлогу Amazing RP
;~ logfile - путь к файлу логирования репортов. необходимо где нибудь создать txt файл и вставить путь
;~ секция настроек завершена







answered := []
Loop{
;inputbox, latestline
latestline := GetNewLine(ChatLog)
	if (RegExMatch(latestline, "\[(A|Новичок)\] (?:{66CC00})?(Вопрос|Жалоба) от (.*) \[(.*)\]: (?:{FFA722})?(.*)", idPl)) {
		askplayerid := idPl4
		reporttext := idPl5
		plnick := idPl3
		answered[askplayerid] := [false, plnick, reporttext]
		SoundPlay, repsound.wav
	}


	if (RegExMatch(latestline, "(.*?) ?(Администратор|Агент поддержки) (.*) \[(.*)\] для (.*) \[(.*)\]:(.*)", foundthere)) {
		if (answered[foundthere6, 1] = false){
			answered[foundthere6, 1] := true


				if (foundthere3 == yournickname and answered[foundthere6, 2] == foundthere5) {
					formattime, timenow, , H:mm:ss d.MM.yyyy
					toout := "(" . timenow . ")" . "На жалобу/вопрос игрока " . foundthere5 . " [" . foundthere6 . "]" . " Вы первым ответили:" . foundthere7 . "`nЖалоба/вопрос игрока: " . answered[foundthere6, 3]
					FileAppend,
					(
					%toout%

					), %logfile%
					RegRead, counter, HKCU, SOFTWARE\mr.redolitmc\reportcounter, reports
					if (ErrorLevel = 1) {
						counter := 0
						ErrorLevel := 0
				}
					counter := counter + 1
					RegWrite, REG_DWORD, HKCU, SOFTWARE\mr.redolitmc\reportcounter, reports, %counter%
				}
				else if (foundthere3 == yournickname) {
					formattime, timenow, , H:mm:ss d.MM.yyyy
					toout := "(" . timenow . ")" . "На жалобу/вопрос игрока " . foundthere5 . " [" . foundthere6 . "]" . " Вы ответили:" . foundthere7 . "`nЖалобу/вопрос оставлял игрок с другим ником: " . answered[foundthere6, 2] . ". Жалоба/вопрос игрока: " . answered[foundthere6, 3]
					FileAppend,
					(
					%toout%

					), %logfile%
				}

		}
		else if (answered[foundthere6, 1] = true){
			if (foundthere3 == yournickname and answered[foundthere6, 2] == foundthere5) {
				formattime, timenow, , H:mm:ss d.MM.yyyy
				toout := "(" . timenow . ")" . "На жалобу/вопрос игрока " . foundthere5 . " [" . foundthere6 . "]" . " Вы ответили:" . foundthere7 . " // Репорт уже отвечен администратором/агентом поддержки" . "`nЖалоба/вопрос игрока: " . answered[foundthere6, 3]
				FileAppend,
				(
				%toout%

				), %logfile%
			}
			else if (foundthere3 == yournickname) {
				formattime, timenow, , H:mm:ss d.MM.yyyy
				toout := "(" . timenow . ")" . "На жалобу/вопрос игрока " . foundthere5 . " [" . foundthere6 . "]" . " Вы ответили:" . foundthere7 . " // Репорт уже отвечен администратором/агентом поддержки" . "`nЖалобу/вопрос оставлял игрок с другим ником: " . answered[foundthere6, 2] . ". Жалоба/вопрос игрока: " . answered[foundthere6, 3]
				FileAppend,
				(
				%toout%

				), %logfile%
			}

		}
		else if (foundthere3 == yournickname) {
		formattime, timenow, , H:mm:ss d.MM.yyyy
			toout := "(" . timenow . ")" . "На жалобу/вопрос игрока " . foundthere5 . " [" . foundthere6 . "]" . " Вы ответили:" . foundthere7 . " // Репорт появился пока игра стояла на паузе или Вы написали игроку первым"
			FileAppend,
			(
			%toout%

			), %logfile%

		}
	}
}





:?:.репорты::
RegRead, counter, HKCU, SOFTWARE\mr.redolitmc\reportcounter, reports
	if (ErrorLevel = 1) {
	MsgBox, Счётчик репортов пуст или отсутствует доступ.
	ErrorLevel := 0
	}
	else {
	amogus := "Вы первым ответили на " . counter . " репорт(-а,-ов)."
	Msgbox, % amogus
	}
return

:?:.settings::
Inputbox, devcommand, Developer mode, Введите команду для режима разработчика
if (devcommand = "setcounter"){
Inputbox, aboba, Developer mode, Введите новое значение счётчика
RegWrite, REG_DWORD, HKCU, SOFTWARE\mr.redolitmc\reportcounter, reports, %aboba%
RegRead, aboba2, HKCU, SOFTWARE\mr.redolitmc\reportcounter, reports
msgbox, % "Значение счётчика: " . aboba2
}
return


GetNewLine(filename)
{
static old
static new
if !old
{
FileGetSize, old, %filename%
new := old
}
while old = new
{
sleep 100
FileGetSize, new, %filename%
}
old := new
Loop, read, %filename%
if A_LoopReadLine
{
last := A_LoopReadLine
}
return last
}
