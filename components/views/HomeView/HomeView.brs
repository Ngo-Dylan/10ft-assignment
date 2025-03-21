' ***************************************************
' *** init()
' ***************************************************
function init() as void
    m.loadingSpinner = m.top.FindNode("loadingSpinner")
    m.list = m.top.FindNode("list")
    setUpLoadingSpinner()
    setupHomeService()
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
' *** setupHomeService()
' ***************************************************
function setupHomeService() as void
    m.retrieveData = CreateObject("roSGNode", "HomeServiceTask")
    m.retrieveData.ObserveFieldScoped("response", "updateListData")
    m.retrieveData.control = "RUN"
end function

' ***************************************************
' *** updateListData(event)
' ***************************************************
function updateListData(event as object) as void
    m.loadingSpinner.visible = "false"
    m.loadingSpinner.control = "stop"
    listData = event.GetData()
    if (listData <> invalid)
        m.list.content = listData
        m.list.SetFocus(true)
    else
    end if
end function
