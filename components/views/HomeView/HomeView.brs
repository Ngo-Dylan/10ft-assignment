' ***************************************************
' *** init()
' ***************************************************
function init() as void
    if (m.viewModel = invalid) m.viewModel = createHomeViewModel(m)
    m.loadingSpinner = m.top.FindNode("loadingSpinner")
    m.list = m.top.FindNode("list")
    m.top.ObserveFieldScoped("focusedChild", "onFocusChanged")
    setUpLoadingSpinner()
    m.viewModel.requestHomeData()
end function

' ***************************************************
' *** onFocusChanged()
' ***************************************************
function onFocusChanged() as void
    if (m.top.HasFocus())
    end if
end function

' ***************************************************
' *** setUpLoadingSpinner()
' ***************************************************
function setUpLoadingSpinner() as void
    m.loadingSpinner.poster.uri = "pkg:/images/busyspinner.png"
    m.loadingSpinner.poster.width = 100
    m.loadingSpinner.poster.height = 100
    posX = (1920 - 100) / 2
    posY = (1080 - 100) / 2
    m.loadingSpinner.translation = [posX, posY]
    m.loadingSpinner.visible = true
    m.loadingSpinner.control = "start"
end function

' ***************************************************
' *** updateListData(data)
' ***************************************************
function updateListData(listData as object) as void
    m.loadingSpinner.visible = "false"
    m.loadingSpinner.control = "stop"
    if (listData <> invalid)
        m.list.content = listData
        m.list.SetFocus(true)
    else
    end if
end function

' ***************************************************
' *** onKeyEvent(key, press)
' ***************************************************
function onKeyEvent(key, press) as boolean
    isHandled = false
    if (press)
        if (m.loadingSpinner.visible) isHandled = true
    end if
    return isHandled
end function
