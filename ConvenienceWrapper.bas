option explicit

global g_hWnd       as long
global captionPart_ as string
global className_   as string
global windowText_  as string

function GetwindowText_(hWnd as long) as long ' {
    dim retVal      as long
    dim windowText  as string

    GetwindowText_ = space(GetWindowTextLength(hWnd) + 1)
    retVal         = GetWindowText(hWnd, windowText, len(windowText))
    GetWindowText_ = left$(GetwindowText_, retVal)

end function ' }

function GetClassName_(hWnd as long) as string ' {
    dim windowClass as string * 256
    dim retVal      as long

    retVal = GetClassName(hWnd, windowClass, 255)
'   windowClass = left(windowClass, retVal)
    GetClassName_ = left(windowClass, retVal)

 '  GetClassName_ = windowClass

end function ' }

function FindWindow_WindowNameContains(captionPart as string) as long ' {
    captionPart_ = captionPart
    call EnumWindows(addressOf FindWindow_WindowNameContains_cb, byVal 0&)
    FindWindow_WindowNameContains = g_hWnd
end function ' }

function FindWindow_WindowNameContains_cb(byVal hWnd as long, byVal lParam as long) as long ' {

    dim windowText  as string
    dim windowClass as string * 256
    dim retVal      as long

    windowText = space(GetWindowTextLength(hWnd) + 1)
    retVal     =       GetWindowText(hWnd, windowText, len(windowText))
    windowText = left$(windowText, retVal)

    if inStr(1, windowText, captionPart_, vbTextCompare) then

       g_hWnd = hWnd

     '
     ' We have found a Window, the iteration
     ' process can be stopped
     '
       FindWindow_WindowNameContains_cb = false
       exit function

    end if

    FindWindow_WindowNameContains_cb = true

end function ' }

function FindWindow_ClassName(className as string) as long ' {
    captionPart_ = className
    g_hWnd = 0
    call EnumWindows(addressOf FindWindow_ClassName_cb, byVal 0&)
    FindWindow_ClassName = g_hWnd
end function ' }

function FindWindow_ClassName_cb(byVal hWnd as long, byVal lParam as long) as long ' {

    dim windowText  as string
    dim windowClass as string * 256
    dim retVal      as long

    if GetClassName_(hWnd) = captionPart_ then

       g_hWnd = hWnd
       FindWindow_ClassName_cb = false
       exit function

    end if

    FindWindow_ClassName_cb = true

end function ' }

function FindWindow_ClassName_WindowText(className as string, windowText as string) as long ' {
    className_  = className
    windowText_ = windowText
    g_hWnd = 0
    call EnumWindows(addressOf FindWindow_ClassName_WindowText_cb, byVal 0&)
    FindWindow_ClassName_WindowText = g_hWnd
end function ' }

function FindWindow_ClassName_WindowText_cb(byVal hWnd as long, byVal lParam as long) as long ' {

    if GetClassName_(hWnd) = className_ and GetWindowText_(hWnd) = windowText_  then

       g_hWnd = hWnd
       FindWindow_ClassName_WindowText_cb = false
       exit function

    end if

    FindWindow_ClassName_WindowText_cb = true

end function ' }

function GetWindowRect_(hWnd as long) as RECT ' {
    dim r as RECT
    GetWindowRect hWnd, r
    GetWindowRect_ = r
end function ' }
