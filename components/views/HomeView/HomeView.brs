' ***************************************************
' *** init()
' ***************************************************
function init() as void
    if (m.viewModel = invalid) m.viewModel = createHomeViewModel(m)
    m.loadingSpinner = m.top.FindNode("loadingSpinner")
    m.list = m.top.FindNode("list")
    m.top.ObserveFieldScoped("focusedChild", "onFocusChanged")
    m.list.ObserveFieldScoped("itemFocused", "onFocusedRowChanged")
    m.refList = []
    m.lastFocusedRow = 0
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
        if (listData.refSets <> invalid AND NOT listData.refSets.IsEmpty())
            m.refList = listData.refSets
        end if
    else
    end if
end function

' ***************************************************
' *** onFocusedRowChanged()
' *** Lazy loading ref rows
' ***************************************************
function onFocusedRowChanged(event as object) as void
    focusedRow = event.GetData()
    if (focusedRow = m.lastFocusedRow) return
    m.lastFocusedRow = focusedRow
    if (m.refList.IsEmpty()) return
    focusedRow = event.GetData()
    currItemCount = m.list.content.GetChildCount()
    if (currItemCount - focusedRow < 4)
        m.viewModel.requestRefData(m.refList.Shift())
    end if
end function

' ***************************************************
' *** updateRefData(data)
' ***************************************************
function updateRefData(data as object) as void
    m.list.content.AppendChild(data)
end function

' ***************************************************
' *** onKeyEvent(key, press)
' ***************************************************
function onKeyEvent(key, press) as boolean
    if (m.loadingSpinner.visible) return true
    isHandled = false
    if (press)
        if (key = "back")
            rowItemFocused = m.list.rowItemFocused
            if (rowItemFocused[1] > 0)
                m.list.jumpToRowItem = [rowItemFocused[0], 0]
                isHandled = true
            else if (rowItemFocused[0] > 0)
                m.list.animateToItem = 0
                isHandled = true
            end if
        end if
    end if
    return isHandled
end function
