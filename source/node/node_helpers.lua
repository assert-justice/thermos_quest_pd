import "common"
import "node"
import "select"
import "title"

function newTitleCardNode(titleText, descriptionText, options)
    local node = Node()
    -- add title component
    local title = Title(0, 30, 400, 100, titleText)
    node:addComponent("title", title)
    local description = Title(10, 50, 380, 100, descriptionText)
    description.align = kTextAlignment.left
    node:addComponent("description", description)
    -- add select component
    local select = Select(50, 160, 300, 68, options)
    node:addComponent("select", select)
    return node
end

function newTitleTextNode(titleText, descriptionText, options)
    local node = Node()
    -- add title component
    local title = Title(0, 10, 400, 100, titleText)
    node:addComponent("title", title)
    local description = Title(10, 30, 380, 120, descriptionText)
    description.align = kTextAlignment.left
    node:addComponent("description", description)
    -- add select component
    local select = Select(50, 160, 300, 68, options)
    node:addComponent("select", select)
    return node
end

function newQuipNode(titleText, descriptionText, options)
    local node = Node()
    -- add title component
    local title = Title(0, 10, 400, 30, titleText)
    node:addComponent("title", title)
    local description = Title(10, 30, 380, 180, descriptionText)
    description.align = kTextAlignment.left
    node:addComponent("description", description)
    -- add select component
    local select = Select(50, 210, 300, 30, options)
    node:addComponent("select", select)
    return node
end

function newTitleNode(titleText, options)
    local node = Node()
    local title = Title(0, 10, 400, 100, titleText)
    node:addComponent("title", title)
    -- add select component
    local select = Select(50, 100, 300, 140, options)
    node:addComponent("select", select)
    return node
end

function newTextNode(descriptionText, options)
    local node = Node()
    local description = Title(0, 30, 400, 130, descriptionText)
    description.align = kTextAlignment.left
    node:addComponent("description", description)
    -- add select component
    local select = Select(50, 160, 300, 68, options)
    node:addComponent("select", select)
    return node
end