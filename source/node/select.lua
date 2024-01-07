import "common"
import "component"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class("Select").extends(Component)

function Select:init(x, y, width, height, options, cellHeight)
    if cellHeight == nil then cellHeight = gfx.getSystemFont():getHeight() end
    Select.super.init(self, x, y, width, height)
    self.options = options
    self.parent = nil
    self.filteredOptions = {}
    local filteredOptions = self.filteredOptions

    self.gridview = pd.ui.gridview.new(0, cellHeight)
    self.gridview:setCellPadding(2, 2, 2, 2)

    self.gridview.backgroundImage = gfx.nineSlice.new("images/gridBackground", 7, 7, 18, 18)
    self.gridview:setContentInset(5, 5, 5, 5)

    self.gridviewSprite = gfx.sprite.new()
    self.gridviewSprite:setCenter(0, 0)
    self.gridviewSprite:moveTo(self.x, self.y)

    function self.gridview:drawCell(section, row, column, selected, x, y, width, height)
        if selected then
            gfx.fillRoundRect(x, y, width, height, 4)
            gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        else
            gfx.setImageDrawMode(gfx.kDrawModeCopy)
        end
        local fontHeight = gfx.getSystemFont():getHeight()
        gfx.drawTextInRect(filteredOptions[row]:getText(), x, y + 2, width, height, nil, nil, kTextAlignment.center)
    end
end

function Select:resize(x, y, width, height)
    Select.super.init(self, x, y, width, height)
    self.gridviewSprite:moveTo(self.x, self.y)
    self:redraw()
end

function Select:redraw()
    local gridviewImage = gfx.image.new(self.width, self.height)
    gfx.pushContext(gridviewImage)
        self.gridview:drawInRect(0, 0, self.width, self.height)
    gfx.popContext()
    self.gridviewSprite:setImage(gridviewImage)
end

function Select:update(blockInput)
    if not blockInput then self:_handleInput() end

    if self.gridview.needsDisplay then
        self:redraw()
    end
end

function Select:_handleInput()
    if pd.buttonJustPressed(pd.kButtonUp) then
        self.gridview:selectPreviousRow(true)
    elseif pd.buttonJustPressed(pd.kButtonDown) then
        self.gridview:selectNextRow(true)
    end

    local crankTicks = pd.getCrankTicks(2)
    if crankTicks == 1 then
        self.gridview:selectNextRow(true)
    elseif crankTicks == -1 then
        self.gridview:selectPreviousRow(true)
    end

    if pd.buttonJustPressed(pd.kButtonA) then
        -- find selected option
        local section,row,colum = self.gridview:getSelection()
        local op = self.filteredOptions[row]
        op:use()
        self.parent:navigate(op:getDest())
    end
end

function Select:mount()
    local count = 0
    self.gridview:setSelection(1,1,1)
    self.gridview:setScrollPosition(0,0)
    self.filteredOptions[1] = nil
    for idx,op in ipairs(self.options) do
        if op:isVisible() then
            count += 1
            self.filteredOptions[count] = op
            self.filteredOptions[count+1] = nil
        end
    end
    self.gridview:setNumberOfRows(count)
    self.gridviewSprite:add()
end

function Select:unmount()
    self.gridviewSprite:remove()
end
