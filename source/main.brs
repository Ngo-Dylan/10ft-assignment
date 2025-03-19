function Main() as void
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.SetMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.Show()

    while(true)
        msg = Wait(0, m.port)
        msgType = Type(msg)
        if (msgType = "roSGScreenEvent")
            if (msg.IsScreenClosed()) return
        end if
    end while
end function
