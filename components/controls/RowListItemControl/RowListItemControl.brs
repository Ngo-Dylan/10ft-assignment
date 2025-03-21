' ***************************************************
' *** init()
' ***************************************************
function init() as void
    m.contentGroup = m.top.FindNode("contentGroup")
    m.contentGroup.scaleRotateCenter = [160, 90]
    m.backplate = m.top.FindNode("backplate")
    m.poster = m.top.FindNode("poster")
    m.poster.ObserveFieldScoped("loadStatus", "onPosterLoadStatusChanged")
    m.title = m.top.FindNode("title")
    m.top.opacity = 0.9
end function

' ***************************************************
' *** onFocusChanged()
' ***************************************************
function onFocusChanged() as void
    hasFocus = m.top.itemHasFocus
    if (hasFocus)
        m.title.repeatCount = -1
    else
        m.title.repeatCount = 0
    end if
end function

' ***************************************************
' *** onItemContentChanged()
' ***************************************************
function onItemContentChanged(event as object) as void
    itemData = event.GetData()
    if (itemData <> invalid)
        m.title.text = itemData.title
        m.poster.uri = itemData.images.tile.url
    end if
end function

' ***************************************************
' *** onPosterLoadStatusChanged()
' ***************************************************
function onPosterLoadStatusChanged() as void
    loadStatus = m.poster.loadStatus
    m.backplate.visible = (loadStatus = "loading" OR loadStatus = "failed")
end function

' ***************************************************
' *** onFocusPercentChanged()
' ***************************************************
function onFocusPercentChanged() as void
    focusPercent = m.top.focusPercent
    scaleX = 1 + 0.1 * focusPercent
    scaleY = 1 + 0.3 * focusPercent
    m.title.opacity = focusPercent
    m.contentGroup.scale = [scaleX, scaleY]
    m.top.opacity = 0.9 + 0.1 * focusPercent
end function

' ***************************************************
' *** onRowFocusPercentChanged()
' ***************************************************
function onRowFocusPercentChanged() as void
end function
