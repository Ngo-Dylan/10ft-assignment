' ***************************************************
' *** parseGenericData(response)
' ***************************************************
function parseGenericData(response as object) as object
    containers = response?.data?.StandardCollection?.containers
    if (containers = invalid) return invalid

    data = CreateObject("roSGNode", "ContentNode")
    refSets = []
    for each row in containers
        if (row.set.refId = invalid)
            rowData = data.CreateChild("ContentNode")
            rowData.title = getRowTitle(row)
            items = row.set.items
            for each item in items
                itemData = rowData.CreateChild("ContentNode")
                itemData.AddFields({
                    "contentId": item.contentId,
                    "images": getImages(item),
                    "title": getProgramTitle(item),
                    "ratings": getRatings(item),
                    "releaseDate": getReleaseDate(item)
                })
            end for
        else
            refSets.Push(getRefRowData(row))
        end if
    end for
    if (NOT refSets.IsEmpty()) data.AddFields({ "refSets": refSets })
    return data
end function

' ***************************************************
' *** getRefRowData(row)
' ***************************************************
function getRefRowData(row as object) as object
    setData = row?.set
    if (setData = invalid) return {}
    data = {
        "refId": setData.refId,
        "refType": setData.refType,
        "title": getRowTitle(row)
    }
    return data
end function

' ***************************************************
' *** getRowTitle(row)
' ***************************************************
function getRowTitle(row as object, fallbackValue = "No Information Available" as string) as string
    title = row?.set?.text?.title?.full?.set?.default?.content
    if (title = invalid or title.Trim() = "") return fallbackValue
    return title
end function

' ***************************************************
' *** parseRefData(response, refType, title)
' ***************************************************
function parseRefData(response as object, refType as string, rowTitle as string) as object
    items = response?.data?[refType]?.items
    if (items = invalid) items = response?.data?["CuratedSet"]?.items
    if (items = invalid) return invalid

    rowData = CreateObject("roSGNode", "ContentNode")
    rowData.title = rowTitle
    for each item in items
        itemData = rowData.CreateChild("ContentNode")
        itemData.AddFields({
            "contentId": item.contentId,
            "images": getImages(item),
            "title": getProgramTitle(item),
            "ratings": getRatings(item),
            "releaseDate": getReleaseDate(item)
        })
    end for
    return rowData
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
    return {
        "tile": getTileImage(item),
        "background": getBackgroundImage(item)
    }
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

' ***************************************************
' *** getBackgroundImage(item, ratio)
' ***************************************************
function getBackgroundImage(item as object, ratio = "1.78" as string) as object
    backgroundImageData = item?.image?.hero_collection?[ratio]
    if (backgroundImageData = invalid)
        url = "pkg:/"
    else
        if (item.type = "DmcSeries")
            url = backgroundImageData.series.default.url
        else if (item.type = "StandardCollection")
            url = backgroundImageData.default.default.url
        else if (item.type = "DmcVideo")
            url = backgroundImageData.program.default.url
        end if
    end if
    return { "url": url }
end function

' ***************************************************
' *** getRatings(item)
' ***************************************************
function getRatings(item as object) as string
    value = item?.ratings?[0]?.value
    if (value = invalid) value = ""
    return value
end function

' ***************************************************
' *** getReleaseDate(item)
' ***************************************************
function getReleaseDate(item as object) as string
    date = item?.releases?[0]?.releaseDate
    if (date = invalid)
        date = ""
    else
        date = "First released: " + date
    end if
    return date
end function
