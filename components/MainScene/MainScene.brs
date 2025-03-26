' ***************************************************
' *** init()
' ***************************************************
function init() as void
    m.viewStack = []
    m.views = m.top.FindNode("views")
    setupMainView()
    ' m.trackerTask = m.top.CreateChild("TrackerTask")
end function

' ***************************************************
' *** setupMainView()
' ***************************************************
function setupMainView() as void
    m.mainView = m.views.CreateChild("MainView")
    m.mainView.id = "MainView"
    m.viewStack.Push(m.mainView)
    m.mainView.SetFocus(true)
end function

' ***************************************************
' *** NavigateTo(viewName)
' ***************************************************
function NavigateTo(viewName as string, data = {} as object) as void
    childView = m.views.CreateChild(viewName)
    childView.CallFunc("onViewCreated", data)
    childView.SetFocus(true)
    m.viewStack.Push(childView)
end function

' ***************************************************
' *** onKeyEvent(key, press)
' ***************************************************
function onKeyEvent(key, press) as boolean
    isHandled = false
    if (press)
        if (key = "back")
            currView = m.viewStack.Peek()
            if (currView.id <> m.mainView.id)
                m.views.RemoveChild(m.viewStack.Pop())
                m.viewStack.Peek().SetFocus(true)
            end if
        end if
        isHandled = true
    end if
    return isHandled
end function
