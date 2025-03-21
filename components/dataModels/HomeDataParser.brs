' ***************************************************
' *** parseGenericData(response)
' ***************************************************
function parseGenericData(response as object) as object
    containers = response?.data?.StandardCollection?.containers
    if (containers = invalid) return invalid

    data = CreateObject("roSGNode", "ContentNode")
    for each row in containers
        if (row.set.refId = invalid)
            rowData = data.CreateChild("ContentNode")
            rowData.title = row.set.text.title.full.set.default.content
            items = row.set.items
            for each item in items
                itemData = rowData.CreateChild("ContentNode")
                itemData.AddFields({
                    "contentId": item.contentId,
                    "images": getImages(item)
                    "title": getProgramTitle(item)
                })
            end for
        end if
    end for
    return data
end function

' ***************************************************
' *** getProgramTitle(item, fallbackValue)
' ***************************************************
function getProgramTitle(item as object, fallbackValue = "No Information Available" as string) as string
    titleType = item?.text?.title?.full
    if (titleType = invalid) return fallbackValue
    if (item.type = "DmcSeries")
        title = titleType.series?.default?.content
    else if (item.type = "StandardCollection")
        title = titleType.collection?.default?.content
    else if (item.type = "DmcVideo")
        title = titleType.program?.default?.content
    end if
    if (title = invalid or title.Trim() = "") return fallbackValue
    return title
end function

' ***************************************************
' *** getImages(item)
' ***************************************************
function getImages(item as object) as object
    return { "tile": getTileImage(item) }
end function

' ***************************************************
' *** getTileImage(item, ratio)
' ***************************************************
function getTileImage(item as object, ratio = "1.78" as string) as object
    tileImageData = item?.image?.tile?[ratio]
    if (tileImageData = invalid)
        url = "pkg:/"
    else
        if (item.type = "DmcSeries")
            url = tileImageData.series.default.url
        else if (item.type = "StandardCollection")
            url = tileImageData.default.default.url
        else if (item.type = "DmcVideo")
            url = tileImageData.program.default.url
        end if
    end if
    return { "url": url }
end function
