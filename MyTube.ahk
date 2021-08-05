#NoEnv  ; Gelecekteki AutoHotkey sürümleriyle performans ve uyumluluk için önerilir.
SetWorkingDir %A_ScriptDir%  ; Tutarlı bir başlangıç ​​dizini sağlar.
#SingleInstance, force
#Persistent

Gui, +hwndhGui +AlwaysOnTop +ToolWindow -Theme
Gui, Color, 0d0d0d, 333333
Gui, Add,ActiveX, x5 y30 w453.5 h255.1 vWB, Shell.Explorer
Gui, Font, s8 ca1ffd0 Bold, Verdana
Gui, Add,Edit, x5 y5 w389 h20 vMyEdit gBaslik,
Gui, Add,Button, x+5 y5 w60 h20 gPlay, Play
Gui, Show, xCenter yCenter w463.5 h290.1, MYTube
Return

Baslik:
	GuiControlGet, MyEdit
Tittle = %MyEdit%
Gui, Show, xCenter yCenter w463.5 h290.1, % YouTubeTitle(Tittle)

YouTubeTitle(url1) {
	hObject := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	hObject.Open("GET", url1)
	hObject.Send()
	RegExMatch(hObject.ResponseText, "(?<=title>).*?(?= - YouTube</title>)", title)
	return title
}
Return

Play:

	Clipboard =
	varEnd =
	GuiControlGet, MyEdit
	Output := StrReplace(MyEdit, A_Tab, "https://www.youtube.com/embed/")
	Output := StrReplace(Output, "https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/")
	Output := StrReplace(Output, "https://www.youtube.com/watch?v=", "https://www.youtube.com/embed/")
	Loop, Parse, Output, `n, `r
	{
		Trimmed := RTrim(A_LoopField, "/")
		varEnd .= Trimmed "`n"
	}

	Clipboard = %varEnd%

url = %Clipboard%?autoplay=1&feature=oembed&rel="0"&frameborder="0"&allowfullscreen
WB.Navigate(URL)
Return

GuiClose:
ExitApp
Return