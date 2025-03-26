' ***************************************************
' *** init()
' ***************************************************
function init() as void
    if (m.viewModel = invalid) m.viewModel = createHomeViewModel(m)
    m.loadingSpinner = m.top.FindNode("loadingSpinner")
    m.list = m.top.FindNode("list")
    m.errorMessage = m.top.FindNode("errorMessage")
    m.top.ObserveFieldScoped("focusedChild", "onFocusChanged")
    m.list.ObserveFieldScoped("itemFocused", "onFocusedRowChanged")
    m.list.ObserveFieldScoped("rowItemSelected", "onItemSelected")
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
        if (m.list.content <> invalid) m.list.SetFocus(true)
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
        showErrorMessage()
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
    if (data = invalid) return
    m.list.content.AppendChild(data)
end function

' ***************************************************
' *** onItemSelected(event)
' ***************************************************
function onItemSelected(event as object) as void
    rowItemSelected = event.GetData()
    rowIndex = rowItemSelected[0]
    itemIndex = rowItemSelected[1]
    rowNode = m.list.content.GetChild(rowIndex)
    itemNode = rowNode.GetChild(itemIndex)
    itemData = itemNode.GetFields()
    m.scene.CallFunc("NavigateTo", "ProgramDetailView", itemData)
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

' ***************************************************
' *** showErrorMessage()
' ***************************************************
function showErrorMessage() as void
    m.errorMessage.text = "Service Unavailable. Please, try again later!"
    posX = (1920 - m.errorMessage.BoundingRect().width) / 2
    posY = (1080 - m.errorMessage.BoundingRect().height) / 2
    m.errorMessage.translation = [posX, posY]
    m.errorMessage.visible = true
end function
