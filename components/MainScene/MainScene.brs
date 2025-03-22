' ***************************************************
' *** init()
' ***************************************************
function init() as void
    m.viewStack = []
    m.views = m.top.FindNode("views")
    m.mainView = m.views.CreateChild("MainView")
    m.viewStack.Push(m.mainView)
    m.viewList = m.top.FindNode("viewList")
    ' m.trackerUI = m.top.CreateChild("TrackerTask")
end function

' ***************************************************
' *** NavigateTo(viewName)
' ***************************************************
function NavigateTo(viewName as string) as void
    childView = m.views.CreateChild(viewName)
    childView.SetFocus(true)
    m.viewStack.Push(childView)
    m.mainView.visible = false
end function

' ***************************************************
' *** onKeyEvent(key, press)
' ***************************************************
function onKeyEvent(key, press) as boolean
    isHandled = false
    if (press)
        if (key = "back" AND m.mainView.visible = false)
            m.views.RemoveChild(m.viewStack.Pop())
            m.mainView.visible = true
            m.viewList.SetFocus(true)
        end if
        isHandled = true
    end if
    return isHandled
end function
